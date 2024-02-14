import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yopee_customer/Presenter/YopeeProvider.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Menu/MoreMenu.dart';
import 'package:yopee_customer/View/Subscription/Subscription.dart';

import '../Utility/ColorTheme.dart';
import '../View/Menu/Reports.dart';

int bottomSelectedIndex = 0;

List<BottomNavigationBarItem> buildBottomNavBarItems() {
  return [
    BottomNavigationBarItem(
      icon: Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xffF5F5F5)),
        child: Container(
          height: 17,
          width: 16,
          margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
          child: SvgPicture.asset("assets/images/dashboard/home.svg",
              color: ColorTheme.themeDarkGrayColor),
        ),
      ),
      label: 'Home',
      activeIcon: Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xff007BFF)),
        child: Container(
          height: 17,
          width: 16,
          margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
          child: SvgPicture.asset("assets/images/dashboard/home.svg",
              color: ColorTheme.themeWhiteColor),
        ),
      ),
    ),
    BottomNavigationBarItem(
        icon: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffF5F5F5)),
          child: Container(
            height: 17,
            width: 16,
            margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
            child: SvgPicture.asset("assets/images/dashboard/history.svg",
                color: ColorTheme.themeDarkGrayColor),
          ),
        ),
        activeIcon: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff007BFF)),
          child: Container(
            height: 17,
            width: 16,
            margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
            child: SvgPicture.asset("assets/images/dashboard/history.svg",
                color: ColorTheme.themeWhiteColor),
          ),
        ),
        label: 'Report'),
    BottomNavigationBarItem(
        icon: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffF5F5F5)),
          child: Container(
            height: 17,
            width: 16,
            margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
            child: SvgPicture.asset("assets/images/dashboard/Complete.svg",
                color: ColorTheme.themeDarkGrayColor),
          ),
        ),
        activeIcon: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff007BFF)),
          child: Container(
            height: 17,
            width: 16,
            margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
            child: SvgPicture.asset("assets/images/dashboard/Complete.svg",
                color: ColorTheme.themeWhiteColor),
          ),
        ),
        label: 'Subscription'),
    BottomNavigationBarItem(
        icon: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffF5F5F5)),
          child: Container(
            height: 17,
            width: 16,
            margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
            child: SvgPicture.asset("assets/images/dashboard/Page.svg",
                color: ColorTheme.themeDarkGrayColor),
          ),
        ),
        activeIcon: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff007BFF)),
          child: Container(
            height: 17,
            width: 16,
            margin: EdgeInsets.only(left: 9.5, right: 8.5, top: 8, bottom: 9),
            child: SvgPicture.asset("assets/images/dashboard/Page.svg",
                color: ColorTheme.themeWhiteColor),
          ),
        ),
        label: 'More')
  ];
}

Widget bottomBar(BuildContext context, YopeeProvider provider) {
  return Container(
    height: 73,
    child: BottomNavigationBar(
      unselectedLabelStyle: const TextStyle(
          color: Colors.black, fontSize: 12.5, fontFamily: "Medium"),
      selectedLabelStyle: const TextStyle(
          color: Color(0xff007BFF), fontSize: 12.5, fontFamily: "Medium"),
      iconSize: 16,
      selectedItemColor: Color(0xff007BFF),
      unselectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) {
        if (index == 0) {
          Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Dashboard(),
                    // transitionsBuilder: (BuildContext context,
                    //     Animation<double> animation,
                    //     Animation<double> secondaryAnimation,
                    //     Widget child) {
                    //   return new SlideTransition(
                    //     position: new Tween<Offset>(
                    //       //Left to right
                    //       // begin: const Offset(-1.0, 0.0),
                    //       // end: Offset.zero,
                    //
                    //       //Right to left
                    //       // begin: const Offset(1.0, 0.0),
                    //       // end: Offset.zero,
                    //
                    //       //top to bottom
                    //       // begin: const Offset(0.0, -1.0),
                    //       // end: Offset.zero,
                    //
                    //       //   bottom to top
                    //       // begin: Offset(0.0, 1.0),
                    //       // end: Offset.zero,
                    //     ).animate(animation),
                    //     child: child,
                    //   );
                    // }
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, page) {
                      var begin = 0.0;
                      var end = 1.0;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return ScaleTransition(
                        scale: animation.drive(tween),
                        child: page,
                      );
                    },
                  )));
          //() => Navigator.of(context).pushNamed('/dashboard'));
        } else if (index == 1) {
          provider.reportNavFromMenu = false;
          Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Reports(),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        //Left to right
                        // begin: const Offset(-1.0, 0.0),
                        // end: Offset.zero,

                        //Right to left
                        // begin: const Offset(1.0, 0.0),
                        // end: Offset.zero,

                        //top to bottom
                        // begin: const Offset(0.0, -1.0),
                        // end: Offset.zero,

                        //   bottom to top
                        begin: Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }
                  // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                  //   var begin = 0.0;
                  //   var end = 1.0;
                  //   var curve = Curves.ease;
                  //
                  //   var tween =
                  //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  //   return ScaleTransition(
                  //     scale: animation.drive(tween),
                  //     child: page,
                  //   );
                  // },
                  )));
          // () => Navigator.of(context).pushNamed('/reports'));
        } else if (index == 2) {
          provider.reportNavFromMenu = false;
          provider.setSubsEdit(false);
          provider.setIsSpecialRequest(false);
          provider.setIsService(false);

          Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Subscription(),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        //Left to right
                        // begin: const Offset(-1.0, 0.0),
                        // end: Offset.zero,

                        //Right to left
                        // begin: const Offset(1.0, 0.0),
                        // end: Offset.zero,

                        //top to bottom
                        // begin: const Offset(0.0, -1.0),
                        // end: Offset.zero,

                        //   bottom to top
                        begin: Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }
                  // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                  //   var begin = 0.0;
                  //   var end = 1.0;
                  //   var curve = Curves.ease;
                  //
                  //   var tween =
                  //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  //   return ScaleTransition(
                  //     scale: animation.drive(tween),
                  //     child: page,
                  //   );
                  // },
                  )));
          // () => Navigator.of(context).pushNamed('/subscription'));
        } else if (index == 3) {
          provider.reportNavFromMenu = true;
          provider.subsVehicleSelection = false;
          Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MoreMenu(),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        //Left to right
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,

                        //Right to left
                        // begin: const Offset(1.0, 0.0),
                        // end: Offset.zero,

                        //top to bottom
                        // begin: const Offset(0.0, -1.0),
                        // end: Offset.zero,

                        //   bottom to top
                        // begin: Offset(0.0, 1.0),
                        // end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }
                  // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                  //   var begin = 0.0;
                  //   var end = 1.0;
                  //   var curve = Curves.ease;
                  //
                  //   var tween =
                  //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  //   return ScaleTransition(
                  //     scale: animation.drive(tween),
                  //     child: page,
                  //   );
                  // },
                  )));
          //  () => Navigator.of(context).pushNamed('/moreMenu'));
        }
      },
      type: BottomNavigationBarType.fixed,
      items: buildBottomNavBarItems(),
    ),
  );
}
