import 'dart:async';

import 'package:RemindMate/Domain/Auth/Auth0Connector.dart';
import 'package:RemindMate/Domain/GrpcConnector/RemindMate.pbgrpc.dart';
import 'package:RemindMate/Domain/GrpcConnector/RemindMateGrpcConnector.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grpc/grpc.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  static AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  initNotification() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: DarwinInitializationSettings());

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    FirebaseMessaging.instance.getToken().then((value) {
      updateFcm(value);
      print("TOKEN IS :: :: $value");
    });
  }

  Future<void> updateFcm(String? token) async {
    final credentials =
        await Auth0Connector.instance.auth0.credentialsManager.credentials();
    var data = await RemindMateGrpcConnector.instance.remindMateServiceClient
        .addFcmToken(AddFcmTokenRequest(fcmToken: token),
            options:
                CallOptions(metadata: {"authorization": credentials.idToken}));
  }

  static showLocalNotification(String title, String body, String payload) {
    const androidNotificationDetail = AndroidNotificationDetails(
      '0',
      'general',
      priority: Priority.high,
      autoCancel: false,
      fullScreenIntent: true,
      enableVibration: true,
      importance: Importance.high,
      playSound: true,
    );
    const iosNotificatonDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );
    flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails,
        payload: payload);
  }
}
