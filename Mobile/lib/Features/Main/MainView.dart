import 'package:RemindMate/Features/Calender/CalenderView.dart';
import 'package:RemindMate/Features/Contacts/AddContact/AddContactView.dart';
import 'package:RemindMate/Features/Contacts/Contact/ContactView.dart';
import 'package:RemindMate/Features/Contacts/Reminder/AddReminderView.dart';
import 'package:RemindMate/Features/Login/LoginView.dart';
import 'package:RemindMate/Features/Main/MainViewModel.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Splash/SplashView.dart';
import 'package:RemindMate/Features/TabBar/RootTabBarView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<MainViewModel>(builder: (context, viewModel, child) {
      switch (viewModel.appState) {
        case UIOAppState.splash:
          return const SplashView();
        case UIOAppState.login:
          return const LoginView();
        case UIOAppState.home:
          return RootTabBarView();
        case UIOAppState.contact:
          return const ContactView();
        case UIOAppState.addReminder:
          return const AddReminderView();
        case UIOAppState.addContact:
          return const AddContactView();
        case UIOAppState.calendar:
          return const CalenderView();
      }
    }));
  }
}
