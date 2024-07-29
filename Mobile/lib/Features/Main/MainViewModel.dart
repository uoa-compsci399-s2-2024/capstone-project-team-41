import 'dart:async';

import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  late UIOAppState _appState;

  StreamSubscription<UIOAppState>? streamSubscription;
  UIOAppState get appState => _appState;

  MainViewModel() {
    _appState = AppState().appState;
    updateAppState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  void updateAppState() {
    streamSubscription =
        AppState().appStateController.stream.listen((appState) {
      _appState = appState;
      notifyListeners();
    });
  }
}
