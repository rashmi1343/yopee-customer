import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleListResponse.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleTypeResponse.dart';

import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/View/AddVehicle/AddNewVehicle.dart';
import 'package:yopee_customer/View/AddVehicle/CarBrandScreen.dart';
import 'package:yopee_customer/View/Address/AddAddress.dart';
import 'package:yopee_customer/View/Services/Services.dart';
import 'package:yopee_customer/View/Subscription/Subscription.dart';
import 'package:yopee_customer/Widgets/bottom_bar.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/Environment.dart';
import '../Services/Service_detail.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class ImageData {
  final String imagePath;
  bool isSelected;

  ImageData({
    required this.imagePath,
    required this.isSelected,
  });
}

class DashboardState extends State<Dashboard> {
  List<ImageData> imageDataList = [
    ImageData(
      imagePath: "assets/images/dashboard/exterior.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/dashboard/interior.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/dashboard/interior_detailing.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/dashboard/steaming.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/dashboard/paint.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/dashboard/headlight.png",
      isSelected: false,
    ),
  ];

  // List<String> imgList = [
  //   {"url": 'assets/images/banners/banner-1.png', "routeName": "/subscription"},
  //   {"url": 'assets/images/banners/banner2.png', "routeName": "/"},
  //   {"url": 'assets/images/banners/banner3.png', "routeName": "/services"},
  //
  //   //   'assets/images/banners/Rectangle 21.png'
  // ];

  // PageController pageControllelr = PageController(
  //   initialPage: 0,
  //   keepPage: true,
  // );

