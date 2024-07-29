import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/Features/Main/AppState.dart';
import 'package:untitled/Features/Main/Models/UIOAppState.dart';

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
      print(appState);
      _appState = appState;
      notifyListeners();
    });
  }
}
