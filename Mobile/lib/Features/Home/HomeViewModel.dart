import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class HomeViewModel extends ChangeNotifier {
  List<UIOReminderCard> upcomingReminders = [];
  int remindersLength = 0;

  HomeViewModel() {
    populateFromDatabase();
    watchChanges();
  }

  void watchChanges() {
    final database = DatabaseConnector.instance.isar;
    Stream<void> contactsChanged = database.contacts.watchLazy();
    contactsChanged.listen((contacts) {
      populateFromDatabase();
    });
  }

  Future<void> populateFromDatabase() async {
    upcomingReminders = [];
    final database = DatabaseConnector.instance.isar;
    var dbcontacts = await database.contacts.where().findAll();

    DateTime aWeekFromNow = DateTime.now().add(const Duration(days: 7));

    for (Contact c in dbcontacts) {
      for (ContactReminder r in c.reminders!) {
        if (r.startTime!.compareTo(aWeekFromNow) <= 0) {
          upcomingReminders.add(UIOReminderCard.db(r));
        }
      }
    }

    upcomingReminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    remindersLength = upcomingReminders.length;

    notifyListeners();
  }
}
