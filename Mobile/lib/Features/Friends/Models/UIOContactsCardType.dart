import 'package:RemindMate/Features/Views/Images.dart';

enum UIOContactsCardType {
  calender;

  String get mainIcon {
    switch (this) {
      case UIOContactsCardType.calender:
        return Images.calenderIcon;
    }
  }
}
