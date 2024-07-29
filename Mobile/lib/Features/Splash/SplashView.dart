import 'package:flutter/material.dart';
import 'package:untitled/Features/Main/AppState.dart';
import 'package:untitled/Features/Main/Models/UIOAppState.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (Center(
            child: TextButton(
      child: Text("Login"),
      onPressed: () => {AppState().setAppState(UIOAppState.login)},
    ))));
  }
}
