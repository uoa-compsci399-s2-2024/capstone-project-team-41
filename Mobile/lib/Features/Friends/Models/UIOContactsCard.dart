import 'package:RemindMate/Features/Friends/Models/UIOContactsCardFriend.dart';
import 'package:RemindMate/Features/Friends/Models/UIOContactsCardType.dart';
import 'package:intl/intl.dart';

final class UIOContactsCard {
  String title;
  UIOContactsCardType cardType;
  List<UIOContactsCardFriend> friends;
  DateTime dateTime;
  bool showTime;

  UIOContactsCard(
      {required this.title,
      required this.cardType,
      required this.friends,
      required this.dateTime,
      required this.showTime});
  
  String getDateTimeAsString(String format) {
    return DateFormat(format).format(dateTime);
  }
  
}
