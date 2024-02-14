import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Login/Login.dart';

import '../../Router/Routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // final splashDelay = 2;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _loadWidget();
  // }
  //
  // _loadWidget() async {
  //   var _duration = Duration(seconds: splashDelay);
  //   return Timer(_duration, checkFirstSeen);
  // }
  //
  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _introSeen = (prefs.getBool('intro_seen') ?? false);
  //
  //   //Navigator.pop(context);
  //   if (_introSeen) {
  //     Navigator.pushNamed(context, Routes.dashboard);
  //   } else {
  //     await prefs.setBool('intro_seen', true);
  //
  //     Navigator.pushNamed(context, Routes.login);
  //   }
  // }
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();

    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Login(
                      mobile: '',
                    ))));
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 266,
                    width: 261,
                    margin: const EdgeInsets.only(
                        left: 77, right: 76, top: 237, bottom: 297),
                    child: Image.asset("assets/images/splash/yopee_logo.png"),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       left: 136, right: 136, top: 515, bottom: 236),
                  //   height: 49,
                  //   width: 142,
                  //   child: const Text(
                  //     "YOPEE",
                  //     style: TextStyle(
                  //         fontFamily: "SemiBold",
                  //         fontSize: 35,
                  //         color: ColorTheme.themeWhiteColor),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
