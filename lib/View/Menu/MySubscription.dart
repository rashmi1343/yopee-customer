import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Login/Login.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/Environment.dart';
import 'MoreMenu.dart';

class MySubscription extends StatefulWidget {
  const MySubscription({super.key});

  @override
  MySubscriptionState createState() => MySubscriptionState();
}

class MySubscriptionState extends State<MySubscription> {
  final _razorpay = Razorpay();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);

      provider.getUserSubscriptionListApi(context);
      provider.getUserUpcomingSubscriptionListApi(context);
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () {
          // String month = DateFormat("yyyy-MM-dd")
          //     .format(provider.selectedMySubscriptionDate);

          return provider.getUserSubscriptionListApi(context);
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            // appBar: AppBar(
            //   leading: Container(
            //     margin: EdgeInsets.only(left: 15),
            //     child: IconButton(
            //       iconSize: 25,
            //       icon: const Icon(Icons.arrow_back, color: Colors.white),
            //       onPressed: () {
            //         Navigator.of(context).push(PageRouteBuilder(
            //             transitionDuration: const Duration(milliseconds: 400),
            //             pageBuilder: (context, animation, secondaryAnimation) =>
            //                 MoreMenu(),
            //             transitionsBuilder: (BuildContext context,
            //                 Animation<double> animation,
            //                 Animation<double> secondaryAnimation,
            //                 Widget child) {
            //               return new SlideTransition(
            //                 position: new Tween<Offset>(
            //                   //Left to right
            //                   begin: const Offset(-1.0, 0.0),
            //                   end: Offset.zero,
            //
            //                   //Right to left
            //                   // begin:
            //                   // const Offset(1.0, 0.0),
            //                   // end: Offset.zero,
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
            //         // Navigator.of(context).pushNamed('/moreMenu');
            //       },
            //     ),
            //   ),
            //   title: Container(
            //     margin: EdgeInsets.only(left: 50),
            //     alignment: Alignment.center,
            //     child: Text(
            //       "My Subscription",
            //       style: TextStyle(
            //           fontSize: 21,
            //           fontFamily: "SemiBold",
            //           color: Colors.white),
            //     ),
            //   ),
            //   bottom: TabBar(
            //     indicator: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30), // Creates border
            //         color: Colors.greenAccent),
            //     indicatorWeight: 10,
            //     indicatorSize: TabBarIndicatorSize.tab,
            //     isScrollable: true,
            //     tabs: [
            //       Tab(
            //         text: 'Current',
            //       ),
            //       Tab(text: 'Upcoming'),
            //     ],
            //   ),
            // ),
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
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15, top: 30),
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
                                        transitionsBuilder:
                                            (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secondaryAnimation,
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
                                margin: EdgeInsets.only(left: 50, top: 30),
                                alignment: Alignment.center,
                                child: Text(
                                  "My Subscription",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontFamily: "SemiBold",
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            constraints: BoxConstraints(
                                maxHeight: double.infinity,
                                maxWidth: double.infinity),
                            decoration: BoxDecoration(
                                //This is for background color
                                color:
                                    ColorTheme.themeGrayColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(25)

                                //This is for bottom border that is needed
                                ),
                            child: TabBar(
                              tabAlignment: TabAlignment.center,
                              isScrollable: true,
                              dividerColor: Colors.transparent,
                              indicatorPadding: EdgeInsets.zero,
                              indicatorWeight: double.minPositive,
                              physics: const ClampingScrollPhysics(),
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  25.0,
                                ),
                                color: ColorTheme.themeGreenColor,
                              ),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.white,
                              //  unselectedLabelColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.tab,
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "SemiBold",
                                  color: Colors.white),
                              labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "SemiBold",
                                  color: Colors.black),
                              // indicator: UnderlineTabIndicator(
                              //   borderSide: BorderSide(
                              //       width: 2.0, color: Color(0xffF69008)),
                              // ),
                              tabs: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  alignment: Alignment.center,
                                  child: Tab(
                                    child: Text(
                                      "Current",
                                      // style: TextStyle(
                                      //     fontSize: 14,
                                      //     color: Colors.white,
                                      //     fontFamily: "Medium"),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  alignment: Alignment.center,
                                  child: Tab(
                                    child: Text(
                                      "Upcoming",
                                      // style: TextStyle(
                                      //     fontSize: 14,
                                      //     color: Colors.white,
                                      //     fontFamily: "Medium"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 374, maxHeight: 650),
                            child: TabBarView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    provider.objUserSubsListResponse.data!
                                                .length ==
                                            0
                                        ? Center(
                                            child: Container(
                                              margin: EdgeInsets.only(top: 200),
                                              child: Text(
                                                "No Subscription Available!!",
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
                                                        .objUserSubsListResponse
                                                        .data!
                                                        .length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  var mySubsListItem = provider
                                                      .objUserSubsListResponse
                                                      .data;
                                                  // final now = mySubsListItem[index].toDate;
                                                  // final String formatter = DateFormat('dd-MM-yyyy');
                                                  // final String formatted = formatter.format(now);
                                                  // print(formatted); // something like 2013-04-20
                                                  var date = DateFormat(
                                                          'dd MMM, yyyy')
                                                      .format(DateTime.parse(
                                                          mySubsListItem[index]
                                                              .toDate
                                                              .toString()));
                                                  print("data:$date");

                                                  //12-04-2020
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: double
                                                                    .infinity,
                                                                maxWidth: double
                                                                    .infinity),
                                                        // width: 377,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color:
                                                                Colors.white),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                mySubsListItem![index]
                                                                            .subscriptionId ==
                                                                        6
                                                                    ? Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                21,
                                                                            top:
                                                                                18),
                                                                        child:
                                                                            Text(
                                                                          mySubsListItem![index]
                                                                              .subscription!
                                                                              .name
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xff007BFF),
                                                                              fontFamily: "SemiBold",
                                                                              fontSize: 17),
                                                                        ),
                                                                      )
                                                                    : mySubsListItem![index].subscriptionId ==
                                                                            7
                                                                        ? Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 21, top: 18),
                                                                            child:
                                                                                Text(
                                                                              mySubsListItem![index].subscription!.name.toString(),
                                                                              style: TextStyle(color: Color(0xff747272), fontFamily: "SemiBold", fontSize: 17),
                                                                            ),
                                                                          )
                                                                        : mySubsListItem![index].subscriptionId ==
                                                                                8
                                                                            ? Container(
                                                                                margin: EdgeInsets.only(left: 21, top: 18),
                                                                                child: Text(
                                                                                  mySubsListItem![index].subscription!.name.toString(),
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "SemiBold", fontSize: 17),
                                                                                ),
                                                                              )
                                                                            : Container(
                                                                                margin: EdgeInsets.only(left: 21, top: 18),
                                                                                child: Text(
                                                                                  mySubsListItem![index].subscription!.name.toString(),
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "SemiBold", fontSize: 17),
                                                                                ),
                                                                              ),
                                                                Spacer(),
                                                                mySubsListItem![index]
                                                                            .subscriptionId ==
                                                                        6
                                                                    ? Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                21,
                                                                            top:
                                                                                18),
                                                                        child:
                                                                            Text(
                                                                          "₹${mySubsListItem![index].subscription!.price.toString()}",
                                                                          style: TextStyle(
                                                                              color: Color(0xff007BFF),
                                                                              fontFamily: "Bold",
                                                                              fontSize: 26),
                                                                        ),
                                                                      )
                                                                    : mySubsListItem![index].subscriptionId ==
                                                                            7
                                                                        ? Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 21, top: 18),
                                                                            child:
                                                                                Text(
                                                                              "₹${mySubsListItem![index].subscription!.price.toString()}",
                                                                              style: TextStyle(color: Color(0xff747272), fontFamily: "Bold", fontSize: 26),
                                                                            ),
                                                                          )
                                                                        : mySubsListItem![index].subscriptionId ==
                                                                                8
                                                                            ? Container(
                                                                                margin: EdgeInsets.only(right: 21, top: 18),
                                                                                child: Text(
                                                                                  "₹${mySubsListItem![index].subscription!.price.toString()}",
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "Bold", fontSize: 26),
                                                                                ),
                                                                              )
                                                                            : Container(
                                                                                margin: EdgeInsets.only(right: 21, top: 18),
                                                                                child: Text(
                                                                                  "₹${mySubsListItem![index].subscription!.price.toString()}",
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "Bold", fontSize: 26),
                                                                                ),
                                                                              ),
                                                              ],
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          19.5),
                                                              height: 2,
                                                              color: Color(
                                                                  0xffDDDDF7),
                                                            ),
                                                            SizedBox(
                                                              height: 14.5,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 21,
                                                                      left: 21,
                                                                      bottom:
                                                                          18),
                                                              child: Row(
                                                                children: [
                                                                  mySubsListItem[index].userVehicle!.brand!.image == "" ||
                                                                          mySubsListItem[index].userVehicle!.brand!.image ==
                                                                              null
                                                                      ? Container(
                                                                          height:
                                                                              45.5,
                                                                          width:
                                                                              56,
                                                                          padding: EdgeInsets.only(
                                                                              left:
                                                                                  7,
                                                                              top:
                                                                                  6,
                                                                              right:
                                                                                  6.3,
                                                                              bottom:
                                                                                  6.5),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors
                                                                                  .white,
                                                                              borderRadius: BorderRadius.circular(
                                                                                  6)),
                                                                          margin: EdgeInsets.only(
                                                                              left: 15,
                                                                              top: 17,
                                                                              bottom: 11),
                                                                          child: Container(
                                                                            height:
                                                                                33,
                                                                            width:
                                                                                43,
                                                                            child:
                                                                                Image.asset("assets/images/carBrand/Suzuki.png"),
                                                                          ))
                                                                      : Container(
                                                                          height:
                                                                              48,
                                                                          width:
                                                                              64,
                                                                          margin: EdgeInsets.only(
                                                                              left: 10,
                                                                              top: 11,
                                                                              bottom: 11),
                                                                          child: Image.network(mySubsListItem![index]
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
                                                                      mySubsListItem[index].userVehicle!.brand!.name == "" ||
                                                                              mySubsListItem[index].userVehicle!.brand!.name == null ||
                                                                              mySubsListItem[index].userVehicle!.model!.name == null ||
                                                                              mySubsListItem[index].userVehicle!.model!.name == ""
                                                                          ? Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 10, top: 13, bottom: 10),
                                                                              child: Text(
                                                                                "",
                                                                                style: TextStyle(fontSize: 13.5, fontFamily: "SemiBold"),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 31, top: 13, bottom: 10),
                                                                              child: Text(
                                                                                "${mySubsListItem![index].userVehicle!.brand!.name.toString()} ${mySubsListItem[index].userVehicle!.model!.name}",
                                                                                style: TextStyle(fontSize: 14, fontFamily: "SemiBold"),
                                                                              ),
                                                                            ),
                                                                      mySubsListItem[index].userVehicle!.registrationNo == "" ||
                                                                              mySubsListItem[index].userVehicle!.registrationNo == null ||
                                                                              mySubsListItem[index].userVehicle!.vehicle!.name == "" ||
                                                                              mySubsListItem[index].userVehicle!.vehicle!.name == null
                                                                          ? Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                "",
                                                                                style: TextStyle(fontSize: 11.5, fontFamily: "Medium", color: Color(0xff7B7B7B)),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 31),
                                                                              child: Text(
                                                                                "${mySubsListItem[index].userVehicle!.registrationNo} | ${mySubsListItem[index].userVehicle!.vehicle!.name}",
                                                                                style: TextStyle(fontSize: 12, fontFamily: "Medium"),
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
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Next payment on ${date}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Medium",
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 20),
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor: mySubsListItem[index]
                                                                            .subscriptionId ==
                                                                        6
                                                                    ? ColorTheme
                                                                        .themeCircularColor
                                                                    : mySubsListItem[index].subscriptionId ==
                                                                            7
                                                                        ? Color(
                                                                            0xff747272)
                                                                        : mySubsListItem[index].subscriptionId ==
                                                                                8
                                                                            ? ColorTheme.themeOrangeColor
                                                                            : ColorTheme.themeOrangeColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3.0)),
                                                                minimumSize:
                                                                    Size(
                                                                        69, 28),
                                                              ),
                                                              onPressed: () {
                                                                provider
                                                                    .setMySubscriptionIndex(
                                                                        index);

                                                                createOrder(
                                                                    mySubsListItem[
                                                                            index]
                                                                        .subscription
                                                                        .price);
                                                              },
                                                              child: const Text(
                                                                'Renew',
                                                                style: TextStyle(
                                                                    color: ColorTheme
                                                                        .themeWhiteColor,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        "Medium"),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                }),
                                          ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    provider.objUserUpcomingSubsListResponse
                                                .data!.length ==
                                            0
                                        ? Center(
                                            child: Container(
                                              margin: EdgeInsets.only(top: 200),
                                              child: Text(
                                                "No Subscription Available!!",
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
                                                        .objUserUpcomingSubsListResponse
                                                        .data!
                                                        .length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  var myUpcomingSubsListItem =
                                                      provider
                                                          .objUserUpcomingSubsListResponse
                                                          .data;
                                                  // final now = mySubsListItem[index].toDate;
                                                  // final String formatter = DateFormat('dd-MM-yyyy');
                                                  // final String formatted = formatter.format(now);
                                                  // print(formatted); // something like 2013-04-20
                                                  var date = DateFormat(
                                                          'dd MMM, yyyy')
                                                      .format(DateTime.parse(
                                                          myUpcomingSubsListItem[
                                                                  index]
                                                              .toDate
                                                              .toString()));
                                                  print("data:$date");

                                                  //12-04-2020
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: double
                                                                    .infinity,
                                                                maxWidth: double
                                                                    .infinity),
                                                        // width: 377,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color:
                                                                Colors.white),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                myUpcomingSubsListItem![index]
                                                                            .subscriptionId ==
                                                                        6
                                                                    ? Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                21,
                                                                            top:
                                                                                18),
                                                                        child:
                                                                            Text(
                                                                          myUpcomingSubsListItem![index]
                                                                              .subscription!
                                                                              .name
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xff007BFF),
                                                                              fontFamily: "SemiBold",
                                                                              fontSize: 17),
                                                                        ),
                                                                      )
                                                                    : myUpcomingSubsListItem![index].subscriptionId ==
                                                                            7
                                                                        ? Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 21, top: 18),
                                                                            child:
                                                                                Text(
                                                                              myUpcomingSubsListItem![index].subscription!.name.toString(),
                                                                              style: TextStyle(color: Color(0xff747272), fontFamily: "SemiBold", fontSize: 17),
                                                                            ),
                                                                          )
                                                                        : myUpcomingSubsListItem![index].subscriptionId ==
                                                                                8
                                                                            ? Container(
                                                                                margin: EdgeInsets.only(left: 21, top: 18),
                                                                                child: Text(
                                                                                  myUpcomingSubsListItem![index].subscription!.name.toString(),
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "SemiBold", fontSize: 17),
                                                                                ),
                                                                              )
                                                                            : Container(
                                                                                margin: EdgeInsets.only(left: 21, top: 18),
                                                                                child: Text(
                                                                                  myUpcomingSubsListItem![index].subscription!.name.toString(),
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "SemiBold", fontSize: 17),
                                                                                ),
                                                                              ),
                                                                Spacer(),
                                                                myUpcomingSubsListItem![index]
                                                                            .subscriptionId ==
                                                                        6
                                                                    ? Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                21,
                                                                            top:
                                                                                18),
                                                                        child:
                                                                            Text(
                                                                          "₹${myUpcomingSubsListItem![index].subscription!.price.toString()}",
                                                                          style: TextStyle(
                                                                              color: Color(0xff007BFF),
                                                                              fontFamily: "Bold",
                                                                              fontSize: 26),
                                                                        ),
                                                                      )
                                                                    : myUpcomingSubsListItem![index].subscriptionId ==
                                                                            7
                                                                        ? Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 21, top: 18),
                                                                            child:
                                                                                Text(
                                                                              "₹${myUpcomingSubsListItem![index].subscription!.price.toString()}",
                                                                              style: TextStyle(color: Color(0xff747272), fontFamily: "Bold", fontSize: 26),
                                                                            ),
                                                                          )
                                                                        : myUpcomingSubsListItem![index].subscriptionId ==
                                                                                8
                                                                            ? Container(
                                                                                margin: EdgeInsets.only(right: 21, top: 18),
                                                                                child: Text(
                                                                                  "₹${myUpcomingSubsListItem![index].subscription!.price.toString()}",
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "Bold", fontSize: 26),
                                                                                ),
                                                                              )
                                                                            : Container(
                                                                                margin: EdgeInsets.only(right: 21, top: 18),
                                                                                child: Text(
                                                                                  "₹${myUpcomingSubsListItem![index].subscription!.price.toString()}",
                                                                                  style: TextStyle(color: Color(0xffF69008), fontFamily: "Bold", fontSize: 26),
                                                                                ),
                                                                              ),
                                                              ],
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          19.5),
                                                              height: 2,
                                                              color: Color(
                                                                  0xffDDDDF7),
                                                            ),
                                                            SizedBox(
                                                              height: 14.5,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 21,
                                                                      left: 21,
                                                                      bottom:
                                                                          18),
                                                              child: Row(
                                                                children: [
                                                                  myUpcomingSubsListItem[index].userVehicle!.brand!.image == "" ||
                                                                          myUpcomingSubsListItem[index].userVehicle!.brand!.image ==
                                                                              null
                                                                      ? Container(
                                                                          height:
                                                                              45.5,
                                                                          width:
                                                                              56,
                                                                          padding: EdgeInsets.only(
                                                                              left:
                                                                                  7,
                                                                              top:
                                                                                  6,
                                                                              right:
                                                                                  6.3,
                                                                              bottom:
                                                                                  6.5),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors
                                                                                  .white,
                                                                              borderRadius: BorderRadius.circular(
                                                                                  6)),
                                                                          margin: EdgeInsets.only(
                                                                              left: 15,
                                                                              top: 17,
                                                                              bottom: 11),
                                                                          child: Container(
                                                                            height:
                                                                                33,
                                                                            width:
                                                                                43,
                                                                            child:
                                                                                Image.asset("assets/images/carBrand/Suzuki.png"),
                                                                          ))
                                                                      : Container(
                                                                          height:
                                                                              48,
                                                                          width:
                                                                              64,
                                                                          margin: EdgeInsets.only(
                                                                              left: 10,
                                                                              top: 11,
                                                                              bottom: 11),
                                                                          child: Image.network(myUpcomingSubsListItem![index]
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
                                                                      myUpcomingSubsListItem[index].userVehicle!.brand!.name == "" ||
                                                                              myUpcomingSubsListItem[index].userVehicle!.brand!.name == null ||
                                                                              myUpcomingSubsListItem[index].userVehicle!.model!.name == null ||
                                                                              myUpcomingSubsListItem[index].userVehicle!.model!.name == ""
                                                                          ? Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 10, top: 13, bottom: 10),
                                                                              child: Text(
                                                                                "",
                                                                                style: TextStyle(fontSize: 13.5, fontFamily: "SemiBold"),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 31, top: 13, bottom: 10),
                                                                              child: Text(
                                                                                "${myUpcomingSubsListItem![index].userVehicle!.brand!.name.toString()} ${myUpcomingSubsListItem[index].userVehicle!.model!.name}",
                                                                                style: TextStyle(fontSize: 14, fontFamily: "SemiBold"),
                                                                              ),
                                                                            ),
                                                                      myUpcomingSubsListItem[index].userVehicle!.registrationNo == "" ||
                                                                              myUpcomingSubsListItem[index].userVehicle!.registrationNo == null ||
                                                                              myUpcomingSubsListItem[index].userVehicle!.vehicle!.name == "" ||
                                                                              myUpcomingSubsListItem[index].userVehicle!.vehicle!.name == null
                                                                          ? Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                "",
                                                                                style: TextStyle(fontSize: 11.5, fontFamily: "Medium", color: Color(0xff7B7B7B)),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              height: 19,
                                                                              margin: EdgeInsets.only(left: 31),
                                                                              child: Text(
                                                                                "${myUpcomingSubsListItem[index].userVehicle!.registrationNo} | ${myUpcomingSubsListItem[index].userVehicle!.vehicle!.name}",
                                                                                style: TextStyle(fontSize: 12, fontFamily: "Medium"),
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
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      );
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // Here we get razorpay_payment_id razorpay_order_id razorpay_signature
    print(response);
    verifySignature(
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
    Provider.of<YopeeProvider>(context, listen: false).getRenewSubsApi(
        Provider.of<YopeeProvider>(context, listen: false)
            .objUserSubsListResponse
            .data[Provider.of<YopeeProvider>(context, listen: false)
                .mySubscriptionIndex]
            .userVehicleId
            .toString(),
        Provider.of<YopeeProvider>(context, listen: false)
            .objUserSubsListResponse
            .data[Provider.of<YopeeProvider>(context, listen: false)
                .mySubscriptionIndex]
            .userAddressId
            .toString(),
        Provider.of<YopeeProvider>(context, listen: false)
            .objUserSubsListResponse
            .data[Provider.of<YopeeProvider>(context, listen: false)
                .mySubscriptionIndex]
            .subscriptionId
            .toString(),
        Provider.of<YopeeProvider>(context, listen: false)
            .objUserSubsListResponse
            .data[Provider.of<YopeeProvider>(context, listen: false)
                .mySubscriptionIndex]
            .toDate
            .toString(),
        Provider.of<YopeeProvider>(context, listen: false)
            .objUserSubsListResponse
            .data[Provider.of<YopeeProvider>(context, listen: false)
                .mySubscriptionIndex]
            .subscription
            .price
            .toString(),
        context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

  void createOrder(int subscriptionPrize) async {
    String username = Environment.razorPayApiKey;
    String password = Environment.razorPayApiSecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var paymentPrice = subscriptionPrize * 100;
    print("paymentPrice:$paymentPrice");

    Map<String, dynamic> body = {
      "amount": paymentPrice,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
  }

  openGateway(String orderId) {
    var options = {
      'key': Environment.razorPayApiKey,
      'amount': 10000, //in the smallest currency sub-unit.
      'name': 'Yopee',
      'order_id': orderId, // Generate order_id using Orders API
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': '9821568115',
        'email': 'info.yopee@gmail.com',
      }
    };
    _razorpay.open(options);
  }

  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "10.0.2.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    print(res.body);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
        ),
      );
    }
  }
}