  // Widget buildPageView() {
  //   return PageView(
  //     controller: pageController,
  //     onPageChanged: (index) {
  //       pageChanged(index);
  //     },
  //     children: <Widget>[
  //       Dashboard(),
  //     ],
  //   );
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);

      // provider.getVehicleTypeListApi(context);

      // vehicleTypeSelectionDialog(context, provider);

      provider.getProfileViewApi(context);
      provider.getCurrentPosition(context);

      provider.getDashboardApi(context);
      provider.getCarServiceListApi(context);
      provider.getVehicleListApi(context);
      //provider.isSpecialRequest = false;

      // Environment.accountDetails =
      //     provider.objProfileViewResponse.data.accountDetails;

      // provider.setProfileAccountDetails(
      //     provider.objDashboardResponse.data.userProfile.accountDetails);
      //
      // //provider.isProfileEdit = true;
      // //  print("account details:${provider.objProfileViewResponse.data.name}");
      //
      // //  if (Environment.profileName.isEmpty || Environment.profileEmail.isEmpty) {

      // SharedPreferences.getInstance().then((prefs) {
      //   final int dialogOpen = prefs.getInt('dialog_open') ?? 0;
      //   if (dialogOpen == 0) {
      //     //show dialog for one time only
      //     Future.delayed(const Duration(milliseconds: 1000), () {
      //       provider.isProfileEdit = true;
      //       showProfileDialog(context, provider);
      //       prefs.setInt("dialog_open", 1);
      //     });
      //   }
      // });

      // if (provider.accountDetails == 0) {
      //   provider.isProfileEdit = true;
      //   showProfileDialog(context, provider);
      // }
      // print(
      //     "account details:${provider.objDashboardResponse.data.userProfile.accountDetails}");

      // print(
      //  "My vehicle  service list :${provider.objVehicleListResponse.data.length}");
    });
  }

  // void pageChanged(int index) {
  //   setState(() {
  //     bottomSelectedIndex = index;
  //   });
  // }
  //
  // void bottomTapped(int index) {
  //   setState(() {
  //     bottomSelectedIndex = index;
  //     pageController.animateToPage(index,
  //         duration: Duration(milliseconds: 500), curve: Curves.ease);
  //   });
  // }
  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Exit App',
              style: TextStyle(
                  fontSize: 16, fontFamily: "SemiBold", color: Colors.black),
            ),
            content: Text(
              'Do you want to exit an App?',
              style: TextStyle(
                  fontSize: 14, fontFamily: "Medium", color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text(
                  'No',
                  style: TextStyle(
                      fontSize: 12, fontFamily: "Regular", color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                //return true when click on "Yes"
                child: Text(
                  'Yes',
                  style: TextStyle(
                      fontSize: 12, fontFamily: "Regular", color: Colors.green),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    CarouselController carouselController = CarouselController();

    final List<Widget> imageSliders = [
      {
        "url": 'assets/images/banners/banner-1.png',
        "routeName": "/subscription"
      },
      {"url": 'assets/images/banners/banner2.png', "routeName": "/reports"},
      {"url": 'assets/images/banners/banner3.png', "routeName": "/services"},

      //   'assets/images/banners/Rectangle 21.png'
    ]
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print('i $item');
                            Navigator.pushNamed(
                              context,
                              item["routeName"].toString(),
                              arguments: item,
                            );
                          },
                          child: Image.asset(
                            item["url"].toString(),
                            fit: BoxFit.fitWidth,
                            width: 384,
                            height: 200,
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    var provider = Provider.of<YopeeProvider>(context, listen: false);

    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
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
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 13.65,
                              margin: EdgeInsets.only(left: 22, top: 20),
                              child: SvgPicture.asset(
                                "assets/images/map-marker.svg",
                                color: Color(0xff007BFF),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.subsAddressSelection = false;
                                provider.reportNavFromMenu = false;
                                provider.showAddressDialog(context);
                                // Navigator.of(context).push(PageRouteBuilder(
                                //     transitionDuration:
                                //         const Duration(milliseconds: 400),
                                //     pageBuilder: (context, animation,
                                //             secondaryAnimation) =>
                                //         AddAddress(
                                //             id: "",
                                //             indexId: "",
                                //             type: "",
                                //             flatHouseNo: "",
                                //             areaSector: "",
                                //             nearBy: "",
                                //             vehicleImagePath: "",
                                //             vehicleBrandName: "",
                                //             vehicleModelName: "",
                                //             vehicleTypeName: "",
                                //             vehicleRegNo: "",
                                //             vehicleId: "",
                                //             subscriptionId: "",
                                //             subscriptionPrize: ""),
                                //     transitionsBuilder: (BuildContext context,
                                //         Animation<double> animation,
                                //         Animation<double> secondaryAnimation,
                                //         Widget child) {
                                //       return new SlideTransition(
                                //         position: new Tween<Offset>(
                                //           //Left to right
                                //           // begin: const Offset(-1.0, 0.0),
                                //           // end: Offset.zero,
                                //
                                //           //Right to left
                                //           // begin: const Offset(1.0, 0.0),
                                //           // end: Offset.zero,
                                //
                                //           //top to bottom
                                //           // begin: const Offset(0.0, -1.0),
                                //           // end: Offset.zero,
                                //
                                //           //   bottom to top
                                //           begin: Offset(0.0, 1.0),
                                //           end: Offset.zero,
                                //         ).animate(animation),
                                //         child: child,
                                //       );
                                //     }
                                //     // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                                //     //   var begin = 0.0;
                                //     //   var end = 1.0;
                                //     //   var curve = Curves.ease;
                                //     //
                                //     //   var tween =
                                //     //       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                //     //   return ScaleTransition(
                                //     //     scale: animation.drive(tween),
                                //     //     child: page,
                                //     //   );
                                //     // },
                                //     ));
                                // Navigator.of(context).pushNamed('/addAddress');
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 13.99, top: 16),
                                height: 36,
                                width: 145,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Other - Add Address\n',
                                    style: TextStyle(
                                        fontFamily: "Medium",
                                        fontSize: 14,
                                        color: Color(0xff333333)),
                                    children: <TextSpan>[
                                      provider.cityName == ""
                                          ? TextSpan(
                                              text: "",
                                              //text: "Delhi",
                                              style: TextStyle(
                                                  fontFamily: "SemiBold",
                                                  fontSize: 14,
                                                  color: ColorTheme
                                                      .themeBlackColor),
                                            )
                                          : TextSpan(
                                              text: provider.cityName,
                                              //text: "Delhi",
                                              style: TextStyle(
                                                  fontFamily: "SemiBold",
                                                  fontSize: 14,
                                                  color: ColorTheme
                                                      .themeBlackColor),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            provider.objVehicleListResponse.data
                                        .totalUserVehicle ==
                                    0
                                ? Container(
                                    margin: EdgeInsets.only(top: 18, right: 5),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                          fontFamily: "Medium"),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Future.delayed(Duration.zero, () {
                                        // _settingVehiclePopUp(
                                        //     context,
                                        //     provider,
                                        //     provider.objVehicleListResponse
                                        //         .data!.userVehicles);
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 18, right: 5),
                                      child: Text(
                                        provider.objVehicleListResponse.data
                                            .totalUserVehicle
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                            fontFamily: "Medium"),
                                      ),
                                    ),
                                  ),
                            GestureDetector(
                              onTap: () {
                                Future.delayed(Duration.zero, () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          CarBrandScreen(
                                              id: "",
                                              userId: "",
                                              carBrandId: "",
                                              carModelId: "",
                                              vehicleTypeId: "",
                                              registrationNo: "",
                                              carBrandName: "",
                                              carModelName: ""),
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
                                      //       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      //   return ScaleTransition(
                                      //     scale: animation.drive(tween),
                                      //     child: page,
                                      //   );
                                      // },
                                      ));
                                  // Navigator.of(context)
                                  //     .pushNamed('/addVehicle');
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 19.29,
                                    margin: EdgeInsets.only(left: 5, top: 18),
                                    child: SvgPicture.asset(
                                      "assets/images/dashboard/car-solid.svg",
                                      color: ColorTheme.themeBlackColor,
                                    ),
                                  ),
                                  Container(
                                    height: 22,
                                    width: 22,
                                    margin: EdgeInsets.only(
                                        right: 21, top: 18, left: 10),
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Color(0xff1183FF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          items: imageSliders,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              height: 22,
                              child: const Text(
                                "Car Services",
                                style: TextStyle(
                                    fontFamily: "SemiBold",
                                    fontSize: 18,
                                    color: Color(0xff001F3F)),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                provider.setSubsEdit(false);
                                provider.setIsService(true);
                                provider.setIsSpecialRequest(false);

                                Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Services(),
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
                                //Navigator.of(context).pushNamed('/services');
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 2.96, right: 20),
                                height: 18,
                                child: const Text(
                                  "View All",
                                  style: TextStyle(
                                      fontFamily: "SemiBold",
                                      fontSize: 14,
                                      color: Color(0xff001F3F)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        provider.objServicesResponse.data!.length == 0
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    "No Service Available!!",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Medium",
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                ),
                                // itemCount: provider.objServicesResponse.data.length,
                                itemCount: provider
                                            .objServicesResponse.data.length >=
                                        6
                                    ? 6
                                    : provider.objServicesResponse.data.length,
                                itemBuilder: (context, index) {
                                  var carServiceItems =
                                      provider.objServicesResponse.data;
                                  int selectedIndex = index;
                                  print(("selectedIndex:$selectedIndex"));

                                  String timeString =
                                      carServiceItems[index].timeDuration;
                                  List<String> timeParts =
                                      timeString.split(':');
                                  int hours = int.parse(timeParts[0]);
                                  int minutes = int.parse(timeParts[1]);
                                  int seconds = int.parse(timeParts[2]);

                                  Duration duration = Duration(
                                      hours: hours,
                                      minutes: minutes,
                                      seconds: seconds);

                                  String formattedTime =
                                      "${duration.inMinutes} mins";

                                  print("formattedTime:$formattedTime");
                                  return Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            // provider.isSpecialRequest = false;
                                            provider.setIsService(true);
                                            provider.setSubsEdit(false);
                                            provider.setIsSpecialRequest(false);
                                            Environment.selectedIndex = index;
                                            print(
                                                "selected address index:${Environment.selectedIndex}");
                                            Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    transitionDuration:
                                                        const Duration(
                                                            milliseconds: 400),
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        ServiceDetail(
                                                          id: carServiceItems[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          name: carServiceItems[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          indexId: Environment
                                                              .selectedIndex
                                                              .toString(),
                                                          price:
                                                              carServiceItems[
                                                                      index]
                                                                  .price,
                                                          longDes: carServiceItems[
                                                                  index]
                                                              .getServiceDetails!,
                                                          serviceDuration:
                                                              formattedTime,
                                                        ),
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
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => ServiceDetail(
                                            //       id: carServiceItems[index]
                                            //           .id
                                            //           .toString(),
                                            //       name: carServiceItems[index]
                                            //           .name
                                            //           .toString(),
                                            //       indexId: Environment.selectedIndex
                                            //           .toString(),
                                            //       price: carServiceItems[index]
                                            //           .price
                                            //           .toString(), longDes: carServiceItems[index].getServiceDetails!,
                                            //     ),
                                            //   ),
                                            // );
                                            // Navigator.of(context)
                                            //     .pushNamed('/services');
                                          },
                                          child: Container(
                                            height: 133,
                                            width: 133,
                                            decoration: BoxDecoration(
                                              // borderRadius:
                                              //     BorderRadius.circular(60.0),
                                              shape: BoxShape.circle,
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xffE3F1FF),
                                                  ColorTheme.themeWhiteColor,
                                                ],
                                              ),
                                            ),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              margin: const EdgeInsets.all(5),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                // image: DecorationImage(
                                                //   fit: BoxFit.fitHeight,
                                                //   image: NetworkImage(
                                                //     carServiceItems[index].icon,
                                                //   ),
                                                // ),
                                              ),
                                              child: Image.network(
                                                carServiceItems[index].icon,
                                                height: 30,
                                                width: 30,
                                                filterQuality:
                                                    FilterQuality.high,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 5),
                                        alignment: Alignment.center,
                                        // height: 38,
                                        child: Text(
                                          carServiceItems[index].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Medium",
                                              fontSize: 11,
                                              color: Color(0xff333333)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        SizedBox(
                          height: 36,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 22,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Happy Customers",
                            style: TextStyle(
                                fontFamily: "SemiBold",
                                fontSize: 18,
                                color: Color(0xff001F3F)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/banners/image.png',
                                    fit: BoxFit.cover,
                                    width: 374,
                                    height: 194,
                                  ),
                                  Positioned(
                                    top: 79,
                                    left: 150,
                                    bottom: 70.3,
                                    child: SvgPicture.asset(
                                      'assets/images/play-circle.svg',
                                      fit: BoxFit.fill,
                                      width: 42.7,
                                      height: 42.7,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        provider.objDashboardResponse.data.rating.data.isEmpty
                            ? Container()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  constraints: BoxConstraints(maxHeight: 130),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 25,
                                        height: 25,
                                        child: SvgPicture.asset(
                                            "assets/images/arrow-left-solid.svg"),
                                      ),
                                      ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: provider.objDashboardResponse
                                            .data.rating.data?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var ratingListItem = provider
                                              .objDashboardResponse
                                              .data
                                              .rating
                                              .data;
                                          return Container(
                                            constraints: BoxConstraints(
                                                maxHeight: double.infinity),
                                            // height: 187,
                                            width: 315,
                                            margin: EdgeInsets.only(right: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Color(0xffF5F5F5)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    ratingListItem[index]
                                                                .user
                                                                .profileImageUrl ==
                                                            ""
                                                        ? Container(
                                                            height: 62,
                                                            width: 62,
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 19,
                                                              top: 15,
                                                            ),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            child: Image.asset(
                                                                "assets/images/menu/profile.png"),
                                                          )
                                                        : Container(
                                                            height: 62,
                                                            width: 62,
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 19,
                                                              top: 15,
                                                            ),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            child:
                                                                Image.network(
                                                              ratingListItem[
                                                                      index]
                                                                  .user
                                                                  .profileImageUrl
                                                                  .toString(),
                                                            ),
                                                          ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ratingListItem[index]
                                                                    .user
                                                                    .name ==
                                                                ""
                                                            ? Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        top: 5),
                                                                child: Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "SemiBold",
                                                                      color: Color(
                                                                          0xff007BFF)),
                                                                ),
                                                              )
                                                            : Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        top: 5),
                                                                child: Text(
                                                                  ratingListItem[
                                                                          index]
                                                                      .user!
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "SemiBold",
                                                                      color: Color(
                                                                          0xff007BFF)),
                                                                ),
                                                              ),
                                                        ratingListItem[index]
                                                                    .rating ==
                                                                0
                                                            ? Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        top: 5),
                                                                child: RatingBar
                                                                    .builder(
                                                                  ignoreGestures:
                                                                      true,
                                                                  initialRating:
                                                                      0,
                                                                  minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemSize: 15,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              1.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          SizedBox(
                                                                    height: 15,
                                                                    width: 15,
                                                                    child: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              )
                                                            : Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        top: 5),
                                                                child: RatingBar
                                                                    .builder(
                                                                  ignoreGestures:
                                                                      true,
                                                                  initialRating:
                                                                      ratingListItem[
                                                                              index]
                                                                          .rating!
                                                                          .toDouble(),
                                                                  minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemSize: 15,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              1.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          SizedBox(
                                                                    height: 15,
                                                                    width: 15,
                                                                    child: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  // margin: EdgeInsets.only(
                                                  //   left: 19,
                                                  // ),
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          double.infinity,
                                                      maxWidth: 100),
                                                  child: Text(
                                                    ratingListItem[index]
                                                        .feedback
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: "Regular",
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff272727)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        width: 25,
                                        height: 25,
                                        child: SvgPicture.asset(
                                            "assets/images/arrow-right-solid.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ),
            bottomNavigationBar: bottomBar(context, provider)),
      );
    });
  }

  Future<void> showProfileDialog(BuildContext context, YopeeProvider provider) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: Container(
              width: 150,
              height: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Please fill Your Profile Details",
                    style: TextStyle(
                        fontFamily: "SemiBold",
                        fontSize: 14,
                        color: ColorTheme.themeDarkBlueColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                          // Fluttertoast.showToast(
                          //     msg: "Please fill your profile details first!!",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.CENTER,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.red,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);
                        },
                        //return false when click on "NO"
                        child: Text(
                          'No',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.isProfileEdit = true;
                          Navigator.of(context).pushNamed('/profile');
                        },

                        //return true when click on "Yes"
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

// List<UserVehicleList> selectedItems = [];
// void _settingVehiclePopUp(
//   BuildContext context,
//   YopeeProvider provider,
//   List<UserVehicleList>? vehicleListItems,
// ) {
//   showModalBottomSheet(
//       useRootNavigator: true,
//       context: context,
//       builder: (BuildContext bc) {
//         return Container(
//           height: 320,
//           margin: EdgeInsets.all(10),
//           width: double.infinity,
//           decoration: BoxDecoration(
//               color: Color(0xffF2F2F2),
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20),
//                   topLeft: Radius.circular(20))),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 // height: 230,
//                 // width: 300,
//                 child: vehicleListItems!.length == 0
//                     ? Center(
//                         child: Container(
//                           child: Text(
//                             "No Vehicles Available!!",
//                             style: TextStyle(
//                                 color: Colors.red,
//                                 fontFamily: "Medium",
//                                 fontSize: 15),
//                           ),
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: vehicleListItems.length,
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         //  physics: ScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder:
//                             (BuildContext context, int sectionIndex) {
//                           print("vehicleListItems:$vehicleListItems");
//                           return ItemCard(
//                             onTap: () {
//                               setState(() {
//                                 if (selectedItems
//                                     .contains(selectedItems[sectionIndex])) {
//                                   selectedItems
//                                       .remove(selectedItems[sectionIndex]);
//                                 } else {
//                                   selectedItems
//                                       .add(selectedItems[sectionIndex]);
//                                 }
//                               });
//                             },
//                             item: selectedItems[sectionIndex],
//                             isSelected: selectedItems
//                                 .contains(selectedItems[sectionIndex]),
//                           );
//                           //   Container(
//                           //   height: 170,
//                           //   width: 187,
//                           //   margin: EdgeInsets.only(
//                           //     left: 10,
//                           //     right: 15,
//                           //     top: 10,
//                           //   ),
//                           //   decoration: BoxDecoration(
//                           //       borderRadius: BorderRadius.circular(6),
//                           //       color: ColorTheme.themeWhiteColor),
//                           //   child: Column(
//                           //     children: [
//                           //       Align(
//                           //         alignment: Alignment.topLeft,
//                           //         child: InkWell(
//                           //           onTap: () {
//                           //             setState(() {
//                           //               if (selectedItems.contains(
//                           //                   vehicleListItems[sectionIndex])) {
//                           //                 selectedItems.remove(
//                           //                     vehicleListItems[sectionIndex]);
//                           //               } else {
//                           //                 selectedItems.add(
//                           //                     vehicleListItems[sectionIndex]);
//                           //               }
//                           //             });
//                           //           },
//                           //           child: vehicleListItems[sectionIndex]
//                           //                       .manageVehicle ==
//                           //                   true
//                           //               ? Container(
//                           //                   height: 22,
//                           //                   width: 22,
//                           //                   margin: EdgeInsets.only(
//                           //                       top: 10, left: 10),
//                           //                   decoration: BoxDecoration(
//                           //                       shape: BoxShape.circle,
//                           //                       color: Color(0xff007BFF)),
//                           //                   child: Container(
//                           //                       height: 10.09,
//                           //                       width: 9,
//                           //                       padding: EdgeInsets.all(5),
//                           //                       child: SvgPicture.asset(
//                           //                         "assets/images/check-solid.svg",
//                           //                         color: Colors.white,
//                           //                       )),
//                           //                 )
//                           //               : Container(
//                           //                   height: 22,
//                           //                   width: 22,
//                           //                   margin: EdgeInsets.only(
//                           //                       top: 10, left: 10),
//                           //                   decoration: BoxDecoration(
//                           //                       shape: BoxShape.circle,
//                           //                       color: Colors.white,
//                           //                       border: Border.all(
//                           //                           color: Color(0xffC2C2C2),
//                           //                           width: 2)),
//                           //                   child: Padding(
//                           //                       padding: const EdgeInsets.all(
//                           //                           10.0),
//                           //                       child: Container()),
//                           //                 ),
//                           //         ),
//                           //       ),
//                           //       Container(
//                           //         height: 35,
//                           //         width: 84,
//                           //         margin: EdgeInsets.only(
//                           //             left: 45,
//                           //             right: 45,
//                           //             top: 15,
//                           //             bottom: 17),
//                           //         child: Image.network(
//                           //           vehicleListItems[sectionIndex]
//                           //               .brand!
//                           //               .image
//                           //               .toString(),
//                           //           errorBuilder: (BuildContext context,
//                           //               Object exception,
//                           //               StackTrace? stackTrace) {
//                           //             Navigator.pushReplacementNamed(
//                           //                 context, '/login');
//                           //             return Container();
//                           //           },
//                           //         ),
//                           //       ),
//                           //       Container(
//                           //         height: 19,
//                           //         margin: EdgeInsets.only(
//                           //             left: 24, right: 24, bottom: 6),
//                           //         child: Text(
//                           //           // "Maruti Celerio ZXi",
//                           //           "${vehicleListItems![sectionIndex].brand!.name} ${vehicleListItems[sectionIndex].model!.name}",
//                           //
//                           //           style: TextStyle(
//                           //               fontSize: 14, fontFamily: "SemiBold"),
//                           //         ),
//                           //       ),
//                           //       Container(
//                           //         height: 19,
//                           //         margin: EdgeInsets.only(
//                           //             left: 60, right: 60, bottom: 10),
//                           //         child: Text(
//                           //           // "DL9CBA7118",
//                           //           "${vehicleListItems![sectionIndex].registrationNo} | ${vehicleListItems[sectionIndex].vehicle!.name}",
//                           //
//                           //           style: TextStyle(
//                           //               fontSize: 12, fontFamily: "Medium"),
//                           //         ),
//                           //       )
//                           //     ],
//                           //   ),
//                           // );
//                         },
//                       ),
//               ),
//               Material(
//                 color: Color(0xffF2F2F2),
//                 child: InkWell(
//                   onTap: () {},
//                   child: Container(
//                     margin: const EdgeInsets.only(
//                         left: 20, right: 20, bottom: 15, top: 17),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ColorTheme.themeGreenColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6.0)),
//                         minimumSize: Size(374, 56),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pushNamed('/vehicleList');
//                       },
//                       child: const Text(
//                         'Manage Your Vehicle',
//                         style: TextStyle(
//                             color: ColorTheme.themeBlackColor,
//                             fontSize: 16,
//                             fontFamily: "SemiBold"),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       });
// }
}

