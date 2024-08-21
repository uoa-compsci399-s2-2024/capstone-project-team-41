import 'package:RemindMate/Features/Friends/FriendsView.dart';
import 'package:RemindMate/Features/Home/HomeView.dart';
import 'package:RemindMate/Features/Login/LoginView.dart';
import 'package:RemindMate/Features/Main/MainViewModel.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Splash/SplashView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<MainViewModel>(builder: (context, viewModel, child) {
      switch (viewModel.appState) {
        case UIOAppState.splash:
          return SplashView();
        case UIOAppState.login:
          return LoginView();
        case UIOAppState.home:
          return HomeView();
        case UIOAppState.friends:
          return FriendsView();
      }
    }));
  }
}
