import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ContactType.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart' as rt;
import 'package:RemindMate/Domain/GrpcConnector/RemindMate.pb.dart';
import 'package:RemindMate/Domain/GrpcConnector/RemindMateGrpcConnector.dart';
import 'package:RemindMate/Domain/Notifications/NotificationService.dart';
import 'package:grpc/grpc.dart';
import 'package:isar/isar.dart';
import 'package:fixnum/fixnum.dart' as fixnum;

class DatabaseSync {
  Future<void> init() async {
    if (await Auth0Connector.instance.auth0.credentialsManager
        .hasValidCredentials()) {
      await populateDatabase();
      observeDatabaseChanges();
    }
  }

  Future<void> observeDatabaseChanges() async {
    final database = DatabaseConnector.instance.isar;
    Stream<void> contactsChanged = database.contacts.watchLazy();
    contactsChanged.listen((contacts) {
      updateBackend();
    });
  }

  Future<void> updateBackend() async {
    final credentials =
        await Auth0Connector.instance.auth0.credentialsManager.credentials();
    final database = DatabaseConnector.instance.isar;
    final request = UpdateMyDataRequest();

    for (final contact in await database.contacts.where().findAll()) {
      List<FriendReminders> reminders = [];

      for (final reminder in contact.reminders!) {
        reminders.add(FriendReminders(
            title: reminder.name,
            startDateTime:
                fixnum.Int64(reminder.startTime!.millisecondsSinceEpoch),
            endDateTime: fixnum.Int64(reminder.endTime!.millisecondsSinceEpoch),
            showTime: reminder.showTime,
            reminderType: ReminderType.EVENT,
            reminderId: reminder.id,
            recurringReminder: reminder.isRecurring,
            interval: fixnum.Int64(reminder.recurringInterval!),
            intervalUnit: reminder.recurringIntervalUnit));
      }

      request.friends.add(Friend(
          name: contact.name,
          email: contact.email,
          phone: contact.phoneNumber,
          birthday: contact.birthday,
          relationship: RelationshipType.FRIEND,
          timezone: contact.timezone,
          notes: contact.notes,
          reminders: reminders));
    }

    request.fcmToken = fcmToken;

    await RemindMateGrpcConnector.instance.remindMateServiceClient.updateMyData(
        request,
        options: CallOptions(metadata: {"authorization": credentials.idToken}));
  }

  Future<void> populateDatabase() async {
    final credentials =
        await Auth0Connector.instance.auth0.credentialsManager.credentials();
    var data = await RemindMateGrpcConnector.instance.remindMateServiceClient
        .getMyData(GetMyDataRequest(),
            options:
                CallOptions(metadata: {"authorization": credentials.idToken}));

    print(data);

    final database = DatabaseConnector.instance.isar;
    await database.writeTxn(() async {
      await database.clear();
      for (final contact in data.friends) {
        List<ContactReminder> reminders = [];
        for (final reminder in contact.reminders) {
          reminders.add(
            ContactReminder()
              ..name = reminder.title
              ..startTime = DateTime.fromMillisecondsSinceEpoch(
                  reminder.startDateTime.toInt())
              ..endTime = DateTime.fromMillisecondsSinceEpoch(
                  reminder.endDateTime.toInt())
              ..showTime = reminder.showTime
              ..id = reminder.reminderId
              ..reminderType = rt.ReminderType.event
              ..recurringInterval = reminder.interval.toInt()
              ..recurringIntervalUnit = reminder.intervalUnit
              ..isRecurring = reminder.recurringReminder,
          );
        }

        ContactType contactType = ContactType.friend;

        switch (contact.relationship.name) {
          case "FRIEND":
            {
              contactType = ContactType.friend;
            }
        }

        await database.contacts.put(Contact()
          ..birthday = contact.birthday
          ..email = contact.email
          ..name = contact.name
          ..phoneNumber = contact.phone
          ..notes = contact.notes
          ..timezone = contact.timezone
          ..type = contactType
          ..reminders = reminders);
      }
    });
  }
}
