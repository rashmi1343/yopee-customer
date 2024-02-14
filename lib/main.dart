import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yopee_customer/Presenter/YopeeProvider.dart';
import 'package:yopee_customer/Router/AppRoutes.dart';
import 'package:path/path.dart' as Path;
import 'package:yopee_customer/View/Splash/SplashScreen.dart';

import 'package:flutter/foundation.dart';

import 'Router/Routes.dart';

// @dart=2.9

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  //await FirebaseMessaging.instance.setAutoInitEnabled(true);
  WidgetsFlutterBinding.ensureInitialized();
  _getId();
  try {
    await Firebase.initializeApp(
        name: "yopee customer",
        options: const FirebaseOptions(
            apiKey: 'AIzaSyAuw1AeOWcsIXy_XRNN10Ae2UU9-_075tg',
            appId: '1:168262005675:android:2afb476954bf6543de18ee',
            messagingSenderId: '168262005675',
            projectId: 'yopee-customer-cc7b3'));
  } catch (e) {
    print("Error initializing firebase:$e");
  }
  // String? token = await FirebaseMessaging.instance.getToken();
  // print("FCM token:$token");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => YopeeProvider()),
  ], child: const MyApp()));
}

Future<String?> getToken(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('Token: $token');
  return token;
}

Future<String?> _getId() async {
  String deviceID;
  String deviceName;
  String deviceVersion;
  String deviceToken;
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceName = iosDeviceInfo.model;
    deviceVersion = iosDeviceInfo.systemVersion.toString();

    print("iosDeviceInfo:$iosDeviceInfo");
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    deviceID = androidDeviceInfo.id;
    print("deviceID:$deviceID");
    deviceName = androidDeviceInfo.model;
    deviceVersion = androidDeviceInfo.version.toString();
    print("androidDeviceInfo:$androidDeviceInfo");
    return androidDeviceInfo.id; // unique ID on Android
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yopee Customer',
      navigatorKey: navigatorKey,
      home: SplashScreen(),
      initialRoute: Routes.splash,
      routes: AppRoutes.routes,
    );
  }
}
