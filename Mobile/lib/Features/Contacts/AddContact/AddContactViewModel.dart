import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ContactType.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class AddContactViewModel extends ChangeNotifier {
  String name = "";
  String notes = "";
  String phone = "";
  String email = "";
  String timeZone = "NZDT";
  DateTime birthDay = DateTime.now();
  bool isCatchup = false;
  List<DropdownMenuItem<String>> catchUpPeriods = [
    const DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
    const DropdownMenuItem(value: "Quarterly", child: Text("Quarterly")),
    const DropdownMenuItem(value: "Bi-Yearly", child: Text("Bi-Yearly")),
  ];
  String selectedPeriod = "Monthly";

  Future<void> saveContact() async {
    final database = DatabaseConnector.instance.isar;
    final currentContacts = await database.contacts.where().findAll();

    if (currentContacts.where((c) => c.name == name).isNotEmpty) {
      throw ErrorDescription("Friend with this name already exists");
    }

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
    DateTime nextBirthday =
        DateTime(DateTime.now().year, birthday.month, birthday.day);
    if (nextBirthday.compareTo(DateTime.now().add(Duration(days: -1))) < 0) {
      nextBirthday =
          DateTime(DateTime.now().year + 1, birthday.month, birthday.day);
    }

    List<ContactReminder> reminders = contact.reminders!.toList();
    String nameTrimmed = contactName.trim();
    reminders.add(ContactReminder()
      ..name = "$nameTrimmed Birthday"
      ..startTime = nextBirthday
      ..endTime = nextBirthday.add(const Duration(hours: 11, minutes: 59))
      ..showTime = true
      ..reminderType = ReminderType.event
      ..id = const Uuid().v4()
      ..isRecurring = true
      ..recurringInterval = 1
      ..recurringIntervalUnit = "years");

    if (isCatchup) {
      int interval = 1;

      switch (selectedPeriod) {
        case "Monthly": interval = 1;
        case "Quarterly": interval = 3;
        case "Bi-Yearly": interval = 6;
      }

      DateTime catchUp = DateTime(DateTime.now().year, DateTime.now().month + interval, DateTime.now().day, 10, 00);

      reminders.add(ContactReminder()
      ..name = "Catch up with $contactName"
      ..startTime = catchUp
      ..endTime = catchUp.add(const Duration(hours: 12))
      ..showTime = true
      ..reminderType = ReminderType.event
      ..id = const Uuid().v4()
      ..isRecurring = true
      ..recurringInterval = interval
      ..recurringIntervalUnit = "Months"
      );
    }

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
