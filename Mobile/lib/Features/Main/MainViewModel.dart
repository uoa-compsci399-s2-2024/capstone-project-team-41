import 'dart:async';

import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ContactType.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Domain/GrpcConnector/ExampleGrpcConnector.dart';
import 'package:RemindMate/Domain/GrpcConnector/Message.pbgrpc.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
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
        ..birthday = "2003-12-23"
        ..email = "test@test.com"
        ..name = "John Doe"
        ..phoneNumber = "+64 2345 654"
        ..notes = ""
        ..timezone = "NZDT"
        ..type = ContactType.friend
        ..reminders = List.of([
          ContactReminder()
            ..name = "Lunch"
            ..startTime = DateTime.fromMillisecondsSinceEpoch(1727712000000)
            ..endTime = DateTime.fromMillisecondsSinceEpoch(1727722800000)
            ..showTime = true
            ..reminderType = ReminderType.event
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
    }
  }
}
