import 'package:RemindMate/Domain/Database/Models/ContactType.dart';

enum UIOContactType {
  friend;

  String get title {
    switch (this) {
      case UIOContactType.friend:
        return "Friend";
    }
  }

  factory UIOContactType.fromDb(ContactType dbType) {
    switch (dbType) {
      case ContactType.friend:
        return UIOContactType.friend;
    }
  }
}
