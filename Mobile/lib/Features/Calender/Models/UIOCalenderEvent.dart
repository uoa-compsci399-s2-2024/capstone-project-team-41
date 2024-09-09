import 'package:RemindMate/Domain/Database/Models/Contact.dart';

class UIOCalenderEvent {
  late String name;
  late DateTime startTime;
  late DateTime endTime;

  UIOCalenderEvent(ContactReminder reminder) {
    this.name = reminder.name!;
    startTime = reminder.startTime!;
    endTime = reminder.endTime!;
  }
}
