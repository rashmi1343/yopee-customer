import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/View/Menu/MoreMenu.dart';
import 'package:yopee_customer/View/Services/Services.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import '../RateWash.dart';

class SpecialRequestScreen extends StatefulWidget {
  SpecialRequestScreenState createState() => SpecialRequestScreenState();
}

class SpecialRequestScreenState extends State<SpecialRequestScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      String month =
          DateFormat("yyyy-MM-dd").format(provider.selectedMySpecialReqDate);
      provider.getSpecialRequestListApi(month, context);
    });
  }

  Future<bool> willPopCallback() async {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => MoreMenu(),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              //Left to right
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,

              //Right to left
              // begin: const Offset(
              //     1.0, 0.0),
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MoreMenu()),
    // );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: willPopCallback,
        child: RefreshIndicator(
          onRefresh: () {
            String month = DateFormat("yyyy-MM-dd")
                .format(provider.selectedMySpecialReqDate);

            return provider.getSpecialRequestListApi(month, context);
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
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
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
                                // begin: const Offset(
                                //     1.0, 0.0),
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
                  centerTitle: true,
                  title: Text(
                    "Special Request",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "SemiBold",
                        color: Color(0xff313131)),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        provider.selectDateMySpecialReq(context);
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
                          color: Colors.green,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 400),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
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
                        // Navigator.of(context).pushNamed('/services');
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green),
                        child: Container(
                            padding: EdgeInsets.only(
                                bottom: 5, top: 3, left: 3, right: 5),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
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
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.dateMySpecialReq == ""
                            ? Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  top: 30,
                                ),
                                child: Text(
                                  "",
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
                                  "${provider.dateMySpecialReq}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Medium",
                                      color: Colors.white),
                                ),
                              ),
                        provider.objSpecialRequestListResponse.data.length == 0
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 300),
                                  child: Text(
                                    "No Request Available!!",
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
                                    .objSpecialRequestListResponse.data.length,
                                itemBuilder: (context, index) {
                                  var spclReqListItem = provider
                                      .objSpecialRequestListResponse.data;
                                  print(
                                      "Address:${spclReqListItem[index].userAddress.flatHouseNo}, ${spclReqListItem[index].userAddress.areaSector}, ${spclReqListItem[index].userAddress.nearby}");
                                  return Column(
                                    children: [
                                      Card(
                                        elevation: 1,
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 15),
                                        child: Container(
                                          height: 210,
                                          width: 374,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color(0xffF6F6FE)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 45.5,
                                                    width: 56,
                                                    padding: EdgeInsets.only(
                                                        left: 7,
                                                        top: 6,
                                                        right: 6.3,
                                                        bottom: 6.5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                    margin: EdgeInsets.only(
                                                        left: 18,
                                                        top: 17,
                                                        bottom: 11),
                                                    child: Container(
                                                        height: 33,
                                                        width: 43,
                                                        child: spclReqListItem[
                                                                        index]
                                                                    .userVehicle
                                                                    .brand!
                                                                    .image ==
                                                                null
                                                            ? Image.asset(
                                                                "assets/images/dashboard/car-solid.svg")
                                                            : Image.network(
                                                                "${spclReqListItem[index].userVehicle.brand!.image.toString()}")),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      spclReqListItem[index]
                                                                      .userVehicle
                                                                      .brand!
                                                                      .name ==
                                                                  null ||
                                                              spclReqListItem[
                                                                          index]
                                                                      .userVehicle
                                                                      .brand!
                                                                      .name ==
                                                                  "" ||
                                                              spclReqListItem[
                                                                          index]
                                                                      .userVehicle
                                                                      .model!
                                                                      .name ==
                                                                  null ||
                                                              spclReqListItem[
                                                                          index]
                                                                      .userVehicle
                                                                      .model!
                                                                      .name ==
                                                                  ""
                                                          ? Container(
                                                              height: 19,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 31,
                                                                      top: 13,
                                                                      bottom:
                                                                          10),
                                                              child: Text(
                                                                "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "SemiBold"),
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 19,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 31,
                                                                      top: 13,
                                                                      bottom:
                                                                          10),
                                                              child: Text(
                                                                "${spclReqListItem[index].userVehicle.brand!.name.toString()} ${spclReqListItem[index].userVehicle.model!.name.toString()}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "SemiBold"),
                                                              ),
                                                            ),
                                                      spclReqListItem[index]
                                                                      .userVehicle
                                                                      .registrationNo ==
                                                                  null ||
                                                              spclReqListItem[
                                                                          index]
                                                                      .userVehicle
                                                                      .registrationNo ==
                                                                  "" ||
                                                              spclReqListItem[
                                                                          index]
                                                                      .userVehicle
                                                                      .vehicle!
                                                                      .name ==
                                                                  null ||
                                                              spclReqListItem[
                                                                          index]
                                                                      .userVehicle
                                                                      .vehicle!
                                                                      .name ==
                                                                  ""
                                                          ? Container(
                                                              height: 19,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 31),
                                                              child: Text(
                                                                " ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                      left: 31),
                                                              child: Text(
                                                                "${spclReqListItem[index].userVehicle.registrationNo.toString()} | ${spclReqListItem[index].userVehicle.vehicle!.name.toString()}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        "Medium",
                                                                    color: Color(
                                                                        0xff7B7B7B)),
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 31,
                                                            ),
                                                            height: 20,
                                                            width: 17.06,
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/map-marker.svg",
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Container(
                                                            height: 19,
                                                            width: 200,
                                                            child: Text(
                                                              "${spclReqListItem[index].userAddress.flatHouseNo}, ${spclReqListItem[index].userAddress.areaSector} ${spclReqListItem[index].userAddress.nearby}",
                                                              softWrap: true,
                                                              maxLines: 10,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.5,
                                                                  fontFamily:
                                                                      "Medium",
                                                                  color: Color(
                                                                      0xff464646)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                height: 1,
                                                color: Color(0xffDDDDF7),
                                              ),
                                              Row(
                                                children: [
                                                  spclReqListItem[index]
                                                                  .cleaner
                                                                  .name ==
                                                              "" ||
                                                          spclReqListItem[index]
                                                                  .cleaner
                                                                  .name ==
                                                              null
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  top: 15,
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
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  top: 15,
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
                                                                  text: spclReqListItem[
                                                                          index]
                                                                      .cleaner
                                                                      .name
                                                                      .toString(),
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
                                                  spclReqListItem[index]
                                                          .status
                                                          .isEmpty
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  top: 15,
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
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  top: 15,
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
                                                                  text: spclReqListItem[
                                                                          index]
                                                                      .status
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "SemiBold",
                                                                      fontSize:
                                                                          10.5,
                                                                      color: spclReqListItem[index].status ==
                                                                              "Pending"
                                                                          ? Color(
                                                                              0xffFF8800)
                                                                          : Color(
                                                                              0xff1EB113)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      height: 19,
                                                      margin: EdgeInsets.only(
                                                          left: 18, top: 22),
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    'Amount: ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "SemiBold",
                                                                    fontSize:
                                                                        16,
                                                                    color: Color(
                                                                        0xff2B2B2B))),
                                                            TextSpan(
                                                              text:
                                                                  '₹${spclReqListItem[index].service.discountPrice}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "SemiBold",
                                                                  color: Color(
                                                                      0xff0072C6)),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Spacer(),
                                                  // spclReqListItem[index]
                                                  //             .rating ==
                                                  //         0
                                                  //     ? GestureDetector(
                                                  //         onTap: () {
                                                  //           spclReqListItem[
                                                  //                       index]
                                                  //                   .cleaner
                                                  //                   .name!
                                                  //                   .isEmpty
                                                  //               ? reportsDialog(
                                                  //                   context,
                                                  //                   provider)
                                                  //               : Navigator.of(context).push(PageRouteBuilder(
                                                  //                   transitionDuration: const Duration(milliseconds: 400),
                                                  //                   pageBuilder: (context, animation, secondaryAnimation) => RateWash(
                                                  //                         bookingId: spclReqListItem[index]
                                                  //                             .id
                                                  //                             .toString(),
                                                  //                       ),
                                                  //                   transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                  //                     return new SlideTransition(
                                                  //                       position: new Tween<
                                                  //                           Offset>(
                                                  //                         //Left to right
                                                  //                         // begin: const Offset(-1.0, 0.0),
                                                  //                         // end: Offset.zero,
                                                  //
                                                  //                         //Right to left
                                                  //                         // begin:
                                                  //                         // const Offset(1.0, 0.0),
                                                  //                         // end: Offset.zero,
                                                  //
                                                  //                         //top to bottom
                                                  //                         // begin: const Offset(
                                                  //                         //     0.0,
                                                  //                         //     -1.0),
                                                  //                         // end: Offset
                                                  //                         //     .zero,
                                                  //
                                                  //                         //   bottom to top
                                                  //                         begin: Offset(
                                                  //                             0.0,
                                                  //                             1.0),
                                                  //                         end: Offset
                                                  //                             .zero,
                                                  //                       ).animate(
                                                  //                           animation),
                                                  //                       child:
                                                  //                           child,
                                                  //                     );
                                                  //                   }
                                                  //                   // transitionsBuilder: (context, animation, secondaryAnimation, page) {
                                                  //                   //   var begin = 0.0;
                                                  //                   //   var end = 1.0;
                                                  //                   //   var curve = Curves.ease;
                                                  //                   //
                                                  //                   //   var tween =
                                                  //                   //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                                  //                   //   return ScaleTransition(
                                                  //                   //     scale: animation.drive(tween),
                                                  //                   //     child: page,
                                                  //                   //   );
                                                  //                   // },
                                                  //                   ));
                                                  //
                                                  //           // Navigator.push(
                                                  //           //   context,
                                                  //           //   MaterialPageRoute(
                                                  //           //     builder:
                                                  //           //         (context) =>
                                                  //           //             RateWash(
                                                  //           //       bookingId:
                                                  //           //           reportListItem[
                                                  //           //                   index]
                                                  //           //               .id
                                                  //           //               .toString(),
                                                  //           //     ),
                                                  //           //   ),
                                                  //           // );
                                                  //         },
                                                  //         child: Container(
                                                  //           height: 30,
                                                  //           width: 69,
                                                  //           margin:
                                                  //               EdgeInsets.only(
                                                  //                   right: 10,
                                                  //                   top: 15),
                                                  //           decoration: BoxDecoration(
                                                  //               borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                           3),
                                                  //               color: Color(
                                                  //                   0xff007BFF)),
                                                  //           child: Row(
                                                  //             mainAxisAlignment:
                                                  //                 MainAxisAlignment
                                                  //                     .spaceAround,
                                                  //             children: [
                                                  //               Container(
                                                  //                 height: 22.47,
                                                  //                 width: 13.47,
                                                  //                 child: Icon(
                                                  //                   Icons.star,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "Rate",
                                                  //                   style: TextStyle(
                                                  //                       fontFamily:
                                                  //                           "Medium",
                                                  //                       fontSize:
                                                  //                           13,
                                                  //                       color: Colors
                                                  //                           .white),
                                                  //                 ),
                                                  //               )
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     : Container(
                                                  //         height: 30,
                                                  //         width: 69,
                                                  //         margin:
                                                  //             EdgeInsets.only(
                                                  //                 right: 10,
                                                  //                 top: 15),
                                                  //         decoration: BoxDecoration(
                                                  //             borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(
                                                  //                         3),
                                                  //             color: Color(
                                                  //                 0xffFFFFFF)),
                                                  //         child: Row(
                                                  //           mainAxisAlignment:
                                                  //               MainAxisAlignment
                                                  //                   .spaceAround,
                                                  //           children: [
                                                  //             Container(
                                                  //               height: 22.47,
                                                  //               width: 13.47,
                                                  //               child: Icon(
                                                  //                 Icons.star,
                                                  //                 color: ColorTheme
                                                  //                     .themeCircularColor,
                                                  //               ),
                                                  //             ),
                                                  //             Container(
                                                  //               child: Text(
                                                  //                 spclReqListItem[
                                                  //                         index]
                                                  //                     .rating
                                                  //                     .toString(),
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   fontFamily:
                                                  //                       "Medium",
                                                  //                   fontSize:
                                                  //                       13,
                                                  //                   color: ColorTheme
                                                  //                       .themeCircularColor,
                                                  //                 ),
                                                  //               ),
                                                  //             )
                                                  //           ],
                                                  //         ),
                                                  //       )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                      ],
                    )),
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
              backgroundColor: Color(0xffF3CBCB),
              content: Container(
                width: 250,
                height: 100,
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
                                    left: 18, top: 14, right: 18, bottom: 20),
                                child: Text(
                                  " No Cleaner Assigned!!",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
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
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Medium',
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
}
