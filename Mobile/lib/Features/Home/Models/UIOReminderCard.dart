import 'package:RemindMate/Features/Home/Models/UIOReminderCardFriend.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';

final class UIOReminderCard {
  String title;
  UIOReminderCardType cardType;
  List<UIOReminderCardFriend> friends;
  DateTime dateTime;
  bool showTime;

  UIOReminderCard(
      {required this.title,
      required this.cardType,
      required this.friends,
      required this.dateTime,
      required this.showTime});
}
