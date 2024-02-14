import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/Entity/Response/Subscription/SubscriptionDetailsResponse.dart';
import 'package:yopee_customer/Utility/Environment.dart';
import 'package:yopee_customer/View/Subscription/SubscriptionDetail.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import '../Home/Dashboard.dart';

class ImageData {
  final String imagePath;
  bool isSelected;

  ImageData({
    required this.imagePath,
    required this.isSelected,
  });
}

class TextColor {
  final Color textColor;

  TextColor({
    required this.textColor,
  });
}

class Subscription extends StatefulWidget {
  SubscriptionState createState() => SubscriptionState();
}

class SubscriptionState extends State<Subscription> {
  // Define a list of ImageData objects
  List<ImageData> imageDataList = [
    ImageData(
      imagePath: "assets/images/subscription/special_pkg.svg",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/subscription/silver_pkg.svg",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/subscription/gold_pkg.svg",
      isSelected: false,
    ),
  ];
  List<TextColor> textColorList = [
    TextColor(textColor: Color(0xff007BFF)),
    TextColor(textColor: Color(0xff6F6F6F)),
    TextColor(textColor: Color(0xffF69008)),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      provider.getBasicSubscriptionListApi(context);

      // provider.setSelectedIndex(-1);
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
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: willPopCallback,
        child: Scaffold(
            body: SingleChildScrollView(
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
            child: provider.isLoading
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: ColorTheme.themeCircularColor,
                      backgroundColor: ColorTheme.themeLightGrayColor,
                    ))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 21,
                            // ),
                            IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Dashboard(),
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
                                    // transitionsBuilder:
                                    //     (context, animation, secondaryAnimation, page) {
                                    //   var begin = 0.0;
                                    //   var end = 1.0;
                                    //   var curve = Curves.ease;
                                    //
                                    //   var tween = Tween(begin: begin, end: end)
                                    //       .chain(CurveTween(curve: curve));
                                    //   return ScaleTransition(
                                    //     scale: animation.drive(tween),
                                    //     child: page,
                                    //   );
                                    // },
                                    ));
                                // Navigator.of(context).pushNamed('/dashboard');
                              },
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Container(
                              // margin: const EdgeInsets.only(
                              //   left: 79,
                              // ),
                              child: const Text(
                                "Subscription",
                                style: TextStyle(
                                    fontFamily: "SemiBold",
                                    fontSize: 26,
                                    color: ColorTheme.themeWhiteColor),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: const Text(
                            "Choose plan that you want to provide",
                            style: TextStyle(
                                fontFamily: "Medium",
                                fontSize: 16,
                                color: ColorTheme.themeWhiteColor),
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: provider
                                .objBasicSubscriptionListResponse.data.length,
                            itemBuilder: (context, index) {
                              var subsListItem = provider
                                  .objBasicSubscriptionListResponse.data;
                              var subMenuItems =
                                  subsListItem[index].subscriptionDetails;

                              return Container(
                                //  width: 374,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 25),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 15, top: 21),
                                          child: Image.network(
                                            //  imageDataList[index].imagePath,
                                            subsListItem![index]
                                                .image
                                                .toString(),
                                            //  "assets/images/subscription/special_pkg.svg",
                                            height: 72,
                                            width: 72,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              Fluttertoast.showToast(
                                                  msg: "Something went wrong!!",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Dashboard()),
                                                      ));
                                              return Container();
                                            },
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 18, top: 30),
                                              child: Text(
                                                subsListItem![index]
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: "SemiBold",
                                                    fontSize: 14.5,
                                                    color: Color(0xff575757)),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 24, top: 15),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text:
                                                            "₹${subsListItem[index].price.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "SemiBold",
                                                            color: Color(
                                                                0xff2D2D2D)),
                                                        children: [
                                                          TextSpan(
                                                            text: ' *',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "SemiBold",
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                    )

                                                    // Text(
                                                    //   "₹${subsListItem[index].price.toString()}",
                                                    //   style: TextStyle(
                                                    //       fontFamily: "SemiBold",
                                                    //       fontSize: 30,
                                                    //       color:
                                                    //           Color(0xff2D2D2D)),
                                                    // ),
                                                    ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 9, top: 15),
                                                  height: 35,
                                                  width: 2,
                                                  color: Color(0xff575757),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 11, top: 15),
                                                  child: const Text(
                                                    "Per\nMonth",
                                                    style: TextStyle(
                                                        fontFamily: "Medium",
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff2D2D2D)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.only(
                                              right: 13, bottom: 40),
                                          child: InkWell(
                                            onTap: () {
                                              // setState(() {
                                              // subsListItem[index]
                                              //         .isPackageSelected =
                                              //     !subsListItem[index]
                                              //         .isPackageSelected;

                                              String timeString =
                                                  subsListItem[index]
                                                      .timeDuration;
                                              List<String> timeParts =
                                                  timeString.split(':');
                                              int hours =
                                                  int.parse(timeParts[0]);
                                              int minutes =
                                                  int.parse(timeParts[1]);
                                              int seconds =
                                                  int.parse(timeParts[2]);

                                              Duration duration = Duration(
                                                  hours: hours,
                                                  minutes: minutes,
                                                  seconds: seconds);

                                              String formattedTime =
                                                  "${duration.inMinutes}\nmins";

                                              print(
                                                  "formattedTime:$formattedTime");
                                              provider.setSelectedIndex(
                                                  index, formattedTime);
                                              print(
                                                  "selectedIndex:${provider.selectedIndex}");

                                              //    });
                                            },
                                            child: index ==
                                                    provider.selectedIndex
                                                ? Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff007BFF)),
                                                    child: Container(
                                                        height: 12.09,
                                                        width: 9,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: SvgPicture.asset(
                                                          "assets/images/check-solid.svg",
                                                          color: Colors.white,
                                                        )),
                                                  )
                                                : Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffC2C2C2),
                                                            width: 2)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container()),
                                                  ),
                                          ),
                                        ),
                                        // Container(
                                        //   alignment: Alignment.topRight,
                                        //   margin: EdgeInsets.only(
                                        //       right: 13, bottom: 40),
                                        //   child: InkWell(
                                        //     onTap: () {
                                        //       provider.setSelectedIndex(
                                        //           index, true);
                                        //       provider
                                        //           .setSelectedImageIndex(index);
                                        //       print(
                                        //           "selectedIndex:${provider.selectedIndex}");
                                        //       print(
                                        //           "selectedImageIndex:${provider.selectedImageIndex}");
                                        //     },
                                        //     child: subsListItem[index]
                                        //                 .isPackageSelected ==
                                        //             true
                                        //         ? Container(
                                        //             height: 30,
                                        //             width: 30,
                                        //             decoration: BoxDecoration(
                                        //                 shape: BoxShape.circle,
                                        //                 color: Color(0xff007BFF)),
                                        //             child: Container(
                                        //                 height: 12.09,
                                        //                 width: 9,
                                        //                 padding:
                                        //                     EdgeInsets.all(5),
                                        //                 child: SvgPicture.asset(
                                        //                   "assets/images/check-solid.svg",
                                        //                   color: Colors.white,
                                        //                 )),
                                        //           )
                                        //         : Container(
                                        //             height: 30,
                                        //             width: 30,
                                        //             decoration: BoxDecoration(
                                        //                 shape: BoxShape.circle,
                                        //                 color: Colors.white,
                                        //                 border: Border.all(
                                        //                     color:
                                        //                         Color(0xffC2C2C2),
                                        //                     width: 2)),
                                        //             child: Padding(
                                        //                 padding:
                                        //                     const EdgeInsets.all(
                                        //                         10.0),
                                        //                 child: Container()),
                                        //           ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    subMenuItems.isEmpty
                                        ? Container()
                                        : Flexible(
                                            //height: 400,
                                            child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: 2,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 2),
                                                  child: Row(
                                                    children: [
                                                      subMenuItems?[index]
                                                                  .subscriptionId ==
                                                              1
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 21,
                                                                      top: 5,
                                                                      bottom: 5,
                                                                      right: 5),
                                                              height: 10,
                                                              width: 10,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: Color(
                                                                      0xff007BFF)),
                                                            )
                                                          : subMenuItems?[index]
                                                                      .subscriptionId ==
                                                                  2
                                                              ? Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              21,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          right:
                                                                              5),
                                                                  height: 10,
                                                                  width: 10,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Color(
                                                                          0xff6F6F6F)),
                                                                )
                                                              : subMenuItems?[index]
                                                                          .subscriptionId ==
                                                                      3
                                                                  ? Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              21,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          right:
                                                                              5),
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          color:
                                                                              Color(0xffF69008)),
                                                                    )
                                                                  : Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              21,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          right:
                                                                              5),
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          color:
                                                                              Color(0xff007BFF)),
                                                                    ),
                                                      subMenuItems?[index]
                                                                  .subscriptionId ==
                                                              1
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 8,
                                                                      right: 20,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              width: 250,
                                                              child: Text(
                                                                subMenuItems![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                softWrap: true,
                                                                maxLines: 30,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Medium",
                                                                    fontSize:
                                                                        14,
                                                                    color: Color(
                                                                        0xff007BFF)),
                                                              ),
                                                            )
                                                          : subMenuItems?[index]
                                                                      .subscriptionId ==
                                                                  2
                                                              ? Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                  width: 250,
                                                                  child: Text(
                                                                    subMenuItems![
                                                                            index]
                                                                        .name
                                                                        .toString(),
                                                                    softWrap:
                                                                        true,
                                                                    maxLines:
                                                                        30,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Medium",
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xff6F6F6F)),
                                                                  ),
                                                                )
                                                              : subMenuItems?[index]
                                                                          .subscriptionId ==
                                                                      3
                                                                  ? Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                      width:
                                                                          250,
                                                                      child:
                                                                          Text(
                                                                        subMenuItems![index]
                                                                            .name
                                                                            .toString(),
                                                                        softWrap:
                                                                            true,
                                                                        maxLines:
                                                                            30,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Medium",
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Color(0xffF69008)),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                      width:
                                                                          250,
                                                                      child:
                                                                          Text(
                                                                        subMenuItems![index]
                                                                            .name
                                                                            .toString(),
                                                                        softWrap:
                                                                            true,
                                                                        maxLines:
                                                                            30,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Medium",
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Color(0xff007BFF)),
                                                                      ),
                                                                    ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "* The final price may change based on your car selection.",
                          style: TextStyle(
                              fontFamily: "Bold",
                              fontSize: 11,
                              color: Colors.redAccent),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 21, right: 20, bottom: 35),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorTheme.themeGreenColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              minimumSize: Size(374, 56),
                            ),
                            onPressed: () {
                              provider.selectedIndex == -1
                                  ? Fluttertoast.showToast(
                                      msg:
                                          "Please select a Subscription package",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                  : Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          SubscriptionDetailScreen(
                                            id: provider
                                                .objBasicSubscriptionListResponse
                                                .data![provider.selectedIndex]
                                                .id
                                                .toString(),
                                            name: provider
                                                .objBasicSubscriptionListResponse
                                                .data![provider.selectedIndex]
                                                .name
                                                .toString(),
                                            price: provider
                                                .objBasicSubscriptionListResponse
                                                .data![provider.selectedIndex]
                                                .price,
                                            image: provider
                                                .objBasicSubscriptionListResponse
                                                .data![provider.selectedIndex]
                                                .image
                                                .toString(),
                                            longDesc: provider
                                                .objBasicSubscriptionListResponse
                                                .data![provider.selectedIndex]
                                                .subscriptionDetails,
                                            timeDuration: provider.timeDuration,

                                            // imagePath: subsListItem![index].image,
                                            // imagePath: imageDataList[
                                            //         provider.selectedImageIndex]

                                            // .imagePath),
                                          ),
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
                                      // transitionsBuilder:
                                      //     (context, animation, secondaryAnimation, page) {
                                      //   var begin = 0.0;
                                      //   var end = 1.0;
                                      //   var curve = Curves.ease;
                                      //
                                      //   var tween = Tween(begin: begin, end: end)
                                      //       .chain(CurveTween(curve: curve));
                                      //   return ScaleTransition(
                                      //     scale: animation.drive(tween),
                                      //     child: page,
                                      //   );
                                      ));
                              // Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               SubscriptionDetailScreen(
                              //             id: provider
                              //                 .objSubscriptionListResponse
                              //                 .data![provider.selectedIndex]
                              //                 .id
                              //                 .toString(),
                              //
                              //             // imagePath: subsListItem![index].image,
                              //             // imagePath: imageDataList[
                              //             //         provider.selectedImageIndex]
                              //
                              //             // .imagePath),
                              //           ),
                              //         ),
                              //       );
                            },
                            child: const Text(
                              'Start Plan',
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
        )),
      );
    });
  }
}
