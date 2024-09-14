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
    final database = DatabaseConnector.instance.isar;
    await database.writeTxn(() async {
      await database.clear();

      await database.contacts.put(Contact()
        ..birthday = "1985-11-02"
        ..email = "dummy1@example.com"
        ..name = "Bob Johnson"
        ..phoneNumber = "+44 777-5678"
        ..notes = "Loves hiking"
        ..timezone = "GMT"
        ..type = ContactType.friend
        ..reminders = List.of([
          ContactReminder()
            ..name = "Peer Coding session"
            ..startTime = DateTimes.daysAway2
            ..endTime = DateTimes.daysAway2.add(Duration(hours: 1))
            ..showTime = true
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "Anniversary"
            ..startTime = DateTimes.daysAway3
            ..endTime = DateTimes.daysAway3.add(Duration(hours: 2))
            ..showTime = true
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "Hiking trip"
            ..startTime = DateTimes.sept20
            ..endTime = DateTimes.sept20.add(Duration(hours: 1))
            ..showTime = true
            ..reminderType = ReminderType.event,
        ]));

      await database.contacts.put(Contact()
        ..birthday = "1964-07-13"
        ..email = "dummy2@example.com"
        ..name = "Peter Simpson"
        ..phoneNumber = "+44 658-4467"
        ..notes = "Hates being called on his birthday."
        ..timezone = "GMT"
        ..type = ContactType.friend
        ..reminders = List.of([
          ContactReminder()
            ..name = "Work drinks"
            ..startTime = DateTimes.oct12
            ..endTime = DateTimes.oct12.add(Duration(hours: 1))
            ..showTime = true
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "IOU beers"
            ..startTime = DateTimes.sept26
            ..endTime = DateTimes.sept26.add(Duration(hours: 1))
            ..showTime = true
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "Rugby game"
            ..startTime = DateTimes.sept24.add(Duration(days: 1))
            ..endTime = DateTimes.sept24.add(Duration(days: 1, hours: 2))
            ..showTime = true
            ..reminderType = ReminderType.event,
        ]));

      await database.contacts.put(Contact()
        ..birthday = "1985-11-02"
        ..email = "dummy2@example.com"
        ..name = "My Wife"
        ..phoneNumber = "+44 777-5678"
        ..notes = "Doesn't like arguing"
        ..timezone = "GMT"
        ..type = ContactType.friend
        ..reminders = List.of([
          ContactReminder()
            ..name = "Dinner Date"
            ..startTime = DateTimes.oct03
            ..endTime = DateTimes.oct03.add(Duration(hours: 1))
            ..showTime = true
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "Anniversary"
            ..startTime = DateTimes.oct01
            ..endTime = DateTimes.oct01.add(Duration(hours: 1))
            ..showTime = true
            ..reminderType = ReminderType.event,
          ContactReminder()
            ..name = "Doctor Appointment"
            ..startTime = DateTimes.daysAway2
            ..endTime = DateTimes.daysAway2.add(Duration(hours: 1))
            ..showTime = true
            ..reminderType = ReminderType.event,
        ]));
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
      exampleRequest();
      populateDatabase();
    }
  }
}
