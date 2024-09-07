import 'dart:async';
import 'dart:io';

import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ContactType.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Domain/GrpcConnector/ExampleGrpcConnector.dart';
import 'package:RemindMate/Domain/GrpcConnector/Message.pbgrpc.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/DateTimes.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

class MainViewModel extends ChangeNotifier {
  late UIOAppState _appState;

  StreamSubscription<UIOAppState>? streamSubscription;
  UIOAppState get appState => _appState;

  MainViewModel() {
    _appState = AppState().appState;
    updateAppState();
    checkAuthState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  void updateAppState() {
    streamSubscription =
        AppState().appStateController.stream.listen((appState) {
      _appState = appState;
      notifyListeners();
    });
  }

  Future<void> exampleRequest() async {
    try {
      final credentials =
          await Auth0Connector.instance.auth0.credentialsManager.credentials();
      ExampleRequest request = ExampleRequest();
      request.request = "test";
      ExampleResponse response = await ExampleGrpcConnector
          .instance.exampleServiceClient
          .example(request,
              options: CallOptions(
                  metadata: {"authorization": credentials.idToken}));
      print(response.response);
    } on GrpcError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> populateDatabase() async {
    sleep(Duration(seconds: 5));
    final database = DatabaseConnector.instance.isar;
    await database.writeTxn(() async {
      await database.clear();
      await database.contacts.put(Contact()
        ..birthday = "1990-05-15"
        ..email = "dummy1@example.com"
        ..name = "Alice Smith"
        ..phoneNumber = "+1 555-1234"
        ..notes = "Works at TechCorp"
        ..timezone = "PST"
        ..type = ContactType.friend
        ..reminders = List.of([]));

      await database.contacts.put(Contact()
        ..birthday = "1985-11-02"
        ..email = "dummy2@example.com"
        ..name = "Bob Johnson"
        ..phoneNumber = "+44 777-5678"
        ..notes = "Loves hiking"
        ..timezone = "GMT"
        ..type = ContactType.friend
        ..reminders = List.of([
          ContactReminder()
            ..name = "Dinner with family"
            ..startTime = DateTimes.daysAway2
            ..endTime = DateTimes.daysAway3
            ..showTime = true
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "Anniversary"
            ..startTime = DateTimes.daysAway2
            ..endTime = DateTimes.daysAway3
            ..showTime = false
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "Doctor Appointment"
            ..startTime = DateTimes.daysAway2
            ..endTime = DateTimes.daysAway3
            ..showTime = true
            ..reminderType = ReminderType.event,
        ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
      // await database.contacts.put(Contact()
      //   ..birthday = "1990-05-15"
      //   ..email = "dummy1@example.com"
      //   ..name = "Alice Smith"
      //   ..phoneNumber = "+1 555-1234"
      //   ..notes = "Works at TechCorp"
      //   ..timezone = "PST"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Team Meeting"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Project Deadline"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //   ]));

      // await database.contacts.put(Contact()
      //   ..birthday = "1985-11-02"
      //   ..email = "dummy2@example.com"
      //   ..name = "Bob Johnson"
      //   ..phoneNumber = "+44 777-5678"
      //   ..notes = "Loves hiking"
      //   ..timezone = "GMT"
      //   ..type = ContactType.friend
      //   ..reminders = List.of([
      //     ContactReminder()
      //       ..name = "Dinner with family"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727798400000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Anniversary"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727805600000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727812800000)
      //       ..showTime = false
      //       ..reminderType = ReminderType.event,
      //     ContactReminder()
      //       ..name = "Doctor Appointment"
      //       ..startTime = DateTime.fromMillisecondsSinceEpoch(1727820000000)
      //       ..endTime = DateTime.fromMillisecondsSinceEpoch(1727830800000)
      //       ..showTime = true
      //       ..reminderType = ReminderType.event,
      //   ]));
    });
  }

  Future<void> checkAuthState() async {
    if (await Auth0Connector.instance.auth0.credentialsManager
        .hasValidCredentials()) {
      AppState().setAppState(UIOAppState.home);
      exampleRequest();
      populateDatabase();
    } else {
      AppState().setAppState(UIOAppState.login);
    }
  }
}
