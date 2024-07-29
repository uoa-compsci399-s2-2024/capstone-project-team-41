import 'package:RemindMate/Features/Main/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Features/Main/MainView.dart';

void main() {
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
        ],
        child: MaterialApp(
          title: 'Remind Mate',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: MainView(),
        ));
  }
}
