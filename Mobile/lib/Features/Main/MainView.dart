import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Features/Home/HomeView.dart';
import 'package:untitled/Features/Login/LoginView.dart';
import 'package:untitled/Features/Main/MainViewModel.dart';
import 'package:untitled/Features/Main/Models/UIOAppState.dart';
import 'package:untitled/Features/Splash/SplashView.dart';

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
      }
    }));
  }
}
