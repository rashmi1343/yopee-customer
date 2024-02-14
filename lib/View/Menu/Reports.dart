import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/Entity/Response/ReportsListResponse.dart';
import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Menu/MoreMenu.dart';
import 'package:yopee_customer/View/RateWash.dart';

import '../../Presenter/YopeeProvider.dart';

class Reports extends StatefulWidget {
  ReportsState createState() => ReportsState();
}

class ReportsState extends State<Reports> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      String month = DateFormat("yyyy-MM-dd").format(provider.selectedDate);
      provider.getReportsListApi(month, context);
    });
  }

  Future<bool> willPopCallback() async {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
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
        //       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        //   return ScaleTransition(
        //     scale: animation.drive(tween),
        //     child: page,
        //   );
        // },
        ));

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () {
          String month = DateFormat("yyyy-MM-dd").format(provider.selectedDate);
          return provider.getReportsListApi(month, context);
        },
        child: WillPopScope(
          onWillPop: willPopCallback,
          child: Scaffold(
            backgroundColor: Colors.white,
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
                  leading: provider.reportNavFromMenu == true
                      ? IconButton(
                          iconSize: 25,
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
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
                            //Navigator.of(context).pushNamed('/moreMenu');
                          },
                        )
                      : IconButton(
                          iconSize: 25,
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Dashboard(),
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
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, page) {
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
                            ));
                            //  Navigator.of(context).pushNamed('/dashboard');
                          },
                        ),
                  centerTitle: true,
                  title: Text(
                    "Reports",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "SemiBold",
                        color: Color(0xff313131)),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        provider.selectDate(context);
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
                        ),
                      ),
                    )
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
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.date == ""
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: 20, top: 30, bottom: 15),
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Medium",
                                      color: Color(0xffA6A6A6)),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                    left: 20, top: 30, bottom: 15),
                                child: Text(
                                  "${provider.date}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Medium",
                                      color: Color(0xffA6A6A6)),
                                ),
                              ),
                        provider.objReportsListResponse.data.length == 0
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 300),
                                  child: Text(
                                    "No Reports Available!!",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Medium",
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider
                                        .objReportsListResponse.data.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  var reportListItem =
                                      provider.objReportsListResponse.data;
                                  var washImages = provider
                                      .objReportsListResponse.data[index].media;

                                  return reportListItem[index].media.isNotEmpty
                                      ? Card(
                                          margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 15),
                                          child: Container(
                                            height: 200,
                                            width: 374,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Color(0xffF6F6FE)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    reportListItem[index]
                                                                    .userVehicle!
                                                                    .brand!
                                                                    .image ==
                                                                "" ||
                                                            reportListItem[
                                                                        index]
                                                                    .userVehicle!
                                                                    .brand!
                                                                    .image ==
                                                                null
                                                        ? Container(
                                                            height: 45.5,
                                                            width: 56,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 7,
                                                                    top: 6,
                                                                    right: 6.3,
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
                                                                    bottom: 11),
                                                            child: Container(
                                                              height: 33,
                                                              width: 43,
                                                              child: Image.asset(
                                                                  "assets/images/carBrand/Suzuki.png"),
                                                            ))
                                                        : Container(
                                                            height: 45.5,
                                                            width: 56,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 7,
                                                                    top: 6,
                                                                    right: 6.3,
                                                                    bottom:
                                                                        6.5),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 17,
                                                                    bottom: 11),
                                                            child: Container(
                                                                height: 33,
                                                                width: 43,
                                                                child: Image
                                                                    .network(
                                                                        "${reportListItem[index].userVehicle!.brand!.image.toString()}")),
                                                          ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        reportListItem[index]
                                                                        .userVehicle!
                                                                        .brand!
                                                                        .name ==
                                                                    "" ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .brand!
                                                                        .name ==
                                                                    null ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .model!
                                                                        .name ==
                                                                    null ||
                                                                reportListItem[
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
                                                                        top: 13,
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
                                                                            10,
                                                                        top: 13,
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  "${reportListItem[index].userVehicle!.brand!.name.toString()} ${reportListItem[index].userVehicle!.model!.name.toString()}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontFamily:
                                                                          "SemiBold"),
                                                                ),
                                                              ),
                                                        reportListItem[index]
                                                                        .userVehicle!
                                                                        .registrationNo ==
                                                                    "" ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .registrationNo ==
                                                                    null ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .vehicle!
                                                                        .name ==
                                                                    "" ||
                                                                reportListItem[
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
                                                                            10),
                                                                child: Text(
                                                                  "${reportListItem[index].userVehicle!.registrationNo.toString()} | ${reportListItem[index].userVehicle!.vehicle!.name.toString()}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11.5,
                                                                      fontFamily:
                                                                          "Medium",
                                                                      color: Color(
                                                                          0xff7B7B7B)),
                                                                ),
                                                              )
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    reportListItem[index]
                                                                .rating ==
                                                            0
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              reportListItem[
                                                                          index]
                                                                      .cleaner
                                                                      .name
                                                                      .isEmpty
                                                                  ? reportsDialog(
                                                                      context,
                                                                      provider)
                                                                  : reportListItem[index]
                                                                              .status ==
                                                                          "Pending"
                                                                      ? reportsStatusDialog(
                                                                          context,
                                                                          provider,
                                                                          reportListItem[
                                                                              index])
                                                                      : reportListItem[index].status ==
                                                                              "Not Going"
                                                                          ? reportsStatusDeclinedDialog(
                                                                              context,
                                                                              provider,
                                                                              reportListItem[index])
                                                                          : Navigator.of(context).push(PageRouteBuilder(
                                                                              transitionDuration: const Duration(milliseconds: 400),
                                                                              pageBuilder: (context, animation, secondaryAnimation) => RateWash(
                                                                                    bookingId: reportListItem[index].id.toString(),
                                                                                  ),
                                                                              transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                                                return new SlideTransition(
                                                                                  position: new Tween<Offset>(
                                                                                    //Left to right
                                                                                    // begin: const Offset(-1.0, 0.0),
                                                                                    // end: Offset.zero,

                                                                                    //Right to left
                                                                                    // begin:
                                                                                    // const Offset(1.0, 0.0),
                                                                                    // end: Offset.zero,

                                                                                    //top to bottom
                                                                                    // begin: const Offset(
                                                                                    //     0.0,
                                                                                    //     -1.0),
                                                                                    // end: Offset
                                                                                    //     .zero,

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
                                                                              ));

                                                              // Navigator.push(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //     builder:
                                                              //         (context) =>
                                                              //             RateWash(
                                                              //       bookingId:
                                                              //           reportListItem[
                                                              //                   index]
                                                              //               .id
                                                              //               .toString(),
                                                              //     ),
                                                              //   ),
                                                              // );
                                                            },
                                                            child: Container(
                                                              height: 30,
                                                              width: 69,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 10,
                                                                      top: 15),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                  color: Color(
                                                                      0xff007BFF)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        22.47,
                                                                    width:
                                                                        13.47,
                                                                    child: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      "Rate",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Medium",
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 30,
                                                            width: 69,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10,
                                                                    top: 15),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Color(
                                                                    0xffFFFFFF)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                  height: 22.47,
                                                                  width: 13.47,
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: ColorTheme
                                                                        .themeCircularColor,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    reportListItem[
                                                                            index]
                                                                        .rating
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Medium",
                                                                      fontSize:
                                                                          13,
                                                                      color: ColorTheme
                                                                          .themeCircularColor,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                  ],
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: Color(0xffDDDDF7),
                                                ),
                                                Row(
                                                  children: [
                                                    reportListItem[index]
                                                                .cleaner
                                                                .name ==
                                                            ""
                                                        ? Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Washed by : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        11.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "Not Assigned ",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "SemiBold",
                                                                        fontSize:
                                                                            11.5,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Washed by : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        11.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: reportListItem[index]
                                                                            .cleaner!
                                                                            .name
                                                                            .toString() ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "SemiBold",
                                                                        fontSize:
                                                                            11.5,
                                                                        color: Color(
                                                                            0xff003F69)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    Spacer(),
                                                    reportListItem[index]
                                                                    .cleaner
                                                                    .status ==
                                                                "" ||
                                                            reportListItem[
                                                                        index]
                                                                    .cleaner
                                                                    .status ==
                                                                null
                                                        ? Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Job Status : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        10.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "Awaiting",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "SemiBold",
                                                                        fontSize:
                                                                            10.5,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Job Status : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        10.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: reportListItem[index].status ==
                                                                            "Not Going"
                                                                        ? "Declined"
                                                                        : reportListItem[index]
                                                                            .status
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily: "SemiBold",
                                                                        fontSize: 10.5,
                                                                        color: reportListItem[index].status == "Pending"
                                                                            ? Color(0xffFF8800)
                                                                            : reportListItem[index].status == "Not Going"
                                                                                ? Colors.red
                                                                                : Color(0xff1EB113)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 334,
                                                  height: 60,
                                                  child: ListView.builder(
                                                    physics: ScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        washImages.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          viewUploadedPicDialog(
                                                              context,
                                                              provider,
                                                              washImages);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          height: 45.5,
                                                          width: 56.3,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Image.network(
                                                              washImages[index]
                                                                  .fileName
                                                                  .toString()),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Card(
                                          margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 15),
                                          child: Container(
                                            height: 121,
                                            width: 374,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Color(0xffF6F6FE)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    reportListItem[index]
                                                                    .userVehicle!
                                                                    .brand!
                                                                    .image ==
                                                                "" ||
                                                            reportListItem[
                                                                        index]
                                                                    .userVehicle!
                                                                    .brand!
                                                                    .image ==
                                                                null
                                                        ? Container(
                                                            height: 45.5,
                                                            width: 56,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 7,
                                                                    top: 6,
                                                                    right: 6.3,
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
                                                                    bottom: 11),
                                                            child: Container(
                                                              height: 33,
                                                              width: 43,
                                                              child: Image.asset(
                                                                  "assets/images/carBrand/Suzuki.png"),
                                                            ))
                                                        : Container(
                                                            height: 45.5,
                                                            width: 56,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 7,
                                                                    top: 6,
                                                                    right: 6.3,
                                                                    bottom:
                                                                        6.5),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 17,
                                                                    bottom: 11),
                                                            child: Container(
                                                                height: 33,
                                                                width: 43,
                                                                child: Image
                                                                    .network(
                                                                        "${reportListItem[index].userVehicle!.brand!.image.toString()}")),
                                                          ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        reportListItem[index]
                                                                        .userVehicle!
                                                                        .brand!
                                                                        .name ==
                                                                    "" ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .brand!
                                                                        .name ==
                                                                    null ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .model!
                                                                        .name ==
                                                                    null ||
                                                                reportListItem[
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
                                                                        top: 13,
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
                                                                            10,
                                                                        top: 13,
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  "${reportListItem[index].userVehicle!.brand!.name.toString()} ${reportListItem[index].userVehicle!.model!.name.toString()}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontFamily:
                                                                          "SemiBold"),
                                                                ),
                                                              ),
                                                        reportListItem[index]
                                                                        .userVehicle!
                                                                        .registrationNo ==
                                                                    "" ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .registrationNo ==
                                                                    null ||
                                                                reportListItem[
                                                                            index]
                                                                        .userVehicle!
                                                                        .vehicle!
                                                                        .name ==
                                                                    "" ||
                                                                reportListItem[
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
                                                                            10),
                                                                child: Text(
                                                                  "${reportListItem[index].userVehicle!.registrationNo.toString()} | ${reportListItem[index].userVehicle!.vehicle!.name.toString()}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11.5,
                                                                      fontFamily:
                                                                          "Medium",
                                                                      color: Color(
                                                                          0xff7B7B7B)),
                                                                ),
                                                              )
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    reportListItem[index]
                                                                .rating ==
                                                            0
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              reportListItem[
                                                                          index]
                                                                      .cleaner
                                                                      .name
                                                                      .isEmpty
                                                                  ? reportsDialog(
                                                                      context,
                                                                      provider)
                                                                  : reportListItem[index]
                                                                              .status ==
                                                                          "Pending"
                                                                      ? reportsStatusDialog(
                                                                          context,
                                                                          provider,
                                                                          reportListItem[
                                                                              index])
                                                                      : reportListItem[index].status ==
                                                                              "Not Going"
                                                                          ? reportsStatusDeclinedDialog(
                                                                              context,
                                                                              provider,
                                                                              reportListItem[index])
                                                                          : Navigator.of(context).push(PageRouteBuilder(
                                                                              transitionDuration: const Duration(milliseconds: 400),
                                                                              pageBuilder: (context, animation, secondaryAnimation) => RateWash(
                                                                                    bookingId: reportListItem[index].id.toString(),
                                                                                  ),
                                                                              transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                                                return new SlideTransition(
                                                                                  position: new Tween<Offset>(
                                                                                    //Left to right
                                                                                    // begin: const Offset(-1.0, 0.0),
                                                                                    // end: Offset.zero,

                                                                                    //Right to left
                                                                                    // begin:
                                                                                    // const Offset(1.0, 0.0),
                                                                                    // end: Offset.zero,

                                                                                    //top to bottom
                                                                                    // begin: const Offset(
                                                                                    //     0.0,
                                                                                    //     -1.0),
                                                                                    // end: Offset
                                                                                    //     .zero,

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
                                                                              ));

                                                              // Navigator.push(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //     builder:
                                                              //         (context) =>
                                                              //             RateWash(
                                                              //       bookingId:
                                                              //           reportListItem[
                                                              //                   index]
                                                              //               .id
                                                              //               .toString(),
                                                              //     ),
                                                              //   ),
                                                              // );
                                                            },
                                                            child: Container(
                                                              height: 30,
                                                              width: 69,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 10,
                                                                      top: 15),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                  color: Color(
                                                                      0xff007BFF)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        22.47,
                                                                    width:
                                                                        13.47,
                                                                    child: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      "Rate",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Medium",
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 30,
                                                            width: 69,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10,
                                                                    top: 15),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Color(
                                                                    0xffFFFFFF)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                  height: 22.47,
                                                                  width: 13.47,
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: ColorTheme
                                                                        .themeCircularColor,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    reportListItem[
                                                                            index]
                                                                        .rating
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Medium",
                                                                      fontSize:
                                                                          13,
                                                                      color: ColorTheme
                                                                          .themeCircularColor,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                  ],
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: Color(0xffDDDDF7),
                                                ),
                                                Row(
                                                  children: [
                                                    reportListItem[index]
                                                                    .cleaner
                                                                    .name ==
                                                                "" ||
                                                            reportListItem[
                                                                        index]
                                                                    .cleaner
                                                                    .name ==
                                                                null
                                                        ? Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Washed by : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        11.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "Not Assigned ",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "SemiBold",
                                                                        fontSize:
                                                                            11.5,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Washed by : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        11.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: reportListItem[index]
                                                                            .cleaner!
                                                                            .name
                                                                            .toString() ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "SemiBold",
                                                                        fontSize:
                                                                            11.5,
                                                                        color: Color(
                                                                            0xff003F69)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    Spacer(),
                                                    reportListItem[index]
                                                                    .cleaner
                                                                    .status ==
                                                                "" ||
                                                            reportListItem[
                                                                        index]
                                                                    .cleaner
                                                                    .status ==
                                                                null
                                                        ? Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Job Status : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        10.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "Awaiting",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "SemiBold",
                                                                        fontSize:
                                                                            10.5,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 15,
                                                                    bottom: 15,
                                                                    right: 16),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Job Status : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        10.5,
                                                                    color: Color(
                                                                        0xff003F69)),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: reportListItem[index].status ==
                                                                            "Not Going"
                                                                        ? "Declined"
                                                                        : reportListItem[index]
                                                                            .status
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily: "SemiBold",
                                                                        fontSize: 10.5,
                                                                        color: reportListItem[index].status == "Pending"
                                                                            ? Color(0xffFF8800)
                                                                            : reportListItem[index].status == "Not Going"
                                                                                ? Colors.red
                                                                                : Color(0xff1EB113)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                }),
                      ],
                    )),
          ),
        ),
      );
    });
  }

  viewUploadedPicDialog(
    BuildContext context,
    YopeeProvider provider,
    List<Media> washImages,
  ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ), //this right here
            child: Container(
              height: 500,
              width: 374,
              child: Column(
                children: [
                  Container(
                    height: 312,
                    // height: 500,
                    width: 374,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: washImages.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 336,
                            width: 271.56,
                            margin: EdgeInsets.only(right: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "${washImages[index].fileName}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Positioned(
                  //     top: 131,
                  //     child: Container(
                  //       height: 48,
                  //       width: 49,
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: SvgPicture.asset(
                  //             "assets/images/arrow-left-solid.svg",
                  //             color: Colors.white,
                  //             height: 28,
                  //             width: 29,
                  //           )),
                  //     )),
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 49,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: SvgPicture.asset(
                        "assets/images/Close.svg",
                        height: 35,
                        width: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  reportsDialog(BuildContext context, YopeeProvider provider) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                width: 250,
                height: 230,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          // width: double.infinity,
                          // decoration: BoxDecoration(
                          //   color: ColorTheme.themeWhiteColor,
                          //   borderRadius: BorderRadius.circular(
                          //     5.00,
                          //   ),
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                    "assets/images/cleaner-man.svg"),
                                // color: Color(0xffFF0000),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18, top: 14, right: 18, bottom: 20),
                                child: Text(
                                  " No Cleaner Assigned!!",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xffFF0000),
                                    fontSize: 18,
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                //  width: 152.00,
                                margin: EdgeInsets.only(
                                  left: 18,
                                  top: 3,
                                  right: 18,
                                ),
                                child: Text(
                                  "Please contact your Administrator.",
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff606060),
                                    fontSize: 16,
                                    fontFamily: 'Regular',
                                    fontWeight: FontWeight.w400,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  reportsStatusDialog(BuildContext context, YopeeProvider provider,
      ReportsListData reportListItem) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                width: 250,
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          // width: double.infinity,
                          // decoration: BoxDecoration(
                          //   color: ColorTheme.themeWhiteColor,
                          //   borderRadius: BorderRadius.circular(
                          //     5.00,
                          //   ),
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: SvgPicture.asset(
                                    "assets/images/in-progress.svg"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              reportListItem.service is List<dynamic>
                                  ? Container(
                                      // padding: EdgeInsets.only(
                                      //     left: 18,
                                      //     top: 14,
                                      //     right: 18,
                                      //     bottom: 8),
                                      child: Text(
                                        " ${reportListItem.service!.name}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xffFFB300),
                                          fontSize: 16,
                                          fontFamily: 'SemiBold',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      // padding: EdgeInsets.only(
                                      //     left: 18,
                                      //     top: 14,
                                      //     right: 18,
                                      //     bottom: 8),
                                      child: Text(
                                        " ${reportListItem.subscription!.name}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xffFFB300),
                                          fontSize: 16,
                                          fontFamily: 'SemiBold',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, bottom: 20),
                                child: Text(
                                  " in progress!!.",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xffFFB300),
                                    fontSize: 16,
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  reportsStatusDeclinedDialog(BuildContext context, YopeeProvider provider,
      ReportsListData reportListItem) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              backgroundColor: Color(0xffF3CBCB),
              content: Container(
                width: 250,
                height: 120,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          // width: double.infinity,
                          // decoration: BoxDecoration(
                          //   color: ColorTheme.themeWhiteColor,
                          //   borderRadius: BorderRadius.circular(
                          //     5.00,
                          //   ),
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18, top: 14, right: 18, bottom: 8),
                                child: Text(
                                  " ${reportListItem.cleaner!.name} declined the job!!.",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, bottom: 2),
                                child: Text(
                                  "Your request is being assigned",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, bottom: 10),
                                child: Text(
                                  "to another cleaner.",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, bottom: 10),
                                child: Text(
                                  "Thank you for your patience!.",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

// showCancelButton(BuildContext context, YopeeProvider provider) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//             backgroundColor: Colors.transparent,
//             alignment: Alignment.bottomCenter,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ), //this right here
//             child: Container(
//               child: Image.asset("assets/images/cancel.png",
//                   color: Colors.transparent),
//             ));
//       });
// }
}
