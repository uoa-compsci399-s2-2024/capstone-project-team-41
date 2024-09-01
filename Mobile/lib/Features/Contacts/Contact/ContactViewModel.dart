import 'package:RemindMate/Domain/Contact/SelectedContactRepo.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
  UIOContact? contact;
  List<UIOReminderCard> reminders = [];

  ContactViewModel() {
    populateFromDatabase();
  }

  Future<void> populateFromDatabase() async {
    final database = DatabaseConnector.instance.isar;
    var dbContact = await database.contacts
        .get(SelectedContactRepo.instance.getSelectedContactId());
    contact = UIOContact(dbContact!);

    for (final reminder in dbContact.reminders!) {
      reminders.add(UIOReminderCard.db(reminder));
    }

    notifyListeners();
  }
}
