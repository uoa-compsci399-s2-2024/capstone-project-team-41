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
  bool isRecurring = true;
  int recurringInterval = 7;
  String recurringIntervalUnit = "days";

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
      ..id = Uuid().v4()
      ..isRecurring = isRecurring
      ..recurringInterval = recurringInterval
      ..recurringIntervalUnit = recurringIntervalUnit);

    if (isRecurring) {
      for (int i = 1; i < 50; i++) {
        switch (recurringIntervalUnit) {
          case "days":
            {
              reminders.add(ContactReminder()
                ..name = title
                ..startTime =
                    startTime.add(Duration(days: recurringInterval * i))
                ..endTime = endTime.add(Duration(days: recurringInterval * i))
                ..showTime = true
                ..reminderType = ReminderType.event
                ..id = Uuid().v4()
                ..isRecurring = isRecurring
                ..recurringInterval = recurringInterval
                ..recurringIntervalUnit = recurringIntervalUnit);
            }
            break;

          case "months":
            {
              reminders.add(ContactReminder()
                ..name = title
                ..startTime = DateTime(
                    startTime.year,
                    startTime.month + (recurringInterval * i),
                    startTime.day,
                    startTime.hour,
                    startTime.minute)
                ..endTime = DateTime(
                    endTime.year,
                    endTime.month + (recurringInterval * i),
                    endTime.day,
                    endTime.hour,
                    endTime.minute)
                ..showTime = true
                ..reminderType = ReminderType.event
                ..id = Uuid().v4()
                ..isRecurring = isRecurring
                ..recurringInterval = recurringInterval
                ..recurringIntervalUnit = recurringIntervalUnit);
            }
            break;

          case "years":
            {
              reminders.add(ContactReminder()
                ..name = title
                ..startTime = DateTime(
                    startTime.year + (recurringInterval * i),
                    startTime.month,
                    startTime.day,
                    startTime.hour,
                    startTime.minute)
                ..endTime = DateTime(endTime.year + (recurringInterval * i),
                    endTime.month, endTime.day, endTime.hour, endTime.minute)
                ..showTime = true
                ..reminderType = ReminderType.event
                ..id = Uuid().v4()
                ..isRecurring = isRecurring
                ..recurringInterval = recurringInterval
                ..recurringIntervalUnit = recurringIntervalUnit);
            }
            break;

          default:
            throw ArgumentError(
                "Unsupported interval unit: $recurringIntervalUnit");
        }
      }
    }

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
