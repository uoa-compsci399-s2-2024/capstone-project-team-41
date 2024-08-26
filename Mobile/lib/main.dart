import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Features/Contacts/Contact/ContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/List/ContactsViewModel.dart';
import 'package:RemindMate/Features/Login/LoginViewModel.dart';
import 'package:RemindMate/Features/Main/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Domain/GrpcConnector/ExampleGrpcConnector.dart';
import 'Features/Main/MainView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Always initialize the grpc connector
  ExampleGrpcConnector().init();
  DatabaseConnector().init();
  Auth0Connector().init();
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
          ChangeNotifierProvider(create: (context) => ContactViewModel())
        ],
        child: MaterialApp(
          title: 'Remind Mate',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MainView(),
        ));
  }
}
