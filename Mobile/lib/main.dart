import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/GrpcConnector/RemindMateGrpcConnector.dart';
import 'package:RemindMate/Domain/Notifications/NotificationService.dart';
import 'package:RemindMate/Features/Calender/CalenderViewModel.dart';
import 'package:RemindMate/Features/Contacts/AddContact/AddContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/Contact/ContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/List/ContactsViewModel.dart';
import 'package:RemindMate/Features/Contacts/Reminder/AddReminderViewModel.dart';
import 'package:RemindMate/Features/Home/HomeViewModel.dart';
import 'package:RemindMate/Features/Login/LoginViewModel.dart';
import 'package:RemindMate/Features/Main/MainViewModel.dart';
import 'package:RemindMate/Features/Reminders/RemindersViewModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Domain/GrpcConnector/ExampleGrpcConnector.dart';
import 'Features/Main/MainView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ExampleGrpcConnector().init();
  await RemindMateGrpcConnector().init();
  await DatabaseConnector().init();
  await Auth0Connector().init();
  await Firebase.initializeApp();
  NotificationService.initNotification();
  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(("THIS IS EVENT :: :: $event"));
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainViewModel()),
          ChangeNotifierProvider(create: (context) => LoginViewModel()),
          ChangeNotifierProvider(create: (context) => ContactsViewModel()),
          ChangeNotifierProvider(create: (context) => ContactViewModel()),
          ChangeNotifierProvider(create: (context) => AddRedminderViewModel()),
          ChangeNotifierProvider(create: (context) => AddContactViewModel()),
          ChangeNotifierProvider(create: (context) => CalenderViewModel()),
          ChangeNotifierProvider(create: (context) => RemindersViewModel()),
          ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ],
        child: MaterialApp(
          title: 'Remind Mate',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const MainView(),
        ));
  }
}
