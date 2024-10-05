import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';
import 'package:intl/intl.dart';

final class UIOReminderCard {
  late String id;
  late String title;
  late UIOReminderCardType cardType;
  late UIOContact contact;
  late DateTime dateTime;
  late DateTime dateEndTime;
  late bool showTime;
  late bool isRecurring;
  late int recurringInterval;
  late String recurringUnit;

  UIOReminderCard(
      {required this.id,
      required this.title,
      required this.cardType,
      required this.contact,
      required this.dateTime,
      required this.dateEndTime,
      required this.showTime,
      required this.isRecurring,
      required this.recurringInterval,
      required this.recurringUnit,});

  UIOReminderCard.db(ContactReminder reminder, UIOContact uioContact) {
    this.id = reminder.id!;
    this.title = reminder.name!;
    switch (reminder.reminderType) {
      case null:
        this.cardType = UIOReminderCardType.calender;
      case ReminderType.event:
        this.cardType = UIOReminderCardType.calender;
    }

    this.contact = uioContact;
    this.dateTime = reminder.startTime!;
    this.dateEndTime = reminder.endTime!;
    this.showTime = reminder.showTime!;
    this.isRecurring = reminder.isRecurring!;
    this.recurringInterval = reminder.recurringInterval!;
    this.recurringUnit = reminder.recurringIntervalUnit!;
  }

  String getStartDateTimeAsString(String format) {
    return DateFormat(format).format(dateTime);
  }

  String getEndDateTimeAsString(String format) {
    return DateFormat(format).format(dateEndTime);
  }
}
