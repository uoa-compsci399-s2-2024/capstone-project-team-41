import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ContactType.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';

class AddContactViewModel extends ChangeNotifier {
  String name = "";
  String notes = "";
  String phone = "";
  String email = "";
  String timeZone = "NZDT";
  DateTime birthDay = DateTime.now();

  Future<void> saveContact() async {
    final database = DatabaseConnector.instance.isar;

    database.writeTxnSync(() {
      database.contacts.putSync(Contact()
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
  }
}
