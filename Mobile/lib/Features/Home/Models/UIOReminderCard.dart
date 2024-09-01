import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardFriend.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';
import 'package:intl/intl.dart';

final class UIOReminderCard {
  late String title;
  late UIOReminderCardType cardType;
  late List<UIOReminderCardFriend> friends;
  late DateTime dateTime;
  late bool showTime;

  UIOReminderCard(
      {required this.title,
      required this.cardType,
      required this.friends,
      required this.dateTime,
      required this.showTime});

  UIOReminderCard.db(ContactReminder reminder) {
    this.title = reminder.name!;
    switch (reminder.reminderType) {
      case null:
        this.cardType = UIOReminderCardType.calender;
      case ReminderType.event:
        this.cardType = UIOReminderCardType.calender;
    }

    this.friends = [];
    this.dateTime = reminder.startTime!;
    this.showTime = reminder.showTime!;
  }

  String getDateTimeAsString(String format) {
    return DateFormat(format).format(dateTime);
  }
}
