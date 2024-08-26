class SelectedContactRepo {
  SelectedContactRepo._privateConstructor();

  static final SelectedContactRepo _instance =
      SelectedContactRepo._privateConstructor();

  static SelectedContactRepo get instance => _instance;

  int _selectedContactId = 0;

  int getSelectedContactId() {
    return _selectedContactId;
  }

  void setSelectedContactId(int id) {
    _selectedContactId = id;
  }
}
