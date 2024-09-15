import 'dart:async';

import 'package:RemindMate/Domain/Contact/SelectedContactRepo.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
  UIOContact? contact;
  List<UIOReminderCard> reminders = [];

  StreamSubscription<int>? streamSubscription;

  ContactViewModel() {
    populateFromDatabase();
    watchChangeOfSelectedContact();
    watchForDatabaseChanges();
  }

  void watchChangeOfSelectedContact() {
    streamSubscription = SelectedContactRepo
        .instance.selectedContactController.stream
        .listen((id) {
      populateFromDatabase();
    });
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
    var dbContact = await database.contacts
        .get(SelectedContactRepo.instance.getSelectedContactId());
    contact = UIOContact(dbContact!);

    reminders = [];
    for (final reminder in dbContact.reminders!) {
      reminders.add(UIOReminderCard.db(reminder, contact!));
    }

    reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    notifyListeners();
  }
}
