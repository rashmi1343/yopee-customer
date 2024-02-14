import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleListResponse.dart';
import 'package:yopee_customer/View/AddVehicle/AddNewVehicle.dart';
import 'package:yopee_customer/View/AddVehicle/CarBrandScreen.dart';
import 'package:yopee_customer/View/Address/saved_address.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Menu/MoreMenu.dart';
import 'package:yopee_customer/View/Payment/PaymentScreen.dart';
import 'package:yopee_customer/View/Services/Service_detail.dart';
import 'package:yopee_customer/View/Subscription/SubscriptionDetail.dart';

import '../Entity/Response/Subscription/BasicSubscriptionResponse.dart';
import '../Presenter/YopeeProvider.dart';
import '../Utility/ColorTheme.dart';
import '../Utility/Environment.dart';
import 'Address/AddAddress.dart';
import 'Services/Service_address.dart';

enum VehicleOptions { edit, delete }

class VehicleList extends StatefulWidget {
  String id;
  int price;
  String vehicleId;
  String vehicleImagePath;
  String vehicleBrandName;
  String vehicleModelName;
  String vehicleTypeName;
  String vehicleRegNo;
  String serviceId;
  String serviceName;
  String image;
  List<SubscriptionDetails> longDesc;
  String timeDuration;

  VehicleList({
    required this.id,
    required this.price,
    required this.vehicleImagePath,
    required this.vehicleBrandName,
    required this.vehicleModelName,
    required this.vehicleTypeName,
    required this.vehicleRegNo,
    required this.vehicleId,
    required this.serviceId,
    required this.serviceName,
    required this.image,
    required this.longDesc,
    required this.timeDuration,
  });

  VehicleListState createState() => VehicleListState();
}

