import 'dart:io';

import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  Future<void> login() async {
    try {
      await Auth0Connector.instance.auth0
          .webAuthentication(useCredentialsManager: true)
          .login(
              useHTTPS: true,
              redirectUrl: Platform.isAndroid
                  ? "auth0-remind-mate://dev-omhf4f5ly70nx3i0.us.auth0.com/android/com.uoa.capstone.team41.untitled/callback"
                  : null);
    } catch (e) {
      print(e);
    }
    AppState().setAppState(UIOAppState.home);
  }
}
