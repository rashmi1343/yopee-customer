import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Menu/SpecialRequestScreen.dart';
import 'package:yopee_customer/View/Services/Service_detail.dart';

import '../../Entity/Response/Vehicle/VehicleTypeResponse.dart';
import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import '../../Utility/Environment.dart';
import '../../Widgets/bottom_bar.dart';

class Services extends StatefulWidget {
  ServicesState createState() => ServicesState();
}

class ServicesState extends State<Services> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      // vehicleTypeSelectionDialog(context, provider);
      provider.getCarServiceListApi(context);
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
                      provider.isSpecialRequest == true
                          ? Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SpecialRequestScreen(),
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
                              ))
                          : Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
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
                              //       begin: const Offset(1.0, 0.0),
                              //       end: Offset.zero,
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
                    },
                  ),
                  centerTitle: true,
                  title: Text(
                    "Our Services",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "SemiBold",
                        color: Color(0xff313131)),
                  ),
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
                    child: Column(
                      children: [
                        provider.objServicesResponse.data!.length == 0
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
                            : ListView.builder(
                                itemCount:
                                    provider.objServicesResponse.data.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int sectionIndex) {
                                  var serviceItems =
                                      provider.objServicesResponse.data;

                                  String timeString =
                                      serviceItems[sectionIndex].timeDuration;
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

                                  return Card(
                                    elevation: 1,
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 39,
                                        bottom: 5),
                                    child: Container(
                                      //  height: 350,
                                      constraints: BoxConstraints(
                                          maxHeight: double.infinity,
                                          maxWidth: 374),

                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffE3F1FF),
                                            ColorTheme.themeWhiteColor,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Spacer(),
                                              Container(
                                                height: 28,
                                                width: 69,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff1183FF),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight: Radius
                                                              .circular(15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5)),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${formattedTime}",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontFamily: "SemiBold",
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 22, bottom: 11),
                                            child: Text(
                                              serviceItems[sectionIndex].name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "SemiBold",
                                                  color: Color(0xff1183FF)),
                                            ),
                                          ),
                                          serviceItems[sectionIndex]
                                                  .shortDescription
                                                  .isEmpty
                                              ? Container()
                                              : Container(
                                                  // height: 92,
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          double.infinity),
                                                  width: 339,
                                                  margin: EdgeInsets.only(
                                                      left: 22,
                                                      right: 13,
                                                      bottom: 20),
                                                  child: ReadMoreText(
                                                    serviceItems[sectionIndex]
                                                        .shortDescription,
                                                    trimLines: 4,
                                                    colorClickableText:
                                                        Colors.pink,
                                                    trimMode: TrimMode.Line,
                                                    trimCollapsedText:
                                                        ' Show more',
                                                    trimExpandedText:
                                                        ' Show less',
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        fontFamily: "Regular",
                                                        color:
                                                            Color(0xff333333)),
                                                    moreStyle: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: "Medium",
                                                        color: ColorTheme
                                                            .themeBlueColor),
                                                    lessStyle: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: "Medium",
                                                        color: ColorTheme
                                                            .themeBlueColor),
                                                  )

                                                  // Text(
                                                  //   serviceItems[sectionIndex]
                                                  //       .shortDescription,
                                                  //   style: TextStyle(
                                                  //       fontSize: 13,
                                                  //       fontFamily: "Regular",
                                                  //       color: Color(0xff333333)),
                                                  // ),
                                                  ),
                                          Container(
                                              constraints: BoxConstraints(
                                                  maxHeight: double.infinity,
                                                  maxWidth: double.infinity),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 105,
                                                    width: 180,
                                                    margin: EdgeInsets.only(
                                                        left: 20, bottom: 18),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: serviceItems[
                                                                      sectionIndex]
                                                                  .name ==
                                                              "Exterior Stream Cleaning"
                                                          ? Image.asset(
                                                              "assets/images/CarServices/steam-cleaning.jpg",
                                                              height: 218,
                                                              width: 354,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                            )
                                                          : serviceItems[sectionIndex]
                                                                      .name ==
                                                                  "Interior Stream Cleaning"
                                                              ? Image.asset(
                                                                  "assets/images/CarServices/steam-cleaning.jpg",
                                                                  height: 218,
                                                                  width: 354,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                )
                                                              : serviceItems[sectionIndex]
                                                                          .name ==
                                                                      "Complete Interior Detailing"
                                                                  ? Image.asset(
                                                                      "assets/images/CarServices/complete_interior.jpg",
                                                                      height:
                                                                          218,
                                                                      width:
                                                                          354,
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                      filterQuality:
                                                                          FilterQuality
                                                                              .high,
                                                                    )
                                                                  : serviceItems[sectionIndex]
                                                                              .name ==
                                                                          "Engine Bay Stream Cleaning"
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/images/CarServices/cleaning-car-engine-bay.jpg",
                                                                          height:
                                                                              218,
                                                                          width:
                                                                              354,
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          filterQuality:
                                                                              FilterQuality.high,
                                                                        )
                                                                      : serviceItems[sectionIndex].name ==
                                                                              "Paint Protection and Warning"
                                                                          ? Image
                                                                              .asset(
                                                                              "assets/images/CarServices/paint_protection.jpg",
                                                                              height: 218,
                                                                              width: 354,
                                                                              fit: BoxFit.fitWidth,
                                                                              filterQuality: FilterQuality.high,
                                                                            )
                                                                          : serviceItems[sectionIndex].name == "Headlight Restoration"
                                                                              ? Image.asset(
                                                                                  "assets/images/CarServices/headlight_restoration.jpg",
                                                                                  height: 218,
                                                                                  width: 354,
                                                                                  fit: BoxFit.fitWidth,
                                                                                  filterQuality: FilterQuality.high,
                                                                                )
                                                                              : Image.asset(
                                                                                  "assets/images/CarServices/steam-cleaning.jpg",
                                                                                  height: 218,
                                                                                  width: 354,
                                                                                  fit: BoxFit.fitWidth,
                                                                                  filterQuality: FilterQuality.high,
                                                                                ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // height: 19,
                                                            constraints: BoxConstraints(
                                                                maxHeight: double
                                                                    .infinity,
                                                                maxWidth: double
                                                                    .infinity),
                                                            //   width: 50,
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 8,
                                                              top: 10,
                                                              right: 3,
                                                            ),
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              child: Text(
                                                                "₹${serviceItems[sectionIndex].price.toString()}",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    fontSize:
                                                                        12.5,
                                                                    fontFamily:
                                                                        "SemiBold",
                                                                    color: Color(
                                                                        0xff898989)),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            constraints: BoxConstraints(
                                                                maxHeight: double
                                                                    .infinity,
                                                                maxWidth: double
                                                                    .infinity),
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 2,
                                                              top: 10,
                                                              right: 8,
                                                            ),
                                                            child: FittedBox(
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    text:
                                                                        "₹${serviceItems[sectionIndex].discountPrice.toString()}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.5,
                                                                        fontFamily:
                                                                            "SemiBold",
                                                                        color: Color(
                                                                            0xff181818)),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            ' *',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.5,
                                                                            fontFamily:
                                                                                "SemiBold",
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: double
                                                                    .infinity,
                                                                maxWidth: double
                                                                    .infinity),
                                                        margin: EdgeInsets.only(
                                                            left: 8),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                ColorTheme
                                                                    .themeGreenColor,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6.0)),
                                                            minimumSize:
                                                                Size(90, 30),
                                                          ),
                                                          onPressed: () {
                                                            // provider.isService = true;
                                                            // provider.isSpecialRequest =
                                                            //     false;
                                                            Environment
                                                                    .selectedIndex =
                                                                sectionIndex;

                                                            print(
                                                                "selected address index:${Environment.selectedIndex}");
                                                            print(
                                                                "selected service price:${serviceItems[sectionIndex].discountPrice.toString()}");

                                                            Navigator.of(context).push(
                                                                PageRouteBuilder(
                                                                    transitionDuration: const Duration(
                                                                        milliseconds:
                                                                            400),
                                                                    pageBuilder: (context, animation, secondaryAnimation) => ServiceDetail(
                                                                        id: serviceItems[sectionIndex]
                                                                            .id
                                                                            .toString(),
                                                                        name: serviceItems[sectionIndex]
                                                                            .name
                                                                            .toString(),
                                                                        indexId: Environment.selectedIndex.toString(),
                                                                        price: serviceItems[sectionIndex].discountPrice,
                                                                        longDes: serviceItems[sectionIndex].getServiceDetails!,
                                                                        serviceDuration: formattedTime),
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
                                                            //     builder: (context) =>
                                                            //         ServiceDetail(
                                                            //             id: serviceItems[
                                                            //                     sectionIndex]
                                                            //                 .id
                                                            //                 .toString(),
                                                            //             name: serviceItems[
                                                            //                     sectionIndex]
                                                            //                 .name
                                                            //                 .toString(),
                                                            //             indexId: Environment
                                                            //                 .selectedIndex
                                                            //                 .toString(),
                                                            //             price: serviceItems[
                                                            //                     sectionIndex]
                                                            //                 .discountPrice
                                                            //                 .toString()),
                                                            //   ),
                                                            // );
                                                          },
                                                          child: const Text(
                                                            'Add',
                                                            style: TextStyle(
                                                                color: ColorTheme
                                                                    .themeBlackColor,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "SemiBold"),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        provider.objServicesResponse.data!.length == 0
                            ? Container()
                            : Text(
                                "* The final price may change based on your car selection.",
                                style: TextStyle(
                                    fontFamily: "Medium",
                                    fontSize: 10,
                                    color: Colors.red),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
            bottomNavigationBar: bottomBar(context, provider)),
      );
    });
  }

  Future<void> vehicleTypeSelectionDialog(
      BuildContext context, YopeeProvider provider) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Choose your vehicle type',
                style: TextStyle(fontSize: 14, fontFamily: "Medium"),
              ),
              content: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 17, left: 23, right: 18.5),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select type of the car';
                        } else {
                          return null;
                        }
                      },
                      items: provider.vehicleTypeList.map((item) {
                        return DropdownMenuItem(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: TextStyle(
                                fontFamily: "Regular",
                                fontSize: 14,
                                color: Color(0xff4B4B4B)),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          Navigator.pop(context);
                          provider.vehicletypedropdownvalue = value!;
                          print(
                              "car vehicle selected:${provider.vehicletypedropdownvalue}");
                        });
                        VehicleTypeData selectedCar = provider.vehicleTypeList
                            .firstWhere((element) => element.name == value);
                        int selectedCarId = selectedCar.id;
                        print("selectedCarType Id:${selectedCarId}");
                      },
                      value: provider.vehicletypedropdownvalue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
