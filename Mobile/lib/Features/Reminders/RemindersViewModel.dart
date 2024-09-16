import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class RemindersViewModel extends ChangeNotifier {
  Map<String, List<UIOReminderCard>> eventMap = {};
  DateTime selectedTime = DateTime.now();

  RemindersViewModel() {
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

    eventMap = {};

    for (final contact in dbContacts) {
      for (final reminder in contact.reminders!) {
        if (!eventMap.containsKey(reminder.startTime!
            .toIso8601String()
            .split("T")[0]
            .substring(0, 7))) {
          eventMap[reminder.startTime!
              .toIso8601String()
              .split("T")[0]
              .substring(0, 7)] = [];
        }
        eventMap[reminder.startTime!
                .toIso8601String()
                .split("T")[0]
                .substring(0, 7)]
            ?.add(UIOReminderCard.db(reminder, UIOContact(contact)));
      }
    }

    for (String i in eventMap.keys) {
      eventMap[i]!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }

    notifyListeners();
  }

  List<String> sortedEventMappKeys() {
    var keyList = eventMap.keys.toList();
    keyList.sort();
    return keyList;
  }
}
