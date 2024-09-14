import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class CalenderViewModel extends ChangeNotifier {
  Map<String, List<UIOReminderCard>> eventMap = {};
  List<DateTime> uniqueDates = [];
  DateTime selectedTime = DateTime.now();

  CalenderViewModel() {
    populateFromDatabase();
    watchForDatabaseChanges();
  }

  Future<void> watchForDatabaseChanges() async {
    final database = DatabaseConnector.instance.isar;
    Stream<void> contactsChanged = database.contacts.watchLazy();
    contactsChanged.listen((contacts) {
      populateFromDatabase();
    });
  }

  Future<void> populateFromDatabase() async {
    final database = DatabaseConnector.instance.isar;
    var dbContacts = await database.contacts.where().findAll();

    for (final contact in dbContacts) {
      for (final reminder in contact.reminders!) {
        if (!eventMap
            .containsKey(reminder.startTime!.toIso8601String().split("T")[0])) {
          eventMap[reminder.startTime!.toIso8601String().split("T")[0]] = [];
        }
        eventMap[reminder.startTime!.toIso8601String().split("T")[0]]
            ?.add(UIOReminderCard.db(reminder, UIOContact(contact)));
      }
    }

    for (String i in eventMap.keys) {
      DateTime date = DateTime.parse(i);
      if (!uniqueDates.contains(date)) {
        uniqueDates.add(date);
      }
    }

    notifyListeners();
  }

  int getLength() {
    return eventMap[selectedTime.toIso8601String().split("T")[0]]?.length??0;
  }
}
