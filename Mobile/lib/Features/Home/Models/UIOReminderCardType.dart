import 'package:RemindMate/Features/Views/Images.dart';

enum UIOReminderCardType {
  calender;

  String get mainIcon {
    switch (this) {
      case UIOReminderCardType.calender:
        return Images.calenderIcon;
    }
  }
}
