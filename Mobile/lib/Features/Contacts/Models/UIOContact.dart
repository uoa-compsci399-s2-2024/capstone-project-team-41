import 'package:RemindMate/Features/Contacts/Models/UIOContactType.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

class UIOContact {
  String firstName;
  String lastName;
  UIOContactType type;
  String timeZone;
  bool hasNewReminder;
  String? profileImageUrl;

  UIOContact(
      {required this.firstName,
      required this.lastName,
      required this.type,
      required this.timeZone,
      required this.hasNewReminder,
      this.profileImageUrl});

  String getTimeZoneDate() {
    return DateFormat.MMMMd().format(curDateTimeByZone(zone: timeZone));
  }

  String getTimeZoneTime() {
    return "${DateFormat.Hm().format(curDateTimeByZone(zone: timeZone))} $timeZone";
  }
}
