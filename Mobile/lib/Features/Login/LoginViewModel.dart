import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  Future<void> login() async {
    try {
      await Auth0Connector.instance.auth0
          .webAuthentication(useCredentialsManager: true)
          .login(useHTTPS: true);
    } catch (e) {
      print(e);
    }
    AppState().setAppState(UIOAppState.home);
  }
}
