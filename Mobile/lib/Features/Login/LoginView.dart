import 'package:RemindMate/Features/Login/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<LoginViewModel>(builder: (context, viewModel, child) {
      return Center(
          child: ElevatedButton(
              child: const Text("Login"), onPressed: () => viewModel.login()));
    }));
  }
}