// class ItemCard extends StatelessWidget {
//   final Function onTap;
//   final bool isSelected;
//   final UserVehicleList item;
//   const ItemCard(
//       {required this.onTap, required this.isSelected, required this.item});
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         elevation: 5,
//         backgroundColor: Colors.white,
//       ),
//       onPressed: onTap(),
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 35,
//                   width: 84,
//                   margin:
//                       EdgeInsets.only(left: 45, right: 45, top: 15, bottom: 17),
//                   child: Image.network(
//                     item.brand!.image.toString(),
//                     errorBuilder: (BuildContext context, Object exception,
//                         StackTrace? stackTrace) {
//                       Navigator.pushReplacementNamed(context, '/login');
//                       return Container();
//                     },
//                   ),
//                 ),
//                 Container(
//                   height: 19,
//                   margin: EdgeInsets.only(left: 24, right: 24, bottom: 6),
//                   child: Text(
//                     // "Maruti Celerio ZXi",
//                     "${item.brand!.name} ${item.model!.name}",
//
//                     style: TextStyle(fontSize: 14, fontFamily: "SemiBold"),
//                   ),
//                 ),
//                 Container(
//                   height: 19,
//                   margin: EdgeInsets.only(left: 60, right: 60, bottom: 10),
//                   child: Text(
//                     // "DL9CBA7118",
//                     "${item.registrationNo} | ${item.vehicle!.name}",
//
//                     style: TextStyle(fontSize: 12, fontFamily: "Medium"),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           if (isSelected) // Show tick mark only if item is selected
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Icon(Icons.check_circle, color: Colors.green),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
