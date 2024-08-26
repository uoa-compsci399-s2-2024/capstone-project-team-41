import 'package:RemindMate/Domain/Database/Models/ContactType.dart';
import 'package:RemindMate/Domain/Database/Models/ReminderType.dart';
import 'package:isar/isar.dart';

part 'Contact.g.dart';

@collection
class Contact {
  Id id = Isar.autoIncrement;

  String? name;
  String? email;
  String? phoneNumber;
  String? birthday;
  String? timezone;
  String? notes;

  @Enumerated(EnumType.name)
  ContactType? type;

  List<ContactReminder>? reminders;
}

@embedded
class ContactReminder {
  String? name;
  bool? showTime;
  DateTime? startTime;
  DateTime? endTime;

  @Enumerated(EnumType.name)
  ReminderType? reminderType;
}
