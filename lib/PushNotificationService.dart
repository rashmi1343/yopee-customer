import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class PushNotificationService {
  // FirebaseMessaging _fcm = FirebaseMessaging.instance;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initialize() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null && navigatorKey.currentContext != null) {
        showDialog(
            context: navigatorKey.currentContext!,
            builder: (_) => AlertDialog(
                  title: Text(message.notification!.title!),
                  content: Text(message.notification!.body!),
                ));
      }
    });

    // Get the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await messaging.getToken();
    print('Token: $token');
    return token;
  }
}
