import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';
import 'package:intl/intl.dart';

final class UIOReminderCard {
  late String title;
  late UIOReminderCardType cardType;
  late UIOContact contact;
  late DateTime dateTime;
  late DateTime dateEndTime;
  late bool showTime;

  UIOReminderCard(
      {required this.title,
      required this.cardType,
      required this.contact,
      required this.dateTime,
      required this.dateEndTime,
      required this.showTime});

  UIOReminderCard.db(ContactReminder reminder, UIOContact uioContact) {
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
  }

  String getStartDateTimeAsString(String format) {
    return DateFormat(format).format(dateTime);
  }

  String getEndDateTimeAsString(String format) {
    return DateFormat(format).format(dateEndTime);
  }
}
