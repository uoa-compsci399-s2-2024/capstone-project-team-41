enum UIOContactType {
  friend;

  String get title {
    switch (this) {
      case UIOContactType.friend:
        return "Friend";
    }
  }
}
