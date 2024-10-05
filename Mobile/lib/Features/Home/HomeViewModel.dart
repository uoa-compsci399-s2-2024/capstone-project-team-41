import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class HomeViewModel extends ChangeNotifier {
  List<UIOReminderCard> upcomingReminders = [];
  int remindersLength = 0;
  String username = "";

  HomeViewModel() {
    populateFromDatabase();
    watchChanges();
    getAuthDetails();
  }

  Future<void> getAuthDetails() async {
    final credentials =
        await Auth0Connector.instance.auth0.credentialsManager.credentials();
    username = credentials.user.name ?? "";
    notifyListeners();
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
        if (r.endTime!.compareTo(aWeekFromNow) <= 0) {
          upcomingReminders.add(UIOReminderCard.db(r, UIOContact(c)));
        }
      }
    }

    upcomingReminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    remindersLength = upcomingReminders.length;

    notifyListeners();
  }
}
