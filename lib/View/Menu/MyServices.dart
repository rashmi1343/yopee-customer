import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Login/Login.dart';

import '../../Presenter/YopeeProvider.dart';
import 'MoreMenu.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  MyServicesState createState() => MyServicesState();
}

class MyServicesState extends State<MyServices> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      String month =
          DateFormat("yyyy-MM-dd").format(provider.selectedMyServiceDate);

      provider.getUserServiceListApi(month, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () {
          String month =
              DateFormat("yyyy-MM-dd").format(provider.selectedMyServiceDate);

          return provider.getUserServiceListApi(month, context);
        },
        child: Scaffold(
          // appBar: PreferredSize(
          //   child: Container(
          //     decoration: BoxDecoration(boxShadow: [
          //       BoxShadow(
          //         color: Color(0xff00000029),
          //         offset: Offset(0, 0.0),
          //         blurRadius: 6.0,
          //       )
          //     ]),
          //     child: AppBar(
          //       elevation: 4,
          //       shadowColor: Color(0xff00000029),
          //       toolbarHeight: 53,
          //       leading: IconButton(
          //         iconSize: 25,
          //         icon: const Icon(Icons.arrow_back, color: Colors.black),
          //         onPressed: () {
          //           Navigator.of(context).pushNamed('/moreMenu');
          //         },
          //       ),
          //       centerTitle: true,
          //       title: Text(
          //         "My Subscription",
          //         style: TextStyle(
          //             fontSize: 21, fontFamily: "SemiBold", color: Colors.white),
          //       ),
          //     ),
          //   ),
          //   preferredSize: Size.fromHeight(kToolbarHeight),
          // ),
          body: provider.isLoading
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: ColorTheme.themeCircularColor,
                    backgroundColor: ColorTheme.themeLightGrayColor,
                  ))
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/splash/bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: IconButton(
                                iconSize: 25,
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
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
                                  // Navigator.of(context).pushNamed('/moreMenu');
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              alignment: Alignment.center,
                              child: Text(
                                "My Services",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontFamily: "SemiBold",
                                    color: Colors.white),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                provider.selectDateMyService(context);
                                // DateTime today = DateTime.now();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset(
                                  "assets/images/calendar-days-regular.svg",
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        provider.dateMyService == ""
                            ? Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  top: 30,
                                ),
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Medium",
                                      color: Colors.white),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  top: 30,
                                ),
                                child: Text(
                                  "${provider.dateMyService}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Medium",
                                      color: Colors.white),
                                ),
                              ),
                        provider.objUserServiceListResponse.data!.length == 0
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 300),
                                  child: Text(
                                    "No Service Available!!",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Medium",
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: provider
                                            .objUserServiceListResponse
                                            .data!
                                            .length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      var mySubsListItem = provider
                                          .objUserServiceListResponse.data;
                                      // final now = mySubsListItem[index].toDate;
                                      // final String formatter = DateFormat('dd-MM-yyyy');
                                      // final String formatted = formatter.format(now);
                                      // print(formatted); // something like 2013-04-20
                                      // var date = DateFormat('dd MMM, yyyy')
                                      //     .format(DateTime.parse(
                                      //         mySubsListItem[index]
                                      //             .toDate
                                      //             .toString()));
                                      // print("data:$date"); //12-04-2020
                                      return Column(
                                        children: [
                                          Container(
                                            height: 185,
                                            width: 377,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 21, top: 18),
                                                      child: Text(
                                                        mySubsListItem![index]
                                                            .service
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffF69008),
                                                            fontFamily:
                                                                "SemiBold",
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 21, top: 18),
                                                      child: Text(
                                                        "₹${mySubsListItem![index].service.discountPrice.toString()}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffF69008),
                                                            fontFamily: "Bold",
                                                            fontSize: 26),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 19.5),
                                                  height: 2,
                                                  color: Color(0xffDDDDF7),
                                                ),
                                                SizedBox(
                                                  height: 14.5,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 21,
                                                      left: 21,
                                                      bottom: 18),
                                                  child: Row(
                                                    children: [
                                                      mySubsListItem[index]
                                                                      .userVehicle!
                                                                      .brand!
                                                                      .image ==
                                                                  "" ||
                                                              mySubsListItem[
                                                                          index]
                                                                      .userVehicle!
                                                                      .brand!
                                                                      .image ==
                                                                  null
                                                          ? Container(
                                                              height: 45.5,
                                                              width: 56,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 7,
                                                                      top: 6,
                                                                      right:
                                                                          6.3,
                                                                      bottom:
                                                                          6.5),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      left: 15,
                                                                      top: 17,
                                                                      bottom:
                                                                          11),
                                                              child: Container(
                                                                height: 33,
                                                                width: 43,
                                                                child: Image.asset(
                                                                    "assets/images/carBrand/Suzuki.png"),
                                                              ))
                                                          : Container(
                                                              height: 48,
                                                              width: 64,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      top: 11,
                                                                      bottom:
                                                                          11),
                                                              child: Image.network(
                                                                  mySubsListItem![
                                                                          index]
                                                                      .userVehicle!
                                                                      .brand!
                                                                      .image
                                                                      .toString()),
                                                            ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          mySubsListItem[index]
                                                                          .userVehicle!
                                                                          .brand!
                                                                          .name ==
                                                                      "" ||
                                                                  mySubsListItem[
                                                                              index]
                                                                          .userVehicle!
                                                                          .brand!
                                                                          .name ==
                                                                      null ||
                                                                  mySubsListItem[
                                                                              index]
                                                                          .userVehicle!
                                                                          .model!
                                                                          .name ==
                                                                      null ||
                                                                  mySubsListItem[
                                                                              index]
                                                                          .userVehicle!
                                                                          .model!
                                                                          .name ==
                                                                      ""
                                                              ? Container(
                                                                  height: 19,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              13,
                                                                          bottom:
                                                                              10),
                                                                  child: Text(
                                                                    "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13.5,
                                                                        fontFamily:
                                                                            "SemiBold"),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 19,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              31,
                                                                          top:
                                                                              13,
                                                                          bottom:
                                                                              10),
                                                                  child: Text(
                                                                    "${mySubsListItem![index].userVehicle!.brand!.name.toString()} ${mySubsListItem[index].userVehicle!.model!.name}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            "SemiBold"),
                                                                  ),
                                                                ),
                                                          mySubsListItem[index]
                                                                          .userVehicle!
                                                                          .registrationNo ==
                                                                      "" ||
                                                                  mySubsListItem[
                                                                              index]
                                                                          .userVehicle!
                                                                          .registrationNo ==
                                                                      null ||
                                                                  mySubsListItem[
                                                                              index]
                                                                          .userVehicle!
                                                                          .vehicle!
                                                                          .name ==
                                                                      "" ||
                                                                  mySubsListItem[
                                                                              index]
                                                                          .userVehicle!
                                                                          .vehicle!
                                                                          .name ==
                                                                      null
                                                              ? Container(
                                                                  height: 19,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10),
                                                                  child: Text(
                                                                    "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11.5,
                                                                        fontFamily:
                                                                            "Medium",
                                                                        color: Color(
                                                                            0xff7B7B7B)),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 19,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              31),
                                                                  child: Text(
                                                                    "${mySubsListItem[index].userVehicle!.registrationNo} | ${mySubsListItem[index].userVehicle!.vehicle!.name}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            "Medium"),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
