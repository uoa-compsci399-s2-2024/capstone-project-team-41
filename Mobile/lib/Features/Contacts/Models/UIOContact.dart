import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContactType.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

class UIOContact {
  late String name;
  late UIOContactType type;
  late String timeZone;
  late bool hasNewReminder;
  late String phoneNumber;
  late String email;
  late String notes;
  late String birthday;
  late String? profileImageUrl;

  UIOContact(Contact contact) {
    name = contact.name!;
    type = UIOContactType.fromDb(contact.type!);
    timeZone = contact.timezone!;
    hasNewReminder = false;
    phoneNumber = contact.phoneNumber!;
    email = contact.email!;
    notes = contact.notes!;
    birthday = contact.birthday!;
    profileImageUrl = null;
  }

  String getTimeZoneDate() {
    return DateFormat.MMMMd().format(curDateTimeByZone(zone: timeZone));
  }

  String getTimeZoneTime() {
    return "${DateFormat.Hm().format(curDateTimeByZone(zone: timeZone))} $timeZone";
  }
}
