import 'dart:async';

import 'package:RemindMate/Domain/Contact/SelectedContactRepo.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/foundation.dart';
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
    if (dbContact == null) {
      return;
    }
    contact = UIOContact(dbContact);

    reminders = [];

    for (ContactReminder r in dbContact.reminders!) {
      reminders.add(UIOReminderCard.db(r, contact!));
    }

    reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    notifyListeners();
  }

  Future<void> deleteContact(int id) async {
    final database = DatabaseConnector.instance.isar;
    await database.writeTxn(() async {
      await database.contacts.delete(id);
    });
    AppState().setAppState(UIOAppState.home);
  }

  Future<void> deleteReminder(String reminderId, int contactId) async {
    final database = DatabaseConnector.instance.isar;
    Contact? contact = await database.contacts.get(contactId);
    final List<ContactReminder> newReminders = [];
    for (ContactReminder r in contact!.reminders!) {
      if (r.id == reminderId && r.isRecurring!) {
        throw Exception("Unable to delete recurring reminder")l
      }

      if (r.id != reminderId) {
        newReminders.add(r);
      }
    }
    contact.reminders = newReminders;
    await database.writeTxnSync(() async {
      database.contacts.putSync(contact);
    });
  }
}
