import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ContactType.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddContactViewModel extends ChangeNotifier {
  String name = "";
  String notes = "";
  String phone = "";
  String email = "";
  String timeZone = "NZDT";
  DateTime birthDay = DateTime.now();

  Future<void> saveContact() async {
    final database = DatabaseConnector.instance.isar;

    int id = database.writeTxnSync<int>(() {
      return database.contacts.putSync(Contact()
        ..birthday = birthDay.toIso8601String().split("T")[0]
        ..email = email
        ..name = name
        ..phoneNumber = phone
        ..notes = notes
        ..timezone = timeZone
        ..type = ContactType.friend
        ..reminders = List.of([]));
    });
    AppState().setAppState(UIOAppState.home);

    var contact = await database.contacts.get(id);
    String contactName = contact!.name!;
    DateTime birthday = DateTime.parse(contact.birthday!);
    DateTime nextBirthday = DateTime(DateTime.now().year, birthday.month, birthday.day);
    if (nextBirthday.compareTo(DateTime.now().add(Duration(days: -1))) < 0) {
      nextBirthday = DateTime(DateTime.now().year + 1, birthday.month, birthday.day);
    }

    List<ContactReminder> reminders = contact.reminders!.toList();
    reminders.add(ContactReminder()
    ..name = "$contactName's Birthday"
    ..startTime = nextBirthday
    ..endTime = nextBirthday.add(const Duration(hours: 11, minutes: 59))
    ..showTime = true
    ..reminderType = ReminderType.event
    ..id = const Uuid().v4()
    ..isRecurring = true
    ..recurringInterval = 1
    ..recurringIntervalUnit = "years"
    );

    contact.reminders = reminders;

    database.writeTxnSync(() {
      database.contacts.putSync(contact);
    });
  }



  Null updateBirthdayDate(DateTime date) {
    birthDay = date;
    notifyListeners();
  }
}
