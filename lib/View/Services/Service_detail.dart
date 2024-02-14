import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/Entity/Response/Services/ServicesResponse.dart';
import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/View/Services/Service_address.dart';

import '../../Presenter/YopeeProvider.dart';
import '../VehicleList.dart';
import 'Services.dart';

class ServiceDetail extends StatefulWidget {
  String id;
  String indexId;
  String name;
  int price;
  List<GetServiceDetail> longDes;
  String serviceDuration;

  ServiceDetail(
      {required this.id,
      required this.indexId,
      required this.name,
      required this.price,
      required this.longDes,
      required this.serviceDuration});

  ServiceDetailState createState() => ServiceDetailState();
}

class ServiceDetailState extends State<ServiceDetail> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      // provider.getCarServiceDetailsApi(widget.id, context);
    });
  }

  final items = [
    Image.asset('assets/images/detailing_service.png'),
    Image.asset('assets/images/exterior_service.png'),
    Image.asset('assets/images/interior_service.png'),
  ];

  int currentIndex = 0;
  Future<bool> willPopCallback() async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Dashboard(),
    //   ),
    // );
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => Services(),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
                centerTitle: true,
                title: Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 16.5,
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
                      Container(
                          height: 218,
                          width: 354,
                          margin: EdgeInsets.only(left: 22, right: 20, top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.name ==
                                    // "Exterior Stream Cleaning"
                                    "Exterior Steam Cleaning"
                                ? Image.asset(
                                    "assets/images/CarServices/steam-cleaning.jpg",
                                    height: 218,
                                    width: 354,
                                    fit: BoxFit.fitWidth,
                                    filterQuality: FilterQuality.high,
                                  )
                                : widget.name == "Interior Stream Cleaning"
                                    ? Image.asset(
                                        "assets/images/CarServices/steam-cleaning.jpg",
                                        height: 218,
                                        width: 354,
                                        fit: BoxFit.fitWidth,
                                        filterQuality: FilterQuality.high,
                                      )
                                    : widget.name ==
                                            "Complete Interior Detailing"
                                        ? Image.asset(
                                            "assets/images/CarServices/complete_interior.jpg",
                                            height: 218,
                                            width: 354,
                                            fit: BoxFit.fitWidth,
                                            filterQuality: FilterQuality.high,
                                          )
                                        : widget.name ==
                                                "Engine Bay Stream Cleaning"
                                            ? Image.asset(
                                                "assets/images/CarServices/cleaning-car-engine-bay.jpg",
                                                height: 218,
                                                width: 354,
                                                fit: BoxFit.fitWidth,
                                                filterQuality:
                                                    FilterQuality.high,
                                              )
                                            : widget.name ==
                                                    "Paint Protection and Warning"
                                                ? Image.asset(
                                                    "assets/images/CarServices/paint_protection.jpg",
                                                    height: 218,
                                                    width: 354,
                                                    fit: BoxFit.fitWidth,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  )
                                                : widget.name ==
                                                        "Headlight Restoration"
                                                    ? Image.asset(
                                                        "assets/images/CarServices/headlight_restoration.jpg",
                                                        height: 218,
                                                        width: 354,
                                                        fit: BoxFit.fitWidth,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      )
                                                    : Image.asset(
                                                        "assets/images/CarServices/steam-cleaning.jpg",
                                                        height: 218,
                                                        width: 354,
                                                        fit: BoxFit.fitWidth,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      ),
                          )),
                      Row(
                        children: [
                          Container(
                            height: 34,
                            width: 34,
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: Color(0xffD0E5FA), width: 1),
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
                              height: 16,
                              width: 16,
                              margin: const EdgeInsets.all(9),
                              child: SvgPicture.asset(
                                  "assets/images/clock-regular.svg"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 26, bottom: 30),
                            child: Text(
                              "Takes ${widget.serviceDuration}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "SemiBold",
                                  color: Color(0xff313131)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 34,
                            width: 34,
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: Color(0xffD0E5FA), width: 1),
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
                              height: 16,
                              width: 16,
                              margin: const EdgeInsets.all(9),
                              child: SvgPicture.asset(
                                  "assets/images/face-smile-regular.svg"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.longDes.length,
                              itemBuilder: (BuildContext context, int index) {
                                var serviceDetailItem = widget.longDes;
                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(right: 20, top: 5),
                                  child: Text(
                                    "- ${serviceDetailItem[index].name}",
                                    textAlign: TextAlign.justify,
                                    maxLines: 3,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Medium",
                                        color: Color(0xff555555)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          bottomNavigationBar: Material(
            child: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(left: 21, right: 20, bottom: 35),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.themeGreenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    minimumSize: Size(374, 56),
                  ),
                  onPressed: () {
                    print("selected service price:${widget.price}");

                    //
                    if (provider.isSpecialRequest == true) {
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  VehicleList(
                                    id: widget.id,
                                    price: widget.price,
                                    vehicleImagePath: '',
                                    vehicleBrandName: '',
                                    vehicleModelName: '',
                                    vehicleTypeName: '',
                                    vehicleRegNo: '',
                                    vehicleId: '',
                                    serviceId: widget.id.toString(),
                                    serviceName: widget.name,
                                    image: '',
                                    longDesc: [],
                                    timeDuration: '',
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
                    } else {
                      //  provider.isService = true;
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  VehicleList(
                                    id: widget.id,
                                    price: widget.price!.toInt(),
                                    vehicleImagePath: '',
                                    vehicleBrandName: '',
                                    vehicleModelName: '',
                                    vehicleTypeName: '',
                                    vehicleRegNo: '',
                                    vehicleId: '',
                                    serviceId: widget.id.toString(),
                                    serviceName: widget.name,
                                    image: '',
                                    longDesc: [],
                                    timeDuration: '',
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
                      // Navigator.of(context).push(PageRouteBuilder(
                      //     transitionDuration: const Duration(milliseconds: 400),
                      //     pageBuilder: (context, animation, secondaryAnimation) =>
                      //         ServiceAddress(
                      //             vehicleImagePath: "",
                      //             vehicleBrandName: "",
                      //             vehicleModelName: "",
                      //             vehicleTypeName: "",
                      //             vehicleRegNo: "",
                      //             vehicleId: "",
                      //             serviceId: "",
                      //             price: ""),
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
                      //           begin: const Offset(1.0, 0.0),
                      //           end: Offset.zero,
                      //
                      //           //top to bottom
                      //           // begin: const Offset(0.0, -1.0),
                      //           // end: Offset.zero,
                      //
                      //           //   bottom to top
                      //           // begin: Offset(0.0, 1.0),
                      //           // end: Offset.zero,
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
                      //     //   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      //     //   return ScaleTransition(
                      //     //     scale: animation.drive(tween),
                      //     //     child: page,
                      //     //   );
                      //     // },
                      //     ));
                    }

                    //  Navigator.of(context).pushNamed('/serviceAddress');
                  },
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                        color: ColorTheme.themeBlackColor,
                        fontSize: 16,
                        fontFamily: "SemiBold"),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
