import 'package:RemindMate/Domain/Contact/SelectedContactRepo.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class AddRedminderViewModel extends ChangeNotifier {
  String title = "";
  String notes = "";
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  Future<void> saveReminder() async {
    final database = DatabaseConnector.instance.isar;
    var contact = await database.contacts
        .get(SelectedContactRepo.instance.getSelectedContactId());
    var reminders = contact!.reminders!.toList();
    reminders.add(ContactReminder()
      ..name = title
      ..startTime = startTime
      ..endTime = endTime
      ..showTime = true
      ..reminderType = ReminderType.event
      ..id = Uuid().v4());
    contact.reminders = reminders;
    database.writeTxnSync(() {
      database.contacts.putSync(contact);
    });
    AppState().setAppState(UIOAppState.home);
  }

  String getDateTimeString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    return dateFormat.format(dateTime);
  }
}
