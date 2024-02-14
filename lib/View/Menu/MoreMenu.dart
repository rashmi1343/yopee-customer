import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

import 'package:yopee_customer/Entity/Response/Services/ServicesResponse.dart';
import 'package:yopee_customer/View/Address/saved_address.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Menu/CancellationPolicy.dart';
import 'package:yopee_customer/View/Menu/MyServices.dart';
import 'package:yopee_customer/View/Menu/MySubscription.dart';
import 'package:yopee_customer/View/Menu/Notification.dart';
import 'package:yopee_customer/View/Menu/SpecialRequestScreen.dart';
import 'package:yopee_customer/View/VehicleList.dart';
import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import '../../Utility/Environment.dart';
import 'AboutUs.dart';
import 'Reports.dart';

class MoreMenu extends StatefulWidget {
  MoreMenuState createState() => MoreMenuState();
}

class MoreMenuState extends State<MoreMenu> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);

      provider.getProfileViewApi(context);
      provider.getListNotificationApi("unread", context);
    });
  }

  Future<bool> willPopCallback() async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Dashboard(),
    //   ),
    // );
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
      // transitionsBuilder: (BuildContext
      // context,
      //     Animation<double> animation,
      //     Animation<double>
      //     secondaryAnimation,
      //     Widget child) {
      //   return new SlideTransition(
      //     position: new Tween<Offset>(
      //       //Left to right
      //       begin: const Offset(-1.0, 0.0),
      //       end: Offset.zero,
      //
      //       //Right to left
      //       // begin:
      //       // const Offset(1.0, 0.0),
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
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: page,
        );
      },
    ));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);

    print("imageurl:${provider.objProfileViewResponse.data?.profileImageUrl}");

    // var profileViewItems = provider.objProfileViewResponse.profileViewData;
    // String str = profileViewItems.profileImageUrl;
    // print("imageirl:$str");
    // String substr = "https";
    // String replacement = "http";
    //
    // String newStr = str.replaceAll(substr, replacement);
    // print(newStr);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: willPopCallback,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xff0072C6),
            leading: IconButton(
                iconSize: 29,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  provider.reportNavFromMenu = false;
                  Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Dashboard(),
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
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,

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
                      ));
                }
                //onPressed: () => Navigator.of(context).pushNamed('/dashboard'),
                ),
            actions: [
              IconButton(
                iconSize: 29,
                icon: SvgPicture.asset(
                  "assets/images/edit.svg",
                  color: Colors.white,
                  height: 20,
                  width: 25,
                ),
                onPressed: () {
                  provider.isProfileEdit = true;
                  Navigator.of(context).pushNamed('/profile');
                },
              ),
            ],
          ),
          body: provider.isLoading
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: ColorTheme.themeCircularColor,
                    backgroundColor: ColorTheme.themeLightGrayColor,
                  ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 256,
                                width: double.infinity,
                                decoration:
                                    BoxDecoration(color: Color(0xff0072C6)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 82,
                                      width: 82,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${provider.objProfileViewResponse.data?.profileImageUrl}"),
                                          //whatever image you can put here
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // child: Image.network(
                                      //     // "https://binarymetrix-staging.com/yopee/storage/app/public/257/download.jpg"),
                                      //     provider.objProfileViewResponse
                                      //         .profileViewData.profileImageUrl),
                                    ),
                                    SizedBox(
                                      height: 17,
                                    ),
                                    Container(
                                      child: Text(
                                        "${provider.objProfileViewResponse.data?.name}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "SemiBold",
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        provider
                                            .objProfileViewResponse.data!.mobile
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Medium",
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.only(top: 42),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      MySubscription(),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return new SlideTransition(
                                                      position:
                                                          new Tween<Offset>(
                                                        //Left to right
                                                        // begin: const Offset(-1.0, 0.0),
                                                        // end: Offset.zero,

                                                        //Right to left
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero,

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
                                                  ));
                                          // Navigator.of(context)
                                          //     .pushNamed('/mySubscription');
                                        },
                                        leading: Container(
                                          height: 20,
                                          width: 16,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/subscription.svg"),
                                        ),
                                        title: Text(
                                          "My Subscription",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      MyServices(),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return new SlideTransition(
                                                      position:
                                                          new Tween<Offset>(
                                                        //Left to right
                                                        // begin: const Offset(-1.0, 0.0),
                                                        // end: Offset.zero,

                                                        //Right to left
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero,

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
                                                  ));
                                          // Navigator.of(context)
                                          //     .pushNamed('/mySubscription');
                                        },
                                        leading: Container(
                                          height: 20,
                                          width: 21,
                                          child: Image.asset(
                                            "assets/images/car-service.png",
                                            color: Color(0xff007BFF),
                                          ),
                                        ),
                                        title: Text(
                                          "My Services",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          provider.setIsSpecialRequest(true);
                                          provider.setIsService(false);

                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      SpecialRequestScreen(),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return new SlideTransition(
                                                      position:
                                                          new Tween<Offset>(
                                                        //Left to right
                                                        // begin: const Offset(-1.0, 0.0),
                                                        // end: Offset.zero,

                                                        //Right to left
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero,

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
                                                  ));
                                          // Navigator.of(context)
                                          //     .pushNamed('/specialRequest');
                                        },
                                        leading: Container(
                                          height: 20,
                                          width: 21,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/wash-hands.svg"),
                                        ),
                                        title: Text(
                                          "Special Request",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      SavedAddress(
                                                          vehicleImagePath: "",
                                                          vehicleBrandName: "",
                                                          vehicleModelName: "",
                                                          vehicleTypeName: "",
                                                          vehicleRegNo: "",
                                                          vehicleId: "",
                                                          subscriptionId: "",
                                                          subscriptionPrize: 0),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return new SlideTransition(
                                                      position:
                                                          new Tween<Offset>(
                                                        //Left to right
                                                        // begin: const Offset(-1.0, 0.0),
                                                        // end: Offset.zero,

                                                        //Right to left
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero,

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
                                                  ));
                                          // Navigator.of(context)
                                          //     .pushNamed('/savedAddress');
                                        },
                                        leading: Container(
                                          height: 21,
                                          width: 17,
                                          child: SvgPicture.asset(
                                              "assets/images/map-marker.svg"),
                                        ),
                                        title: Text(
                                          "Saved Address",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      AboutUs(),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return new SlideTransition(
                                                      position:
                                                          new Tween<Offset>(
                                                        //Left to right
                                                        // begin: const Offset(-1.0, 0.0),
                                                        // end: Offset.zero,

                                                        //Right to left
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero,

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
                                                  ));
                                          // Navigator.of(context)
                                          //     .pushNamed('/aboutUs');
                                        },
                                        leading: Container(
                                          height: 18,
                                          width: 16,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/user-check.svg"),
                                        ),
                                        title: Text(
                                          "About Us",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          showContactUsDialog(
                                              context, provider);
                                        },
                                        leading: Container(
                                          height: 14,
                                          width: 18,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/Complete.svg"),
                                        ),
                                        title: Text(
                                          "Contact Us",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          print("Share app clicked");
                                          //  onShare(context, provider);
                                        },
                                        leading: Container(
                                          height: 18,
                                          width: 18,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/share.svg"),
                                        ),
                                        title: Text(
                                          "Share App",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      CancellationPolicy(),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return new SlideTransition(
                                                      position:
                                                          new Tween<Offset>(
                                                        //Left to right
                                                        // begin: const Offset(-1.0, 0.0),
                                                        // end: Offset.zero,

                                                        //Right to left
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero,

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
                                                  ));
                                        },
                                        leading: Container(
                                          height: 20,
                                          width: 16,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/subscription.svg"),
                                        ),
                                        title: Text(
                                          "Cancellation Policy",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Medium",
                                              color: Color(0xff2B2B2B)),
                                        ),
                                        trailing: Container(
                                          height: 12,
                                          width: 6.79,
                                          child: SvgPicture.asset(
                                              "assets/images/menu/angle-right.svg"),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 113,
                                                right: 113,
                                                bottom: 30,
                                                top: 62),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xffFFF6F6),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                  ),
                                                  minimumSize: Size(188, 46),
                                                  side: BorderSide(
                                                      color: Color(0xffE32222),
                                                      width: 1)),
                                              onPressed: () {
                                                showLogoutDialog(
                                                    context, provider);
                                                // Navigator.of(context)
                                                //     .pushNamed('/addAddress');
                                              },
                                              child: const Text(
                                                'Logout',
                                                style: TextStyle(
                                                    color: Color(0xffE32222),
                                                    fontSize: 16,
                                                    fontFamily: "SemiBold"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 19, top: 200),
                            elevation: 1,
                            child: Container(
                                constraints: BoxConstraints(
                                    maxHeight: double.infinity,
                                    maxWidth: double.infinity),
                                //width: 374,
                                padding: EdgeInsets.only(
                                    top: 19, bottom: 19, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0xff9E9E9E3A), width: 0.5),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.0, 0.75),
                                      color: Color(0xff0000001A),
                                      blurRadius: 6.0,
                                      spreadRadius: 2.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    Reports(),
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
                                                        Animation<double>
                                                            secondaryAnimation,
                                                        Widget child) {
                                                  return new SlideTransition(
                                                    position: new Tween<Offset>(
                                                      //Left to right
                                                      // begin: const Offset(-1.0, 0.0),
                                                      // end: Offset.zero,

                                                      //Right to left
                                                      begin: const Offset(
                                                          1.0, 0.0),
                                                      end: Offset.zero,

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
                                                ));
                                        // Navigator.of(context).pushNamed('/reports');
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 20.74,
                                            width: 21.06,
                                            // margin: EdgeInsets.only(
                                            //     left: 36.97,
                                            //     top: 20,
                                            //     bottom: 10.26,
                                            //     right: 114.97),
                                            child: SvgPicture.asset(
                                                "assets/images/dashboard/history.svg"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(
                                            //     left: 20, bottom: 17, right: 82),
                                            child: Text(
                                              "Reports",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Medium",
                                                  color: Color(0xff2B2B2B)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        provider.subsVehicleSelection = false;
                                        provider.setIsSpecialRequest(false);
                                        provider.reportNavFromMenu = true;
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    VehicleList(
                                                      id: "",
                                                      price: 0,
                                                      vehicleImagePath: "",
                                                      vehicleBrandName: "",
                                                      vehicleModelName: "",
                                                      vehicleTypeName: "",
                                                      vehicleRegNo: "",
                                                      vehicleId: "",
                                                      serviceId: '',
                                                      serviceName: '',
                                                      image: '',
                                                      longDesc: [], timeDuration: '',
                                                    ),
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
                                                        Animation<double>
                                                            secondaryAnimation,
                                                        Widget child) {
                                                  return new SlideTransition(
                                                    position: new Tween<Offset>(
                                                      //Left to right
                                                      // begin: const Offset(-1.0, 0.0),
                                                      // end: Offset.zero,

                                                      //Right to left
                                                      begin: const Offset(
                                                          1.0, 0.0),
                                                      end: Offset.zero,

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
                                                ));
                                        // Navigator.of(context)
                                        //     .pushNamed('/vehicleList');
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 21,
                                            width: 27,
                                            // margin: EdgeInsets.only(
                                            //     left: 97,
                                            //     top: 20,
                                            //     bottom: 10.26,
                                            //     right: 114.97),
                                            child: SvgPicture.asset(
                                                "assets/images/dashboard/car-solid.svg"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(
                                            //     left: 20, bottom: 17, right: 82),
                                            child: Text(
                                              "Vehicles",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Medium",
                                                  color: Color(0xff2B2B2B)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Environment.notificationStatus == "1"
                                        //     ?
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    NotificationScreen(),
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
                                                        Animation<double>
                                                            secondaryAnimation,
                                                        Widget child) {
                                                  return new SlideTransition(
                                                    position: new Tween<Offset>(
                                                      //Left to right
                                                      // begin: const Offset(-1.0, 0.0),
                                                      // end: Offset.zero,

                                                      //Right to left
                                                      begin: const Offset(
                                                          1.0, 0.0),
                                                      end: Offset.zero,

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
                                                ));
                                        // Navigator.of(context)
                                        //     .pushNamed('/notification');
                                        // : showAlertDialog(
                                        //     provider, context, false);
                                      },
                                      child: Column(
                                        children: [
                                          provider.objListNotificationResponse
                                                  .data.isEmpty
                                              ? Container(
                                                  height: 20.74,
                                                  width: 21.06,
                                                  // margin: EdgeInsets.only(
                                                  //     left: 36.97,
                                                  //     top: 20,
                                                  //     bottom: 10.26,
                                                  //     right: 114.97),
                                                  child: SvgPicture.asset(
                                                      "assets/images/menu/bell.svg"),
                                                )
                                              : Stack(
                                                  children: [
                                                    GestureDetector(
                                                      // onTap: () {
                                                      //   Environment.notificationStatus ==
                                                      //           "1"
                                                      //       ? Navigator.of(context)
                                                      //           .pushNamed(
                                                      //               '/notification')
                                                      //       : showAlertDialog(
                                                      //           provider,
                                                      //           context,
                                                      //           false);
                                                      // },
                                                      child: Container(
                                                        height: 20.74,
                                                        width: 21.06,
                                                        // margin: EdgeInsets.only(
                                                        //     left: 36.97,
                                                        //     top: 20,
                                                        //     bottom: 10.26,
                                                        //     right: 114.97),
                                                        child: SvgPicture.asset(
                                                            "assets/images/menu/bell.svg"),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      width: 22,
                                                      height: 22,
                                                      alignment:
                                                          Alignment.topRight,
                                                      //margin: EdgeInsets.only(top: 5),
                                                      child: Container(
                                                        width: 18,
                                                        height: 18,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.green,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1)),
                                                        child: Center(
                                                          child: Text(
                                                            provider
                                                                .objListNotificationResponse
                                                                .data
                                                                .length
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    "Medium",
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(
                                            //     left: 20, bottom: 17, right: 82),
                                            child: Text(
                                              "Notifications",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Medium",
                                                  color: Color(0xff2B2B2B)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }

  showLogoutDialog(BuildContext context, YopeeProvider provider) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 220,
              width: 374,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xff707070), width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "SemiBold",
                          color: Color(0xff313131)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Do you Really want to logout?",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Medium",
                          color: Color(0xff111111)),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 15, top: 17),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorTheme.themeLightGrayColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            minimumSize: Size(80, 50),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            // Navigator.of(context).pushNamed('/addVehicle');
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: ColorTheme.themeWhiteColor,
                                fontSize: 16,
                                fontFamily: "SemiBold"),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 20, bottom: 15, top: 17),
                        // child: MaterialButton(
                        //   onPressed: () {
                        //     // Navigator.of(context).pop();
                        //
                        //     // Navigator.of(context).pop();
                        //     if (!provider.logoutClicked) {
                        //       provider.logoutClicked = true;
                        //       provider.getLogoutApi(
                        //           Environment.loginMobileNumber, context);
                        //     }
                        //
                        //     //provider.setlogoutClickedEnableButton();
                        //     //  provider.setlogoutClickedDisableButton();
                        //     // Navigator.of(context).pushNamed('/addVehicle');
                        //   },
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(6.0)),
                        //   color: provider.logoutClicked
                        //       ? ColorTheme.themeLightGrayColor
                        //       : Colors.green,
                        //   disabledColor: ColorTheme.themeLightGrayColor,
                        //   height: 50,
                        //   minWidth: 80,
                        //   child: const Text(
                        //     'Logout',
                        //     style: TextStyle(
                        //         color: ColorTheme.themeWhiteColor,
                        //         fontSize: 16,
                        //         fontFamily: "SemiBold"),
                        //   ),
                        // ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),

                            backgroundColor: provider.logoutClicked
                                ? Colors.red
                                : Colors.green,
                            // provider.logoutClicked
                            //     ? Colors.red
                            //     : ColorTheme.themeLightGrayColor,

                            minimumSize: Size(80, 50),
                          ),
                          onPressed: () {
                            if (!provider.logoutClicked) {
                              provider.logoutClicked = true;
                              provider.getLogoutApi(
                                  Environment.loginMobileNumber, context);
                            }
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                color: ColorTheme.themeWhiteColor,
                                fontSize: 16,
                                fontFamily: "SemiBold"),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  showContactUsDialog(BuildContext context, YopeeProvider provider) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                height: 470,
                width: 374,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xff707070), width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 27,
                        bottom: 18,
                        left: 86,
                      ),
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "SemiBold",
                            color: Color(0xff313131)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Medium",
                            color: Color(0xff111111)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Color(0xff707070), width: 1)),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                          key: formKey,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Select Category",
                              hintStyle: TextStyle(
                                  fontFamily: "Medium",
                                  fontSize: 13,
                                  color: Color(0xff555555)),
                              enabledBorder: InputBorder.none,
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select some role';
                              } else {
                                return null;
                              }
                            },
                            items: provider.categoryItemlist.map((item) {
                              return DropdownMenuItem(
                                value: item.name,
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                      fontFamily: "Medium",
                                      fontSize: 13,
                                      color: Color(0xff555555)),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                provider.dropdownvalue = value!;
                              });
                            },
                            value: provider.dropdownvalue,
                          )),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Message",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Medium",
                            color: Color(0xff111111)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                      height: 129,
                      width: 300,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Color(0xff707070), width: 1)),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: provider.messageController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Medium",
                            color: Color(0xff111111)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15, top: 17),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.themeGreenColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0)),
                          minimumSize: Size(374, 56),
                        ),
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/addVehicle');
                          provider.getContactUsApi(
                              provider.dropdownvalue.toString(),
                              provider.messageController.text,
                              context);
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(
                              color: ColorTheme.themeBlackColor,
                              fontSize: 16,
                              fontFamily: "SemiBold"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> showAlertDialog(
      YopeeProvider provider, BuildContext context, bool buttonValue) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Notification',
                    style: TextStyle(
                        fontFamily: "Medium",
                        fontSize: 16,
                        color: ColorTheme.themeDarkBlueColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Do you want to receive notification?',
                      style: TextStyle(
                          fontFamily: "Regular",
                          fontSize: 14,
                          color: ColorTheme.themeCircularColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();

                          provider.getNotificationStatusApi("0", context);
                          provider.pushNotify = false;
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don',
                                style: TextStyle(
                                    fontFamily: "SemiBold",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              TextSpan(
                                text: '\'',
                                style: TextStyle(
                                    fontFamily: "SemiBold",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              TextSpan(
                                text: 't Allow',
                                style: TextStyle(
                                    fontFamily: "SemiBold",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Allow',
                          style: TextStyle(
                              fontFamily: "SemiBold",
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          provider.getNotificationStatusApi("1", context);
                          Environment.notificationStatus = "1";
                          provider.pushNotify = true;
                          Navigator.of(context).pushNamed('/notification');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF6F6FE),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontFamily: "SemiBold",
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // void onShare(BuildContext context, YopeeProvider provider) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   await Share.share(provider.sharetext,
  //       subject: provider.sharelink,
  //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  // }
}
