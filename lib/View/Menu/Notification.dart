import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import 'MoreMenu.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      provider.getListNotificationApi("", context);
      // String month = DateFormat("yyyy-MM-dd").format(provider.selectedDate);
      // provider.getReportsListApi(month, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () {
          return provider.getListNotificationApi("", context);
        },
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
                leading: IconButton(
                  iconSize: 25,
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
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
                centerTitle: true,
                title: Text(
                  "Notification",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "SemiBold",
                      color: Color(0xff313131)),
                ),
                // actions: [
                //   GestureDetector(
                //     onTap: () {
                //       provider.objListNotificationResponse.data.isEmpty
                //           ? Fluttertoast.showToast(
                //               msg: "No Notification to delete ",
                //               toastLength: Toast.LENGTH_SHORT,
                //               gravity: ToastGravity.CENTER,
                //               timeInSecForIosWeb: 1,
                //               backgroundColor: Colors.red,
                //               textColor: Colors.white,
                //               fontSize: 16.0)
                //           : provider.getDeleteNotificationApi(
                //               provider.objLoginResponse.data!.id.toString(),
                //               context);
                //     },
                //     child: SvgPicture.asset(
                //       "assets/images/notification/delete-icon.svg",
                //       height: 24,
                //       width: 24,
                //     ),
                //   ),
                //   SizedBox(
                //     width: 15,
                //   )
                // ],
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
                      SizedBox(
                        height: 43,
                      ),
                      Container(
                        height: 100,
                        width: 374,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff0000001A),
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            //BoxShadow
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16, top: 15, right: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Push Notification",
                                        style: TextStyle(
                                            fontFamily: "Medium",
                                            fontSize: 15,
                                            color: Color(0xff3D3D3D)),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: Transform.scale(
                                        transformHitTests: false,
                                        scale: .5,
                                        child: CupertinoSwitch(
                                            activeColor: Color(0xff00FF00),
                                            thumbColor:
                                                ColorTheme.themeWhiteColor,
                                            trackColor: Colors.black12,
                                            value: provider.pushNotify,
                                            onChanged: (value) {
                                              setState(() {
                                                // showAlertDialog(
                                                //     provider, context, value);
                                              });
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Notify Monthly Payment",
                                        style: TextStyle(
                                            fontFamily: "Medium",
                                            fontSize: 15,
                                            color: Color(0xff3D3D3D)),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: Transform.scale(
                                        transformHitTests: false,
                                        scale: .5,
                                        child: CupertinoSwitch(
                                          activeColor: Color(0xff00FF00),
                                          thumbColor:
                                              ColorTheme.themeWhiteColor,
                                          trackColor: Colors.black12,
                                          value: provider.notifyMonthlyPayment,
                                          onChanged: (value) => setState(() =>
                                              provider.notifyMonthlyPayment =
                                                  value),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // provider.setUnreadNotificationVisibility(true);
                              // provider.getListNotificationApi("unread", context);
                              // Navigator.of(context).pushNamed('/newNotification');
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 21, bottom: 10, top: 25),
                              child: Text(
                                "Today",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Medium",
                                    color: Color(0xff0BADBC)),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              provider.getReadNotificationApi("", context);
                              provider.setMarkAllNotification(true);
                              // provider.setUnreadNotificationVisibility(true);
                              // provider.getListNotificationApi("unread", context);
                              // Navigator.of(context).pushNamed('/newNotification');
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 21, bottom: 10, top: 25, right: 20),
                              child: Text(
                                "Mark All Read",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Medium",
                                    color: provider.markAll
                                        ? Color(0xff0BADBC)
                                        : Color(0xffdc6b6a)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      provider.objListNotificationResponse.data.isEmpty
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 100),
                                child: Text(
                                  "No Notification to Display!!",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Medium",
                                      color: Colors.red),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: provider
                                  .objListNotificationResponse.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var listNotificationItem =
                                    provider.objListNotificationResponse.data;
                                // print(
                                //     "content:${provider.objListNotificationResponse.data[index].message!.content}");

                                RegExp regExps = RegExp(r'(\b\w+\b)');
                                RegExp carNameExps =
                                    RegExp(r'(?<=for wash by )(\w+)');
                                String s = listNotificationItem[index]
                                    .message
                                    .content
                                    .toString();
                                bool substr = listNotificationItem[index]
                                    .message
                                    .content
                                    .contains("Subscription for");
                                // List<String> splittedSubStr = washstr.split("");
                                // print("splittedSubStr:$splittedSubStr");
                                RegExp regExp = RegExp(r"\s+");
                                // List<String> words = regExp.split(s);
                                //
                                // print(
                                //     words); // Output: [This, is, a, test, string]
                                if (substr == true) {
                                  String subCarName = s[2];
                                  String subRegNo = s[3];
                                  String subfull = s.substring(3, s.length);
                                  print("subCarName:$subCarName");
                                  print("subRegNo:$subRegNo");
                                  print("subfull:$subfull");
                                } else {
                                  String washCarName = s[0];
                                  String washRegNo = s[1];
                                  String washfull = s.substring(1, s.length);

                                  print("washCarName:$washCarName");
                                  print("washRegNo:$washRegNo");
                                  print("washfull:$washfull");
                                }

                                List<Match> matches = regExps
                                    .allMatches(listNotificationItem[index]
                                        .message
                                        .content
                                        .toString())
                                    .toList();

                                if (matches.length >= 2 &&
                                    listNotificationItem[index]
                                        .message
                                        .content
                                        .toString()
                                        .contains("Subscription for")) {
                                  Future.delayed(Duration.zero, () async {
                                    provider.getCarName(matches[2].group(0));
                                    provider.getRegNumber(matches[3].group(0));
                                    provider.getfullMessage(
                                        listNotificationItem[index]
                                            .message
                                            .content
                                            .substring(matches[3].end)
                                            .trim());
                                  });
                                } else {
                                  Future.delayed(Duration.zero, () async {
                                    provider
                                        .getCarNameWash(matches[0].group(1));
                                    provider
                                        .getRegNumberWash(matches[1].group(1));

                                    provider.getfullMessageWash(
                                        listNotificationItem[index]
                                            .message
                                            .content
                                            .split("by")
                                            .toString());
                                  });
                                }

                                return GestureDetector(
                                    onTap: () {
                                      listNotificationItem[index]
                                                  .message
                                                  .status ==
                                              "unread"
                                          ? provider.getReadNotificationApi(
                                              listNotificationItem[index]
                                                  .message
                                                  .id
                                                  .toString(),
                                              context)
                                          : Container();
                                    },
                                    child: listNotificationItem[index]
                                                .message!
                                                .status ==
                                            "read"
                                        ? Dismissible(
                                            key: Key(index.toString()),
                                            direction:
                                                DismissDirection.endToStart,
                                            onDismissed: (direction) {
                                              provider.getDeleteNotificationApi(
                                                  provider
                                                      .objListNotificationResponse
                                                      .data[index]
                                                      .message!
                                                      .id
                                                      .toString(),
                                                  context);
                                            },
                                            background: Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 5),
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                color: Color(0xffF3CBCB),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: SvgPicture.asset(
                                                        "assets/images/notification/delete-icon.svg",
                                                        height: 24,
                                                        width: 24,
                                                        color:
                                                            Color(0xffdc6b6a),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            child: Container(
                                                height: 88,
                                                width: 375,
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffedf3ff),
                                                        width: 1),
                                                    color: Color(0xffBBDCB7)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 17,
                                                                  bottom: 20,
                                                                  top: 15),
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              color: Color(
                                                                  0xffF6F6FE)),
                                                          child: SvgPicture.asset(
                                                              "assets/images/read.svg"),
                                                        ),
                                                        listNotificationItem[
                                                                    index]
                                                                .message!
                                                                .content!
                                                                .contains(
                                                                    "Subscription for")
                                                            ? Container(
                                                                width: 230,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                ),
                                                                child:

                                                                    //     Text.rich(
                                                                    //   softWrap:
                                                                    //       true,
                                                                    //   maxLines: 5,
                                                                    //   TextSpan(
                                                                    //     children: [
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             "Subscription for",
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.carName,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.regNumber,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff0072C6)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.fullMessage,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //     ],
                                                                    //   ),
                                                                    // )
                                                                    Text(
                                                                  listNotificationItem[
                                                                          index]
                                                                      .message!
                                                                      .content
                                                                      .toString(),
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 5,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Medium",
                                                                      fontSize:
                                                                          13.5,
                                                                      color: Color(
                                                                          0xff3B3B3B)),
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 230,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                ),
                                                                child:
                                                                    //     Text.rich(
                                                                    //   softWrap:
                                                                    //       true,
                                                                    //   maxLines: 5,
                                                                    //   TextSpan(
                                                                    //     children: [
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.carNameWash,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.regNumberWash,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff0072C6)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             "started for wash by",
                                                                    //         // "started for wash.",
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:"${
                                                                    //             provider.objReportsListResponse.data[index].cleaner.name
                                                                    //         }.",
                                                                    //         // "started for wash.",
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //     ],
                                                                    //   ),
                                                                    // )
                                                                    Text(
                                                                  listNotificationItem[
                                                                          index]
                                                                      .message!
                                                                      .content
                                                                      .toString(),
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 5,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Medium",
                                                                      fontSize:
                                                                          13.5,
                                                                      color: Color(
                                                                          0xff3B3B3B)),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          )
                                        : Dismissible(
                                            key: Key(index.toString()),
                                            direction:
                                                DismissDirection.endToStart,
                                            onDismissed: (direction) {
                                              provider.getDeleteNotificationApi(
                                                  provider
                                                      .objListNotificationResponse
                                                      .data[index]
                                                      .message!
                                                      .id
                                                      .toString(),
                                                  context);
                                            },
                                            background: Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 5),
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                color: Color(0xffF3CBCB),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: SvgPicture.asset(
                                                        "assets/images/notification/delete-icon.svg",
                                                        height: 24,
                                                        width: 24,
                                                        color:
                                                            Color(0xffdc6b6a),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            child: Container(
                                                height: 88,
                                                width: 375,
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffF3CBCB),
                                                        width: 1),
                                                    color: Color(0xffF3CBCB)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  bottom: 20,
                                                                  top: 15),
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              color: Color(
                                                                  0xffF6F6FE)),
                                                          child: SvgPicture.asset(
                                                              "assets/images/unread.svg"),
                                                        ),
                                                        listNotificationItem[
                                                                    index]
                                                                .message!
                                                                .content!
                                                                .contains(
                                                                    "Subscription for")
                                                            ? Container(
                                                                width: 230,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                ),
                                                                child:
                                                                    //     Text.rich(
                                                                    //   softWrap:
                                                                    //       true,
                                                                    //   maxLines: 5,
                                                                    //   TextSpan(
                                                                    //     children: [
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             "Subscription for",
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.carName,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.regNumber,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff0072C6)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.fullMessage,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //     ],
                                                                    //   ),
                                                                    // )
                                                                    Text(
                                                                  listNotificationItem[
                                                                          index]
                                                                      .message!
                                                                      .content
                                                                      .toString(),
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 5,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Medium",
                                                                      fontSize:
                                                                          13.5,
                                                                      color: Color(
                                                                          0xff3B3B3B)),
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 230,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                ),
                                                                child:
                                                                    //     Text.rich(
                                                                    //   softWrap:
                                                                    //       true,
                                                                    //   maxLines: 5,
                                                                    //   TextSpan(
                                                                    //     children: [
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.carNameWash,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             provider.regNumberWash,
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff0072C6)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             "started for wash by",
                                                                    //         // "started for wash.",
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text:
                                                                    //             '\ ',
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "SemiBold",
                                                                    //             fontSize: 14,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //       TextSpan(
                                                                    //         text: "${
                                                                    //           provider.objReportsListResponse.data[index].cleaner.name
                                                                    //         }.",
                                                                    //
                                                                    //         // "started for wash.",
                                                                    //         style: TextStyle(
                                                                    //             fontFamily: "Medium",
                                                                    //             fontSize: 13.5,
                                                                    //             color: Color(0xff3B3B3B)),
                                                                    //       ),
                                                                    //     ],
                                                                    //   ),
                                                                    // )
                                                                    Text(
                                                                  listNotificationItem[
                                                                          index]
                                                                      .message!
                                                                      .content
                                                                      .toString(),
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 5,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Medium",
                                                                      fontSize:
                                                                          13.5,
                                                                      color: Color(
                                                                          0xff3B3B3B)),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ));
                              }),
                    ],
                  )),
        ),
      );
    });
  }

  Future<void> showAlertDialog(
      YopeeProvider provider, BuildContext context, bool value) async {
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
                          provider.pushNotify = value;
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
                          provider.pushNotify = value;
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
}