class VehicleListState extends State<VehicleList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);

      provider.getVehicleListApi(context);
      //  provider.getUserSubscriptionListApi(context);
      //  provider.toggleMyVehicleSelected(-1);
      // print(
      //  "My vehicle  service list :${provider.objVehicleListResponse.data.length}");
    });
  }

  Future<bool> willPopCallback() async {
    Provider.of<YopeeProvider>(context, listen: false).reportNavFromMenu == true
        ? Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => MoreMenu(),
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
                  // begin:
                  // const Offset(1.0, 0.0),
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
            ))
        // Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => MoreMenu(),
        //         ),
        //       )
        : Provider.of<YopeeProvider>(context, listen: false)
                    .subsVehicleSelection ==
                true
            ? Timer(Duration(seconds: 2), () {
                Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SubscriptionDetailScreen(
                          id: widget.id,
                          image: widget.image,
                          longDesc: widget.longDesc,
                          name: widget.serviceName,
                          price: widget.price,
                          timeDuration: widget.timeDuration,
                        ),
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
                          // begin:
                          // const Offset(1.0, 0.0),
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
                    ));
              })
            : Provider.of<YopeeProvider>(context, listen: false)
                        .reportNavFromMenu ==
                    true
                ? Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ServiceDetail(
                          id: "",
                          indexId: "",
                          name: "",
                          price: 0,
                          longDes: [],
                          serviceDuration: '',
                        ),
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
                          // begin:
                          // const Offset(1.0, 0.0),
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
                    ))
                : Provider.of<YopeeProvider>(context, listen: false)
                            .isService ==
                        true
                    ? Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ServiceDetail(
                              id: "",
                              indexId: "",
                              name: "",
                              price: 0,
                              longDes: [],
                              serviceDuration: '',
                            ),
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
                              // begin:
                              // const Offset(1.0, 0.0),
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
                        ))
                    : Navigator.of(context).pushNamedAndRemoveUntil(
                        '/dashboard', (Route<dynamic> route) => false);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    print("service id:${widget.serviceId}");

    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: willPopCallback,
        child: RefreshIndicator(
          onRefresh: () {
            return provider.getVehicleListApi(context);
          },
          child: Scaffold(
            appBar: PreferredSize(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color(0xff00000029),
                    offset: Offset(0, 0.0),
                    blurRadius: 6.0,
                  )
                ]),
                child: AppBar(
                  elevation: 4,
                  shadowColor: Color(0xff00000029),
                  toolbarHeight: 53,
                  leading: IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      // provider.subsVehicleSelection == true?
                      Provider.of<YopeeProvider>(context, listen: false)
                                  .reportNavFromMenu ==
                              true
                          ? Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
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
                              ))
                          // Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => MoreMenu(),
                          //         ),
                          //       )
                          : Provider.of<YopeeProvider>(context, listen: false)
                                      .subsVehicleSelection ==
                                  true
                              ? Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SubscriptionDetailScreen(
                                        id: widget.id,
                                        image: widget.image,
                                        longDesc: widget.longDesc,
                                        name: widget.serviceName,
                                        price: widget.price,
                                        timeDuration: widget.timeDuration,
                                      ),
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
                                        // begin:
                                        // const Offset(1.0, 0.0),
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
                                  ))
                              // Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) =>
                              //                   SubscriptionDetailScreen(
                              //                 id: widget.id,
                              //               ),
                              //             ),
                              //           )
                              : Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/dashboard',
                                  (Route<dynamic> route) => false);
                    },
                  ),
                  centerTitle: true,
                  title: Text(
                    "My Vehicles",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "SemiBold",
                        color: Color(0xff313131)),
                  ),
                  actions: [
                    provider.subsVehicleSelection == true
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      CarBrandScreen(
                                          id: '',
                                          userId: '',
                                          carBrandId: '',
                                          carModelId: '',
                                          vehicleTypeId: '',
                                          registrationNo: '',
                                          carBrandName: '',
                                          carModelName: ''),
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => AddNewVehicle(
                              //         id: '',
                              //         userId: '',
                              //         carBrandId: '',
                              //         carModelId: '',
                              //         vehicleTypeId: '',
                              //         registrationNo: '',
                              //         carBrandName: '',
                              //         carModelName: ''),
                              //   ),
                              // );
                            },
                            child: Container(
                              height: 22,
                              width: 22,
                              margin: EdgeInsets.only(
                                right: 15,
                              ),
                              child: Icon(
                                Icons.add_circle,
                                color: Color(0xff1183FF),
                              ),
                            ),
                          )
                        : provider.isService == true
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          CarBrandScreen(
                                              id: '',
                                              userId: '',
                                              carBrandId: '',
                                              carModelId: '',
                                              vehicleTypeId: '',
                                              registrationNo: '',
                                              carBrandName: '',
                                              carModelName: ''),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => AddNewVehicle(
                                  //         id: '',
                                  //         userId: '',
                                  //         carBrandId: '',
                                  //         carModelId: '',
                                  //         vehicleTypeId: '',
                                  //         registrationNo: '',
                                  //         carBrandName: '',
                                  //         carModelName: ''),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  margin: EdgeInsets.only(
                                    right: 15,
                                  ),
                                  child: Icon(
                                    Icons.add_circle,
                                    color: Color(0xff1183FF),
                                  ),
                                ),
                              )
                            : Container()
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight),
            ),
            body: provider.isLoading
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: ColorTheme.themeCircularColor,
                      backgroundColor: ColorTheme.themeLightGrayColor,
                    ))
                : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        provider.objVehicleListResponse.data.userVehicles
                                .isEmpty
                            ? Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin:
                                      EdgeInsets.only(top: 300, bottom: 300),
                                  child: Text(
                                    "No Vehicles Available!!",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Medium",
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 15, bottom: 20),
                                itemCount: provider.objVehicleListResponse.data
                                    .userVehicles.length,
                                itemBuilder: (context, index) {
                                  var vehicleListItems = provider
                                      .objVehicleListResponse.data.userVehicles;
                                  int selectedIndex = index;
                                  print(("selectedIndex:$selectedIndex"));
                                  return Column(
                                    children: [
                                      Card(
                                        elevation: 1,
                                        margin: EdgeInsets.only(
                                            right: 20, top: 10, left: 20),
                                        child: Container(
                                          height: 80,
                                          width: 400,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: ColorTheme.themeWhiteColor,
                                              border: Border.all(
                                                  color: Color(0xff007BFF),
                                                  width: 1)),
                                          child: Row(
                                            children: [
                                              provider.isSpecialRequest == true
                                                  ? Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: InkWell(
                                                        onTap: () {
                                                          provider
                                                              .toggleMyVehicleSelected(
                                                                  index);
                                                          print(
                                                              "selectedIndex:${provider.selectedMyVehicleIndex}");

                                                          //  });
                                                        },
                                                        child: index ==
                                                                provider
                                                                    .selectedMyVehicleIndex
                                                            ? Container(
                                                                height: 20,
                                                                width: 20,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xff007BFF)),
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            12.09,
                                                                        width:
                                                                            9,
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                5),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          "assets/images/check-solid.svg",
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                              )
                                                            : Container(
                                                                height: 20,
                                                                width: 20,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: Color(
                                                                            0xffC2C2C2),
                                                                        width:
                                                                            2)),
                                                                child: Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10.0),
                                                                    child:
                                                                        Container()),
                                                              ),
                                                      ),
                                                    )
                                                  : provider.subsVehicleSelection ==
                                                          true
                                                      ? Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: InkWell(
                                                            onTap: () {
                                                              provider
                                                                  .toggleMyVehicleSelected(
                                                                      index);
                                                              print(
                                                                  "selectedIndex:${provider.selectedMyVehicleIndex}");
                                                              provider.getCheckUSerVehicleApi(
                                                                  provider
                                                                      .objVehicleListResponse
                                                                      .data
                                                                      .userVehicles[
                                                                          provider
                                                                              .selectedMyVehicleIndex]
                                                                      .id
                                                                      .toString(),
                                                                  context);

                                                              //    });
                                                            },
                                                            child: index ==
                                                                    provider
                                                                        .selectedMyVehicleIndex
                                                                ? Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Color(
                                                                            0xff007BFF)),
                                                                    child: Container(
                                                                        height: 12.09,
                                                                        width: 9,
                                                                        padding: EdgeInsets.all(5),
                                                                        child: SvgPicture.asset(
                                                                          "assets/images/check-solid.svg",
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  )
                                                                : Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                Color(0xffC2C2C2),
                                                                            width: 2)),
                                                                    child: Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            10.0),
                                                                        child:
                                                                            Container()),
                                                                  ),
                                                          ),
                                                        )
                                                      : provider.isService ==
                                                              true
                                                          ? Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  provider
                                                                      .toggleMyVehicleSelected(
                                                                          index);
                                                                  print(
                                                                      "selectedIndex:${provider.selectedMyVehicleIndex}");

                                                                  //    });
                                                                },
                                                                child: index ==
                                                                        provider
                                                                            .selectedMyVehicleIndex
                                                                    ? Container(
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: Color(0xff007BFF)),
                                                                        child: Container(
                                                                            height: 12.09,
                                                                            width: 9,
                                                                            padding: EdgeInsets.all(5),
                                                                            child: SvgPicture.asset(
                                                                              "assets/images/check-solid.svg",
                                                                              color: Colors.white,
                                                                            )),
                                                                      )
                                                                    : Container(
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: Colors.white,
                                                                            border: Border.all(color: Color(0xffC2C2C2), width: 2)),
                                                                        child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child: Container()),
                                                                      ),
                                                              ),
                                                            )
                                                          : Container(),
                                              vehicleListItems[index]
                                                          .brand
                                                          .image ==
                                                      ""
                                                  ? Container(
                                                      height: 48,
                                                      width: 44,
                                                      margin: EdgeInsets.only(
                                                          left: 3,
                                                          top: 11,
                                                          bottom: 11),
                                                      child: Image.asset(
                                                          "assets/images/carBrand/Suzuki.png"),
                                                    )
                                                  : Container(
                                                      height: 48,
                                                      width: 44,
                                                      margin: EdgeInsets.only(
                                                          left: 3,
                                                          top: 11,
                                                          bottom: 11),
                                                      child: Image.network(
                                                        vehicleListItems[index]
                                                            .brand
                                                            .image
                                                            .toString(),
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 1),
                                                              () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Dashboard()),
                                                            );
                                                            // throw Exception("Custom Error");
                                                          });

                                                          return Container();
                                                        },
                                                      ),
                                                    ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  vehicleListItems[index]
                                                                  .brand
                                                                  .name ==
                                                              "" ||
                                                          vehicleListItems[
                                                                      index]
                                                                  .model
                                                                  .name ==
                                                              ""
                                                      ? Container(
                                                          // height: 19,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 13,
                                                                  bottom: 10),
                                                          width: 150,
                                                          child: Text(
                                                            "",
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 12.5,
                                                                fontFamily:
                                                                    "SemiBold"),
                                                          ),
                                                        )
                                                      : Container(
                                                          // height: 19,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 13,
                                                                  bottom: 10),
                                                          width: 150,
                                                          child: Text(
                                                            "${vehicleListItems[index].brand.name} ${vehicleListItems[index].model.name}",
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 12.5,
                                                                fontFamily:
                                                                    "SemiBold"),
                                                          ),
                                                        ),
                                                  vehicleListItems[index]
                                                                  .registrationNo ==
                                                              "" ||
                                                          vehicleListItems[
                                                                      index]
                                                                  .vehicle
                                                                  .name ==
                                                              ""
                                                      ? Container(
                                                          //  height: 19,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          width: 180,
                                                          child: Text(
                                                            "",
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 9.5,
                                                                fontFamily:
                                                                    "Medium"),
                                                          ),
                                                        )
                                                      : Container(
                                                          //  height: 19,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          width: 180,
                                                          child: Text(
                                                            "${vehicleListItems[index].registrationNo} | ${vehicleListItems[index].vehicle.name}",
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 9.5,
                                                                fontFamily:
                                                                    "Medium"),
                                                          ),
                                                        )
                                                ],
                                              ),
                                              Spacer(),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 20,
                                                ),
                                                child: PopupMenuButton(
                                                  offset: Offset(-3, 45),
                                                  shape: const TooltipShape(),
                                                  itemBuilder: (_) =>
                                                      <PopupMenuEntry>[
                                                    PopupMenuItem(
                                                        child: ListTile(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        print(
                                                            "edit vehicle selected");
                                                        //  provider.isVehicleEdit = true;
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (context) =>
                                                        //             AddNewVehicle(
                                                        //               id: vehicleListItems[
                                                        //                       index]
                                                        //                   .id
                                                        //                   .toString(),
                                                        //               userId:
                                                        //                   vehicleListItems[
                                                        //                           index]
                                                        //                       .userId
                                                        //                       .toString(),
                                                        //               vehicleTypeId:
                                                        //                   vehicleListItems[
                                                        //                           index]
                                                        //                       .vehicleTypeId
                                                        //                       .toString(),
                                                        //               carBrandId:
                                                        //                   vehicleListItems[
                                                        //                           index]
                                                        //                       .carBrandId
                                                        //                       .toString(),
                                                        //               carModelId:
                                                        //                   vehicleListItems[
                                                        //                           index]
                                                        //                       .carModelId
                                                        //                       .toString(),
                                                        //               registrationNo:
                                                        //                   vehicleListItems[
                                                        //                           index]
                                                        //                       .registrationNo
                                                        //                       .toString(),
                                                        //               carBrandName: '',
                                                        //               carModelName: '',
                                                        //             )));
                                                      },
                                                      leading: const Icon(
                                                        Icons.edit,
                                                        color: Colors.green,
                                                      ),
                                                      title: const Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "Regular",
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )),
                                                    PopupMenuItem(
                                                        child: ListTile(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        print(
                                                            "delete vehicle selected");
                                                        provider
                                                            .getVehicleDeleteApi(
                                                                vehicleListItems[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                context);
                                                      },
                                                      leading: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      title: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "Regular",
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        provider.subsVehicleSelection == true
                            ? Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 15, top: 17),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorTheme.themeGreenColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      minimumSize: Size(374, 56),
                                    ),
                                    onPressed: () {
                                      // provider.isVehicleEdit = false;
                                      // Navigator.of(context).pushNamed('/payment');

                                      provider.subsAddressSelection = true;

                                      //  provider.getCheckUSerVehicleApi();

                                      provider.getSubscriptionListApi(
                                          provider
                                              .objVehicleListResponse
                                              .data
                                              .userVehicles[provider
                                                  .selectedMyVehicleIndex]
                                              .model
                                              .id
                                              .toString(),
                                          context);

                                      provider.isSubscriptionInactive(
                                          widget.serviceName);
                                      if (provider
                                              .isSubscriptionInactiveStatus ==
                                          false) {
                                        // List<int> prices =
                                        //     getPriceForSubscription(
                                        //         widget.serviceName, provider);
                                        //
                                        // if (prices.isNotEmpty) {
                                        //   for (int price in prices) {
                                        //     print(
                                        //         "selected subscription price:${price}");
                                        //     provider
                                        //         .setselectedSubscriptionprice(
                                        //             price);
                                        //
                                        //     print(
                                        //         "selectedSubscriptionprice:${provider.selectedSubscriptionprice}");
                                        List<Map<String, dynamic>>
                                            subscriptionpricesAndIds =
                                            getPriceForSubscription(
                                                widget.serviceName, provider);

                                        if (subscriptionpricesAndIds
                                            .isNotEmpty) {
                                          for (var price
                                              in subscriptionpricesAndIds) {
                                            print(
                                                "selected subscription price:${price['price']}");
                                            print(
                                                "subscription id:${price['id']}");
                                            provider
                                                .setselectedSubscriptionprice(
                                                    price['price']);
                                            provider.setselectedSubscriptionId(
                                                price['id']);
                                            print(
                                                "selectedSubscriptionId :${provider.selectedSubscriptionId}");
                                            print(
                                                "selectedSubscriptionprice:${provider.selectedSubscriptionprice}");

                                            if (provider
                                                    .selectedMyVehicleIndex ==
                                                -1) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please select a vehicle",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (provider.subsEdit ==
                                                true) {
                                              provider.isSubscriptionInactive(
                                                  widget.serviceName);
                                              if (provider
                                                      .isSubscriptionInactiveStatus ==
                                                  false) {
                                                List<Map<String, dynamic>>
                                                    subscriptionpricesAndIds =
                                                    getPriceForSubscription(
                                                        widget.serviceName,
                                                        provider);

                                                if (subscriptionpricesAndIds
                                                    .isNotEmpty) {
                                                  for (var price
                                                      in subscriptionpricesAndIds) {
                                                    print(
                                                        "selected subscription price:${price['price']}");
                                                    print(
                                                        "subscription id:${price['id']}");
                                                    provider
                                                        .setselectedSubscriptionprice(
                                                            price['price']);
                                                    provider
                                                        .setselectedSubscriptionId(
                                                            price['id']);
                                                    print(
                                                        "selectedSubscriptionId :${provider.selectedSubscriptionId}");
                                                    print(
                                                        "selectedSubscriptionprice:${provider.selectedSubscriptionprice}");

                                                    Navigator.of(context).push(
                                                        PageRouteBuilder(
                                                            transitionDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        400),
                                                            pageBuilder: (context,
                                                                    animation,
                                                                    secondaryAnimation) =>
                                                                PaymentScreen(
                                                                    vehicleImagePath: provider
                                                                        .objVehicleListResponse
                                                                        .data
                                                                        .userVehicles[provider
                                                                            .selectedMyVehicleIndex]
                                                                        .brand
                                                                        .image
                                                                        .toString(),
                                                                    vehicleBrandName: provider
                                                                        .objVehicleListResponse
                                                                        .data
                                                                        .userVehicles[provider.selectedMyVehicleIndex]
                                                                        .brand
                                                                        .name
                                                                        .toString(),
                                                                    vehicleModelName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString(),
                                                                    vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(),
                                                                    vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(),
                                                                    vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(),
                                                                    addressId: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].id.toString(),
                                                                    addrressType: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].type.toString(),
                                                                    flatHouseNo: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].flatHouseNo.toString(),
                                                                    area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                                                                    nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                                                    subscriptionId: provider.selectedSubscriptionId.toString(),
                                                                    // subscriptionPrize: provider.objServicePriceResponse.data[provider.selectedMyVehicleIndex].discountPrice.toString()),
                                                                    subscriptionPrize: provider.selectedSubscriptionprice),
                                                            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                              return new SlideTransition(
                                                                position:
                                                                    new Tween<
                                                                        Offset>(
                                                                  //Left to right
                                                                  // begin: const Offset(-1.0, 0.0),
                                                                  // end: Offset.zero,

                                                                  //Right to left
                                                                  begin:
                                                                      const Offset(
                                                                          1.0,
                                                                          0.0),
                                                                  end: Offset
                                                                      .zero,

                                                                  //top to bottom
                                                                  // begin: const Offset(0.0, -1.0),
                                                                  // end: Offset.zero,

                                                                  //   bottom to top
                                                                  // begin: Offset(0.0, 1.0),
                                                                  // end: Offset.zero,
                                                                ).animate(
                                                                        animation),
                                                                child: child,
                                                              );
                                                            }));
                                                  }
                                                } else {
                                                  Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                          transitionDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      400),
                                                          pageBuilder: (context,
                                                                  animation,
                                                                  secondaryAnimation) =>
                                                              Dashboard(),
                                                          transitionsBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Animation<
                                                                          double>
                                                                      animation,
                                                                  Animation<
                                                                          double>
                                                                      secondaryAnimation,
                                                                  Widget
                                                                      child) {
                                                            return new SlideTransition(
                                                              position:
                                                                  new Tween<
                                                                      Offset>(
                                                                //Left to right
                                                                // begin: const Offset(-1.0, 0.0),
                                                                // end: Offset.zero,

                                                                //Right to left
                                                                begin:
                                                                    const Offset(
                                                                        1.0,
                                                                        0.0),
                                                                end:
                                                                    Offset.zero,

                                                                //top to bottom
                                                                // begin: const Offset(0.0, -1.0),
                                                                // end: Offset.zero,

                                                                //   bottom to top
                                                                // begin: Offset(0.0, 1.0),
                                                                // end: Offset.zero,
                                                              ).animate(
                                                                      animation),
                                                              child: child,
                                                            );
                                                          }));
                                                }
                                              } else {
                                                print(
                                                    "No matching subscription found");
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "${widget.serviceName} is not found for ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString()} ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString()}",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                Navigator.of(context).push(
                                                    PageRouteBuilder(
                                                        transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            Dashboard(),
                                                        transitionsBuilder:
                                                            (BuildContext context,
                                                                Animation<
                                                                        double>
                                                                    animation,
                                                                Animation<
                                                                        double>
                                                                    secondaryAnimation,
                                                                Widget child) {
                                                          return new SlideTransition(
                                                            position: new Tween<
                                                                Offset>(
                                                              //Left to right
                                                              // begin: const Offset(-1.0, 0.0),
                                                              // end: Offset.zero,

                                                              //Right to left
                                                              begin:
                                                                  const Offset(
                                                                      1.0, 0.0),
                                                              end: Offset.zero,

                                                              //top to bottom
                                                              // begin: const Offset(0.0, -1.0),
                                                              // end: Offset.zero,

                                                              //   bottom to top
                                                              // begin: Offset(0.0, 1.0),
                                                              // end: Offset.zero,
                                                            ).animate(
                                                                animation),
                                                            child: child,
                                                          );
                                                        }));
                                              }
                                            } else {
                                              Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                      transitionDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  400),
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          SavedAddress(
                                                            vehicleImagePath: provider
                                                                .objVehicleListResponse
                                                                .data
                                                                .userVehicles[
                                                                    provider
                                                                        .selectedMyVehicleIndex]
                                                                .brand
                                                                .image
                                                                .toString(),
                                                            vehicleBrandName: provider
                                                                .objVehicleListResponse
                                                                .data
                                                                .userVehicles[
                                                                    provider
                                                                        .selectedMyVehicleIndex]
                                                                .brand
                                                                .name
                                                                .toString(),
                                                            vehicleModelName: provider
                                                                .objVehicleListResponse
                                                                .data
                                                                .userVehicles[
                                                                    provider
                                                                        .selectedMyVehicleIndex]
                                                                .model
                                                                .name
                                                                .toString(),
                                                            vehicleTypeName: provider
                                                                .objVehicleListResponse
                                                                .data
                                                                .userVehicles[
                                                                    provider
                                                                        .selectedMyVehicleIndex]
                                                                .vehicle
                                                                .name
                                                                .toString(),
                                                            vehicleRegNo: provider
                                                                .objVehicleListResponse
                                                                .data
                                                                .userVehicles[
                                                                    provider
                                                                        .selectedMyVehicleIndex]
                                                                .registrationNo
                                                                .toString(),
                                                            vehicleId: provider
                                                                .objVehicleListResponse
                                                                .data
                                                                .userVehicles[
                                                                    provider
                                                                        .selectedMyVehicleIndex]
                                                                .id
                                                                .toString(),
                                                            subscriptionId: provider
                                                                .selectedSubscriptionId
                                                                .toString(),
                                                            subscriptionPrize:
                                                                provider
                                                                    .selectedSubscriptionprice!
                                                                    .toInt(),
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
                                                      }));
                                            }
                                          }
                                        }
                                      } else {
                                        print(
                                            "No matching subscription  found");
                                        Fluttertoast.showToast(
                                            msg:
                                                "${widget.serviceName} is not found for ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString()} ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString()}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }

                                      // if (prices.isNotEmpty) {
                                      //   for (int price in prices) {
                                      //     print(
                                      //         "selected subscription price:${price}");
                                      //     provider.setselectedSubscriptionprice(
                                      //         price);
                                      //
                                      //     print(
                                      //         "selectedSubscriptionprice:${provider.selectedSubscriptionprice}");
                                      //   }
                                      // } else {
                                      //   print("No matching subscription found");
                                      // }

                                      // provider.selectedMyVehicleIndex == -1
                                      //     ? Fluttertoast.showToast(
                                      //         msg: "Please select a vehicle",
                                      //         toastLength: Toast.LENGTH_SHORT,
                                      //         gravity: ToastGravity.CENTER,
                                      //         timeInSecForIosWeb: 1,
                                      //         backgroundColor: Colors.red,
                                      //         textColor: Colors.white,
                                      //         fontSize: 16.0)
                                      //     : provider.subsEdit == true
                                      //         ? Navigator.of(context).push(
                                      //             PageRouteBuilder(
                                      //                 transitionDuration: const Duration(
                                      //                     milliseconds: 400),
                                      //                 pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
                                      //                     vehicleImagePath: provider
                                      //                         .objVehicleListResponse
                                      //                         .data
                                      //                         .userVehicles[provider
                                      //                             .selectedMyVehicleIndex]
                                      //                         .brand
                                      //                         .image
                                      //                         .toString(),
                                      //                     vehicleBrandName:
                                      //                         provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name
                                      //                             .toString(),
                                      //                     vehicleModelName: provider
                                      //                         .objVehicleListResponse
                                      //                         .data
                                      //                         .userVehicles[provider.selectedMyVehicleIndex]
                                      //                         .model
                                      //                         .name
                                      //                         .toString(),
                                      //                     vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(),
                                      //                     vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(),
                                      //                     vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(),
                                      //                     addressId: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].id.toString(),
                                      //                     addrressType: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].type.toString(),
                                      //                     flatHouseNo: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].flatHouseNo.toString(),
                                      //                     area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                                      //                     nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                      //                     subscriptionId: widget.id,
                                      //                     subscriptionPrize: provider.selectedSubscriptionprice!.toInt()),
                                      //                 transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                      //                   return new SlideTransition(
                                      //                     position:
                                      //                         new Tween<Offset>(
                                      //                       //Left to right
                                      //                       // begin: const Offset(-1.0, 0.0),
                                      //                       // end: Offset.zero,
                                      //
                                      //                       //Right to left
                                      //                       begin: const Offset(
                                      //                           1.0, 0.0),
                                      //                       end: Offset.zero,
                                      //
                                      //                       //top to bottom
                                      //                       // begin: const Offset(0.0, -1.0),
                                      //                       // end: Offset.zero,
                                      //
                                      //                       //   bottom to top
                                      //                       // begin: Offset(0.0, 1.0),
                                      //                       // end: Offset.zero,
                                      //                     ).animate(animation),
                                      //                     child: child,
                                      //                   );
                                      //                 }
                                      //                 // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                                      //                 //   var begin = 0.0;
                                      //                 //   var end = 1.0;
                                      //                 //   var curve = Curves.ease;
                                      //                 //
                                      //                 //   var tween =
                                      //                 //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      //                 //   return ScaleTransition(
                                      //                 //     scale: animation.drive(tween),
                                      //                 //     child: page,
                                      //                 //   );
                                      //                 // },
                                      //                 ))
                                      //         : Navigator.of(context).push(PageRouteBuilder(
                                      //             transitionDuration: const Duration(milliseconds: 400),
                                      //             pageBuilder: (context, animation, secondaryAnimation) => SavedAddress(
                                      //                   vehicleImagePath: provider
                                      //                       .objVehicleListResponse
                                      //                       .data
                                      //                       .userVehicles[provider
                                      //                           .selectedMyVehicleIndex]
                                      //                       .brand
                                      //                       .image
                                      //                       .toString(),
                                      //                   vehicleBrandName: provider
                                      //                       .objVehicleListResponse
                                      //                       .data
                                      //                       .userVehicles[provider
                                      //                           .selectedMyVehicleIndex]
                                      //                       .brand
                                      //                       .name
                                      //                       .toString(),
                                      //                   vehicleModelName: provider
                                      //                       .objVehicleListResponse
                                      //                       .data
                                      //                       .userVehicles[provider
                                      //                           .selectedMyVehicleIndex]
                                      //                       .model
                                      //                       .name
                                      //                       .toString(),
                                      //                   vehicleTypeName: provider
                                      //                       .objVehicleListResponse
                                      //                       .data
                                      //                       .userVehicles[provider
                                      //                           .selectedMyVehicleIndex]
                                      //                       .vehicle
                                      //                       .name
                                      //                       .toString(),
                                      //                   vehicleRegNo: provider
                                      //                       .objVehicleListResponse
                                      //                       .data
                                      //                       .userVehicles[provider
                                      //                           .selectedMyVehicleIndex]
                                      //                       .registrationNo
                                      //                       .toString(),
                                      //                   vehicleId: provider
                                      //                       .objVehicleListResponse
                                      //                       .data
                                      //                       .userVehicles[provider
                                      //                           .selectedMyVehicleIndex]
                                      //                       .id
                                      //                       .toString(),
                                      //                   subscriptionId:
                                      //                       widget.id,
                                      //                   subscriptionPrize: provider
                                      //                       .selectedSubscriptionprice!
                                      //                       .toInt(),
                                      //                 ),
                                      //             transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                      //               return new SlideTransition(
                                      //                 position:
                                      //                     new Tween<Offset>(
                                      //                   //Left to right
                                      //                   // begin: const Offset(-1.0, 0.0),
                                      //                   // end: Offset.zero,
                                      //
                                      //                   //Right to left
                                      //                   begin: const Offset(
                                      //                       1.0, 0.0),
                                      //                   end: Offset.zero,
                                      //
                                      //                   //top to bottom
                                      //                   // begin: const Offset(0.0, -1.0),
                                      //                   // end: Offset.zero,
                                      //
                                      //                   //   bottom to top
                                      //                   // begin: Offset(0.0, 1.0),
                                      //                   // end: Offset.zero,
                                      //                 ).animate(animation),
                                      //                 child: child,
                                      //               );
                                      //             }
                                      //             // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                                      //             //   var begin = 0.0;
                                      //             //   var end = 1.0;
                                      //             //   var curve = Curves.ease;
                                      //             //
                                      //             //   var tween =
                                      //             //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      //             //   return ScaleTransition(
                                      //             //     scale: animation.drive(tween),
                                      //             //     child: page,
                                      //             //   );
                                      //             // },
                                      //             ));
                                    },
                                    child: const Text(
                                      'Select Vehicle',
                                      style: TextStyle(
                                          color: ColorTheme.themeBlackColor,
                                          fontSize: 16,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                              )
                            : provider.isSpecialRequest == true
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 15,
                                          top: 17),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorTheme.themeGreenColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0)),
                                          minimumSize: Size(374, 56),
                                        ),
                                        onPressed: () {
                                          // provider.isVehicleEdit = false;
                                          // Navigator.of(context).pushNamed('/payment');
                                          // provider.subsAddressSelection = true;
                                          // print(
                                          //     "vehicle reg:${provider.objVehicleListResponse.data!.userVehicles![provider.selectedMyVehicleIndex].id}");
                                          // print(
                                          //     "subscription reg:${provider.objUserSubsListResponse.data[provider.selectedMyVehicleIndex].userVehicle.id}");
                                          // provider
                                          //             .objVehicleListResponse
                                          //             .data!
                                          //             .userVehicles![provider
                                          //                 .selectedMyVehicleIndex]
                                          //             .registrationNo ==
                                          //         provider
                                          //             .objUserSubsListResponse
                                          //             .data[provider
                                          //                 .selectedMyVehicleIndex]
                                          //             .userVehicle
                                          //             .registrationNo
                                          //     ? Fluttertoast.showToast(
                                          //         msg:
                                          //             "This vehicle has already been subscribed.\nPlease select another vehicle",
                                          //         toastLength: Toast.LENGTH_SHORT,
                                          //         gravity: ToastGravity.CENTER,
                                          //         timeInSecForIosWeb: 1,
                                          //         backgroundColor: Colors.red,
                                          //         textColor: Colors.white,
                                          //         fontSize: 16.0)
                                          //     :
                                          provider.getServicePriceApi(
                                              provider
                                                  .objVehicleListResponse
                                                  .data
                                                  .userVehicles[provider
                                                      .selectedMyVehicleIndex]
                                                  .model
                                                  .id
                                                  .toString(),
                                              context);

                                          provider.isServiceInactive(
                                              widget.serviceName);
                                          if (provider
                                                  .isServiceInactiveStatus ==
                                              false) {
                                            List<Map<String, dynamic>>
                                                pricesAndIds =
                                                getPriceForService(
                                                    widget.serviceName,
                                                    provider);

                                            if (pricesAndIds.isNotEmpty) {
                                              for (var price in pricesAndIds) {
                                                print(
                                                    "selected service price:${price['price']}");
                                                print(
                                                    "service id:${price['id']}");
                                                provider
                                                    .setselectedServiceprice(
                                                        price['price']);
                                                provider.setselectedServiceId(
                                                    price['id']);
                                                print(
                                                    "selectedserviceid:${provider.selectedServiceId}");
                                                print(
                                                    "selectedserviceprice:${provider.selectedServiceprice}");

                                                if (provider
                                                        .selectedMyVehicleIndex ==
                                                    -1) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please select a vehicle",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                } else if (provider.subsEdit ==
                                                    true) {
                                                  provider.isServiceInactive(
                                                      widget.serviceName);
                                                  if (provider
                                                          .isServiceInactiveStatus ==
                                                      false) {
                                                    List<Map<String, dynamic>>
                                                        pricesAndIds =
                                                        getPriceForService(
                                                            widget.serviceName,
                                                            provider);

                                                    if (pricesAndIds
                                                        .isNotEmpty) {
                                                      for (var price
                                                          in pricesAndIds) {
                                                        print(
                                                            "selected service price:${price['price']}");
                                                        print(
                                                            "service id:${price['id']}");
                                                        provider
                                                            .setselectedServiceprice(
                                                                price['price']);
                                                        provider
                                                            .setselectedServiceId(
                                                                price['id']);
                                                        print(
                                                            "selectedserviceid:${provider.selectedServiceId}");
                                                        print(
                                                            "selectedserviceprice:${provider.selectedServiceprice}");

                                                        Navigator.of(context).push(PageRouteBuilder(
                                                            transitionDuration: const Duration(milliseconds: 400),
                                                            pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
                                                                vehicleImagePath: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.image.toString(),
                                                                vehicleBrandName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString(),
                                                                vehicleModelName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString(),
                                                                vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(),
                                                                vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(),
                                                                vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(),
                                                                addressId: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].id.toString(),
                                                                addrressType: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].type.toString(),
                                                                flatHouseNo: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].flatHouseNo.toString(),
                                                                area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                                                                nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                                                subscriptionId: provider.selectedServiceId.toString(),
                                                                // subscriptionPrize: provider.objServicePriceResponse.data[provider.selectedMyVehicleIndex].discountPrice.toString()),
                                                                subscriptionPrize: provider.selectedServiceprice!.toInt()),
                                                            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                              return new SlideTransition(
                                                                position:
                                                                    new Tween<
                                                                        Offset>(
                                                                  //Left to right
                                                                  // begin: const Offset(-1.0, 0.0),
                                                                  // end: Offset.zero,

                                                                  //Right to left
                                                                  begin:
                                                                      const Offset(
                                                                          1.0,
                                                                          0.0),
                                                                  end: Offset
                                                                      .zero,

                                                                  //top to bottom
                                                                  // begin: const Offset(0.0, -1.0),
                                                                  // end: Offset.zero,

                                                                  //   bottom to top
                                                                  // begin: Offset(0.0, 1.0),
                                                                  // end: Offset.zero,
                                                                ).animate(
                                                                        animation),
                                                                child: child,
                                                              );
                                                            }));
                                                      }
                                                    }
                                                  } else {
                                                    print(
                                                        "No matching service found");
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "${widget.serviceName} is not found for ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString()} ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString()}",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  }
                                                } else {
                                                  Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                          transitionDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      400),
                                                          pageBuilder: (context, animation, secondaryAnimation) => ServiceAddress(
                                                              vehicleImagePath: provider
                                                                  .objVehicleListResponse
                                                                  .data
                                                                  .userVehicles[provider
                                                                      .selectedMyVehicleIndex]
                                                                  .brand
                                                                  .image
                                                                  .toString(),
                                                              vehicleBrandName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name
                                                                  .toString(),
                                                              vehicleModelName: provider
                                                                  .objVehicleListResponse
                                                                  .data
                                                                  .userVehicles[provider.selectedMyVehicleIndex]
                                                                  .model
                                                                  .name
                                                                  .toString(),
                                                              vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(),
                                                              vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(),
                                                              vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(),
                                                              serviceId: provider.selectedServiceId.toString(),
                                                              price: provider.selectedServiceprice!.toInt()),
                                                          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                            return new SlideTransition(
                                                              position:
                                                                  new Tween<
                                                                      Offset>(
                                                                //Left to right
                                                                // begin: const Offset(-1.0, 0.0),
                                                                // end: Offset.zero,

                                                                //Right to left
                                                                begin:
                                                                    const Offset(
                                                                        1.0,
                                                                        0.0),
                                                                end:
                                                                    Offset.zero,

                                                                //top to bottom
                                                                // begin: const Offset(0.0, -1.0),
                                                                // end: Offset.zero,

                                                                //   bottom to top
                                                                // begin: Offset(0.0, 1.0),
                                                                // end: Offset.zero,
                                                              ).animate(
                                                                      animation),
                                                              child: child,
                                                            );
                                                          }));
                                                }
                                              }
                                            }
                                          } else {
                                            print("No matching service found");
                                            Fluttertoast.showToast(
                                                msg:
                                                    "${widget.serviceName} is not found for ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString()} ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString()}",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        },
                                        child: const Text(
                                          'Select Vehicle',
                                          style: TextStyle(
                                              color: ColorTheme.themeBlackColor,
                                              fontSize: 16,
                                              fontFamily: "SemiBold"),
                                        ),
                                      ),
                                    ),
                                  )
                                : provider.isService == true
                                    ? Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 15,
                                              top: 17),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorTheme.themeGreenColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0)),
                                              minimumSize: Size(374, 56),
                                            ),
                                            onPressed: () {
                                              print(
                                                  "model id:${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.id.toString()}");
                                              provider.getServicePriceApi(
                                                  provider
                                                      .objVehicleListResponse
                                                      .data
                                                      .userVehicles[provider
                                                          .selectedMyVehicleIndex]
                                                      .model
                                                      .id
                                                      .toString(),
                                                  context);

                                              provider.isServiceInactive(
                                                  widget.serviceName);
                                              if (provider
                                                      .isServiceInactiveStatus ==
                                                  false) {
                                                List<Map<String, dynamic>>
                                                    pricesAndIds =
                                                    getPriceForService(
                                                        widget.serviceName,
                                                        provider);

                                                if (pricesAndIds.isNotEmpty) {
                                                  for (var price
                                                      in pricesAndIds) {
                                                    print(
                                                        "selected service price:${price['price']}");
                                                    print(
                                                        "service id:${price['id']}");
                                                    provider
                                                        .setselectedServiceprice(
                                                            price['price']);
                                                    provider
                                                        .setselectedServiceId(
                                                            price['id']);
                                                    print(
                                                        "selectedserviceid:${provider.selectedServiceId}");
                                                    print(
                                                        "selectedserviceprice:${provider.selectedServiceprice}");

                                                    if (provider
                                                            .selectedMyVehicleIndex ==
                                                        -1) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please select a vehicle",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else if (provider
                                                            .subsEdit ==
                                                        true) {
                                                      provider
                                                          .isServiceInactive(
                                                              widget
                                                                  .serviceName);
                                                      if (provider
                                                              .isServiceInactiveStatus ==
                                                          false) {
                                                        List<
                                                                Map<String,
                                                                    dynamic>>
                                                            pricesAndIds =
                                                            getPriceForService(
                                                                widget
                                                                    .serviceName,
                                                                provider);

                                                        if (pricesAndIds
                                                            .isNotEmpty) {
                                                          for (var price
                                                              in pricesAndIds) {
                                                            print(
                                                                "selected service price:${price['price']}");
                                                            print(
                                                                "service id:${price['id']}");
                                                            provider
                                                                .setselectedServiceprice(
                                                                    price[
                                                                        'price']);
                                                            provider
                                                                .setselectedServiceId(
                                                                    price[
                                                                        'id']);

                                                            print(
                                                                "selectedserviceid:${provider.selectedServiceId}");
                                                            print(
                                                                "selectedserviceprice:${provider.selectedServiceprice}");

                                                            Navigator.of(context).push(PageRouteBuilder(
                                                                transitionDuration: const Duration(milliseconds: 400),
                                                                pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
                                                                    vehicleImagePath: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.image.toString(),
                                                                    vehicleBrandName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString(),
                                                                    vehicleModelName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString(),
                                                                    vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(),
                                                                    vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(),
                                                                    vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(),
                                                                    addressId: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].id.toString(),
                                                                    addrressType: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].type.toString(),
                                                                    flatHouseNo: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].flatHouseNo.toString(),
                                                                    area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                                                                    nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                                                    subscriptionId: provider.selectedServiceId.toString(),
                                                                    // subscriptionPrize: provider.objServicePriceResponse.data[provider.selectedMyVehicleIndex].discountPrice.toString()),
                                                                    subscriptionPrize: provider.selectedServiceprice!.toInt()),
                                                                transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                                  return new SlideTransition(
                                                                    position: new Tween<
                                                                        Offset>(
                                                                      //Left to right
                                                                      // begin: const Offset(-1.0, 0.0),
                                                                      // end: Offset.zero,

                                                                      //Right to left
                                                                      begin: const Offset(
                                                                          1.0,
                                                                          0.0),
                                                                      end: Offset
                                                                          .zero,

                                                                      //top to bottom
                                                                      // begin: const Offset(0.0, -1.0),
                                                                      // end: Offset.zero,

                                                                      //   bottom to top
                                                                      // begin: Offset(0.0, 1.0),
                                                                      // end: Offset.zero,
                                                                    ).animate(
                                                                        animation),
                                                                    child:
                                                                        child,
                                                                  );
                                                                }));
                                                          }
                                                        }
                                                      } else {
                                                        print(
                                                            "No matching service found");
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "${widget.serviceName} is not found for ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString()} ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString()}",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    } else {
                                                      Navigator.of(context).push(
                                                          PageRouteBuilder(
                                                              transitionDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          400),
                                                              pageBuilder: (context, animation, secondaryAnimation) => ServiceAddress(
                                                                  vehicleImagePath: provider
                                                                      .objVehicleListResponse
                                                                      .data
                                                                      .userVehicles[
                                                                          provider
                                                                              .selectedMyVehicleIndex]
                                                                      .brand
                                                                      .image
                                                                      .toString(),
                                                                  vehicleBrandName: provider
                                                                      .objVehicleListResponse
                                                                      .data
                                                                      .userVehicles[provider.selectedMyVehicleIndex]
                                                                      .brand
                                                                      .name
                                                                      .toString(),
                                                                  vehicleModelName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString(),
                                                                  vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(),
                                                                  vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(),
                                                                  vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(),
                                                                  serviceId: provider.selectedServiceId.toString(),
                                                                  price: provider.selectedServiceprice!.toInt()),
                                                              transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                                return new SlideTransition(
                                                                  position: new Tween<
                                                                      Offset>(
                                                                    //Left to right
                                                                    // begin: const Offset(-1.0, 0.0),
                                                                    // end: Offset.zero,

                                                                    //Right to left
                                                                    begin:
                                                                        const Offset(
                                                                            1.0,
                                                                            0.0),
                                                                    end: Offset
                                                                        .zero,

                                                                    //top to bottom
                                                                    // begin: const Offset(0.0, -1.0),
                                                                    // end: Offset.zero,

                                                                    //   bottom to top
                                                                    // begin: Offset(0.0, 1.0),
                                                                    // end: Offset.zero,
                                                                  ).animate(
                                                                      animation),
                                                                  child: child,
                                                                );
                                                              }));
                                                    }
                                                  }
                                                }
                                              } else {
                                                print(
                                                    "No matching service found");
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "${widget.serviceName} is not found for ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString()} ${provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString()}",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }

                                              // List<int> prices =
                                              //     getPriceForService(
                                              //         widget.serviceName,
                                              //         provider);
                                              //
                                              // if (prices.isNotEmpty) {
                                              //   for (int price in prices) {
                                              //     print(
                                              //         "selected service price:${price}");
                                              //     provider
                                              //         .setselectedServiceprice(
                                              //             price);
                                              //
                                              //     print(
                                              //         "selectedserviceprice:${provider.selectedServiceprice}");
                                              //
                                              //     provider.selectedMyVehicleIndex ==
                                              //             -1
                                              //         ? Fluttertoast.showToast(
                                              //             msg:
                                              //                 "Please select a vehicle",
                                              //             toastLength:
                                              //                 Toast.LENGTH_SHORT,
                                              //             gravity:
                                              //                 ToastGravity.CENTER,
                                              //             timeInSecForIosWeb: 1,
                                              //             backgroundColor:
                                              //                 Colors.red,
                                              //             textColor: Colors.white,
                                              //             fontSize: 16.0)
                                              //         : provider.subsEdit == true
                                              //             ? Navigator.of(context).push(PageRouteBuilder(
                                              //                 transitionDuration: const Duration(milliseconds: 400),
                                              //                 pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
                                              //                     vehicleImagePath: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.image.toString(),
                                              //                     vehicleBrandName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString(),
                                              //                     vehicleModelName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString(),
                                              //                     vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(),
                                              //                     vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(),
                                              //                     vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(),
                                              //                     addressId: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].id.toString(),
                                              //                     addrressType: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].type.toString(),
                                              //                     flatHouseNo: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].flatHouseNo.toString(),
                                              //                     area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                                              //                     nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                              //                     subscriptionId: widget.serviceId,
                                              //                     // subscriptionPrize: provider.objServicePriceResponse.data[provider.selectedMyVehicleIndex].discountPrice.toString()),
                                              //                     subscriptionPrize: provider.selectedServiceprice!.toInt()),
                                              //                 transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                              //                   return new SlideTransition(
                                              //                     position:
                                              //                         new Tween<
                                              //                             Offset>(
                                              //                       //Left to right
                                              //                       // begin: const Offset(-1.0, 0.0),
                                              //                       // end: Offset.zero,
                                              //
                                              //                       //Right to left
                                              //                       begin:
                                              //                           const Offset(
                                              //                               1.0,
                                              //                               0.0),
                                              //                       end: Offset
                                              //                           .zero,
                                              //
                                              //                       //top to bottom
                                              //                       // begin: const Offset(0.0, -1.0),
                                              //                       // end: Offset.zero,
                                              //
                                              //                       //   bottom to top
                                              //                       // begin: Offset(0.0, 1.0),
                                              //                       // end: Offset.zero,
                                              //                     ).animate(
                                              //                             animation),
                                              //                     child: child,
                                              //                   );
                                              //                 }))
                                              //             : Navigator.of(context).push(PageRouteBuilder(
                                              //                 transitionDuration: const Duration(milliseconds: 400),
                                              //                 pageBuilder: (context, animation, secondaryAnimation) => ServiceAddress(vehicleImagePath: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.image.toString(), vehicleBrandName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].brand.name.toString(), vehicleModelName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].model.name.toString(), vehicleTypeName: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].vehicle.name.toString(), vehicleRegNo: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].registrationNo.toString(), vehicleId: provider.objVehicleListResponse.data.userVehicles[provider.selectedMyVehicleIndex].id.toString(), serviceId: widget.serviceId, price: provider.selectedServiceprice!.toInt()),
                                              //                 transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                              //                   return new SlideTransition(
                                              //                     position:
                                              //                         new Tween<
                                              //                             Offset>(
                                              //                       //Left to right
                                              //                       // begin: const Offset(-1.0, 0.0),
                                              //                       // end: Offset.zero,
                                              //
                                              //                       //Right to left
                                              //                       begin:
                                              //                           const Offset(
                                              //                               1.0,
                                              //                               0.0),
                                              //                       end: Offset
                                              //                           .zero,
                                              //
                                              //                       //top to bottom
                                              //                       // begin: const Offset(0.0, -1.0),
                                              //                       // end: Offset.zero,
                                              //
                                              //                       //   bottom to top
                                              //                       // begin: Offset(0.0, 1.0),
                                              //                       // end: Offset.zero,
                                              //                     ).animate(
                                              //                             animation),
                                              //                     child: child,
                                              //                   );
                                              //                 }
                                              //                 // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                                              //                 //   var begin = 0.0;
                                              //                 //   var end = 1.0;
                                              //                 //   var curve = Curves.ease;
                                              //                 //
                                              //                 //   var tween =
                                              //                 //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                              //                 //   return ScaleTransition(
                                              //                 //     scale: animation.drive(tween),
                                              //                 //     child: page,
                                              //                 //   );
                                              //                 // },
                                              //
                                              //                 // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                                              //                 //   var begin = 0.0;
                                              //                 //   var end = 1.0;
                                              //                 //   var curve = Curves.ease;
                                              //                 //
                                              //                 //   var tween =
                                              //                 //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                              //                 //   return ScaleTransition(
                                              //                 //     scale: animation.drive(tween),
                                              //                 //     child: page,
                                              //                 //   );
                                              //                 // },
                                              //                 ));
                                              //   }
                                              // } else  {
                                              //   print(
                                              //       "No matching service found");
                                              //   Fluttertoast.showToast(
                                              //       msg:
                                              //           "The selected service does not match with any service in the list",
                                              //       toastLength:
                                              //           Toast.LENGTH_SHORT,
                                              //       gravity: ToastGravity.CENTER,
                                              //       timeInSecForIosWeb: 1,
                                              //       backgroundColor: Colors.red,
                                              //       textColor: Colors.white,
                                              //       fontSize: 16.0);
                                              // }
                                            },
                                            child: const Text(
                                              'Select Vehicle',
                                              style: TextStyle(
                                                  color: ColorTheme
                                                      .themeBlackColor,
                                                  fontSize: 16,
                                                  fontFamily: "SemiBold"),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 15,
                                              top: 17),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorTheme.themeGreenColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0)),
                                              minimumSize: Size(374, 56),
                                            ),
                                            onPressed: () {
                                              provider.isVehicleEdit = false;
                                              Future.delayed(Duration.zero, () {
                                                Navigator
                                                        .of(context)
                                                    .push(PageRouteBuilder(
                                                        transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            CarBrandScreen(
                                                                id: "",
                                                                userId: "",
                                                                carBrandId: "",
                                                                carModelId: "",
                                                                vehicleTypeId:
                                                                    "",
                                                                registrationNo:
                                                                    "",
                                                                carBrandName:
                                                                    "",
                                                                carModelName:
                                                                    ""),
                                                        transitionsBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Animation<
                                                                        double>
                                                                    animation,
                                                                Animation<
                                                                        double>
                                                                    secondaryAnimation,
                                                                Widget child) {
                                                          return new SlideTransition(
                                                            position: new Tween<
                                                                Offset>(
                                                              //Left to right
                                                              // begin: const Offset(-1.0, 0.0),
                                                              // end: Offset.zero,

                                                              //Right to left
                                                              begin:
                                                                  const Offset(
                                                                      1.0, 0.0),
                                                              end: Offset.zero,

                                                              //top to bottom
                                                              // begin: const Offset(0.0, -1.0),
                                                              // end: Offset.zero,

                                                              //   bottom to top
                                                              // begin: Offset(0.0, 1.0),
                                                              // end: Offset.zero,
                                                            ).animate(
                                                                animation),
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
                                            child: const Text(
                                              'Add Vehicle',
                                              style: TextStyle(
                                                  color: ColorTheme
                                                      .themeBlackColor,
                                                  fontSize: 16,
                                                  fontFamily: "SemiBold"),
                                            ),
                                          ),
                                        ),
                                      ),
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }

  List<Map<String, dynamic>> getPriceForSubscription(
      String subscriptionName, YopeeProvider provider) {
    var normalizedSubsName = subscriptionName.trim().toLowerCase();
    // print("normalizedSubsName:$normalizedSubsName");
    print("subscriptionName:$subscriptionName");

    for (var subscription in provider.objSubscriptionListResponse.data) {
      print(
          "Original Subscription:${subscription.name},Normalized Name:${subscription.name.trim().toLowerCase()}");
    }

    var subscriptions =
        provider.objSubscriptionListResponse.data.where((element) {
      var name = element.name.toString().toLowerCase();

      print("name:$name");
      return name.contains(normalizedSubsName);
    });

    print("Matching subscriptions:${subscriptions}");

    // var prices =
    //     subscriptions.map<int>((subscription) => subscription.price).toList();
    //
    // print("prices:${prices}");
    //
    //
    //
    // return prices;
    var subscriptionpricesandids =
        subscriptions.map<Map<String, dynamic>>((subscription) {
      return {'id': subscription.id, 'price': subscription.price};
    }).toList();

    //  => service.discountPrice).toList();

    print("subscriptionpricesandids :${subscriptionpricesandids}");

    return subscriptionpricesandids;
  }

  List<Map<String, dynamic>> getPriceForService(
      String serviceName, YopeeProvider provider) {
    var normalizedSubsName = serviceName.trim().toLowerCase();
    // print("normalizedSubsName:$normalizedSubsName");
    print("serviceName:$serviceName");

    for (var service in provider.objServicePriceResponse.data) {
      print(
          "Original service:${service.name},Normalized Name:${service.name.trim().toLowerCase()}");
    }

    var services = provider.objServicePriceResponse.data.where((element) {
      var name = element.name.toString().toLowerCase();
      // var serviceId = element.id.toString();

      print("name:$name");
      // print("selectedserviceId:$serviceId");
      return name.contains(normalizedSubsName);
    });

    print("Matching services:${services}");

    var pricesandids = services.map<Map<String, dynamic>>((service) {
      return {'id': service.id, 'price': service.discountPrice};
    }).toList();

    //  => service.discountPrice).toList();

    print("pricesandids:${pricesandids}");

    return pricesandids;
  }
}

/// I'm using [RoundedRectangleBorder] as my reference...
class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
