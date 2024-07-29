import 'dart:async';

import 'Models/UIOAppState.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  UIOAppState _appState = UIOAppState.splash;
  final appStateController = StreamController<UIOAppState>.broadcast();

  UIOAppState get appState => _appState;

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  void setAppState(UIOAppState appState) {
    _appState = appState;
    appStateController.sink.add(appState);
  }
}
