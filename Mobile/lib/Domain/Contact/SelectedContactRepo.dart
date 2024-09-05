import 'dart:async';

class SelectedContactRepo {
  SelectedContactRepo._privateConstructor();

  static final SelectedContactRepo _instance =
      SelectedContactRepo._privateConstructor();

  static SelectedContactRepo get instance => _instance;
  final selectedContactController = StreamController<int>.broadcast();
  int _selectedContactId = 0;

  int getSelectedContactId() {
    return _selectedContactId;
  }

  void setSelectedContactId(int id) {
    _selectedContactId = id;

    selectedContactController.sink.add(id);
  }
}
