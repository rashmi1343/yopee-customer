import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleListResponse.dart';
import 'package:yopee_customer/Utility/Environment.dart';
import 'package:yopee_customer/View/AddVehicle/AddNewVehicle.dart';
import 'package:yopee_customer/View/Services/Service_address.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import '../Address/saved_address.dart';
import '../VehicleList.dart';
import 'PayNowScreen.dart';

class PaymentScreen extends StatefulWidget {
  String vehicleId;
  String vehicleImagePath;
  String vehicleBrandName;
  String vehicleModelName;
  String vehicleTypeName;
  String vehicleRegNo;
  String addressId;
  String addrressType;
  String flatHouseNo;
  String area;
  String nearBy;
  String subscriptionId;
  int subscriptionPrize;

  PaymentScreen(
      {required this.vehicleImagePath,
      required this.vehicleBrandName,
      required this.vehicleModelName,
      required this.vehicleTypeName,
      required this.vehicleRegNo,
      required this.vehicleId,
      required this.addressId,
      required this.addrressType,
      required this.flatHouseNo,
      required this.area,
      required this.nearBy,
      required this.subscriptionId,
      required this.subscriptionPrize});

  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final _razorpay = Razorpay();

  // Replace your apiKey & apiSecret;

  // Map<String, dynamic> paymentData = {
  //   'amount': 50000, // amount in paise (e.g., 1000 paise = Rs. 10)
  //   'currency': 'INR',
  //   'receipt': 'order_receipt',
  //   'payment_capture': '1',
  // };
  @override
  void initState() {
    super.initState();

    // initiatePayment();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      // provider.setsubsAddClickedEnableButton();
    });
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  Future<bool> willPopCallback() async {
    Provider.of<YopeeProvider>(context, listen: false).subsVehicleSelection ==
            true
        ? Navigator.pop(context)
        : Navigator.of(context).pushNamedAndRemoveUntil(
            '/dashboard', (Route<dynamic> route) => false);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    provider.isSpecialRequest ? print("true") : print("false");
    print("service id:${widget.subscriptionId}");
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
                    "Payment",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 1,
                          margin: EdgeInsets.only(right: 20, top: 10, left: 20),
                          child: Container(
                            constraints:
                                BoxConstraints(maxHeight: double.infinity),
                            width: 374,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffF6F6FE),
                              // border:
                              //     Border.all(color: Color(0xff007BFF), width: 1)
                            ),
                            child: Row(
                              children: [
                                widget.vehicleImagePath == ""
                                    ? Container(
                                        height: 48,
                                        width: 64,
                                        margin: EdgeInsets.only(
                                            left: 10, top: 11, bottom: 11),
                                        child: Image.asset(
                                            "assets/images/carBrand/Suzuki.png"),
                                      )
                                    : Container(
                                        height: 48,
                                        width: 64,
                                        margin: EdgeInsets.only(
                                            left: 10, top: 11, bottom: 11),
                                        child: Image.network(
                                          widget.vehicleImagePath,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            Navigator.pushReplacementNamed(
                                                context, '/dashboard');
                                            return Container();
                                          },
                                        ),
                                      ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 19,
                                      margin: EdgeInsets.only(
                                          left: 31, top: 13, bottom: 10),
                                      child: Text(
                                        "${widget.vehicleBrandName} ${widget.vehicleModelName}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "SemiBold"),
                                      ),
                                    ),
                                    Container(
                                      height: 19,
                                      margin: EdgeInsets.only(left: 31),
                                      child: Text(
                                        "${widget.vehicleRegNo} | ${widget.vehicleTypeName}",
                                        style: TextStyle(
                                            fontSize: 12, fontFamily: "Medium"),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    provider.setSubsEdit(true);
                                    provider.subsVehicleSelection == true
                                        ? Navigator.of(context).push(
                                            PageRouteBuilder(
                                                transitionDuration: const Duration(
                                                    milliseconds: 400),
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    VehicleList(
                                                      id: widget.subscriptionId,
                                                      price: widget
                                                          .subscriptionPrize,
                                                      vehicleImagePath: widget
                                                          .vehicleImagePath,
                                                      vehicleBrandName: widget
                                                          .vehicleBrandName,
                                                      vehicleModelName: widget
                                                          .vehicleModelName,
                                                      vehicleTypeName: widget
                                                          .vehicleTypeName,
                                                      vehicleRegNo:
                                                          widget.vehicleRegNo,
                                                      vehicleId:
                                                          widget.vehicleId,
                                                      serviceId: '',
                                                      serviceName: '',
                                                      image: '',
                                                      longDesc: [],
                                                      timeDuration: '',
                                                    ),
                                                transitionsBuilder: (BuildContext context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secondaryAnimation,
                                                    Widget child) {
                                                  return new SlideTransition(
                                                    position: new Tween<Offset>(
                                                      //Left to right
                                                      begin: const Offset(
                                                          -1.0, 0.0),
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
                                        //             builder: (context) =>
                                        //                 VehicleList(
                                        //                   id: widget.subscriptionId,
                                        //                   price: widget
                                        //                       .subscriptionPrize,
                                        //                   vehicleImagePath: widget
                                        //                       .vehicleImagePath,
                                        //                   vehicleBrandName: widget
                                        //                       .vehicleBrandName,
                                        //                   vehicleModelName: widget
                                        //                       .vehicleModelName,
                                        //                   vehicleTypeName: widget
                                        //                       .vehicleTypeName,
                                        //                   vehicleRegNo:
                                        //                       widget.vehicleRegNo,
                                        //                   vehicleId:
                                        //                       widget.vehicleId,
                                        //                 )),
                                        //       )
                                        : provider.isSpecialRequest == true
                                            ? Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    transitionDuration:
                                                        const Duration(
                                                            milliseconds: 400),
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        VehicleList(
                                                          id: widget
                                                              .subscriptionId,
                                                          price: widget
                                                              .subscriptionPrize,
                                                          vehicleImagePath: widget
                                                              .vehicleImagePath,
                                                          vehicleBrandName: widget
                                                              .vehicleBrandName,
                                                          vehicleModelName: widget
                                                              .vehicleModelName,
                                                          vehicleTypeName: widget
                                                              .vehicleTypeName,
                                                          vehicleRegNo: widget
                                                              .vehicleRegNo,
                                                          vehicleId:
                                                              widget.vehicleId,
                                                          serviceId: '',
                                                          serviceName: '',
                                                          image: '',
                                                          longDesc: [],
                                                          timeDuration: '',
                                                        ),
                                                    transitionsBuilder:
                                                        (BuildContext context,
                                                            Animation<double>
                                                                animation,
                                                            Animation<double> secondaryAnimation,
                                                            Widget child) {
                                                      return new SlideTransition(
                                                        position:
                                                            new Tween<Offset>(
                                                          //Left to right
                                                          begin: const Offset(
                                                              -1.0, 0.0),
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
                                            : provider.isService == true
                                                ? Navigator.of(context).push(PageRouteBuilder(
                                                    transitionDuration: const Duration(milliseconds: 400),
                                                    pageBuilder: (context, animation, secondaryAnimation) => VehicleList(
                                                          id: widget
                                                              .subscriptionId,
                                                          price: widget
                                                              .subscriptionPrize,
                                                          vehicleImagePath: widget
                                                              .vehicleImagePath,
                                                          vehicleBrandName: widget
                                                              .vehicleBrandName,
                                                          vehicleModelName: widget
                                                              .vehicleModelName,
                                                          vehicleTypeName: widget
                                                              .vehicleTypeName,
                                                          vehicleRegNo: widget
                                                              .vehicleRegNo,
                                                          vehicleId:
                                                              widget.vehicleId,
                                                          serviceId: '',
                                                          serviceName: '',
                                                          image: '',
                                                          longDesc: [],
                                                          timeDuration: '',
                                                        ),
                                                    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                      return new SlideTransition(
                                                        position:
                                                            new Tween<Offset>(
                                                          //Left to right
                                                          begin: const Offset(
                                                              -1.0, 0.0),
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
                                                : Container();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 12,
                                          bottom: 20,
                                          top: 20,
                                          right: 10),
                                      child: (Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontFamily: "SemiBold",
                                            fontSize: 14,
                                            color: Color(0xff007BFF)),
                                      ))),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 1,
                          margin: EdgeInsets.only(right: 20, top: 10, left: 20),
                          child: Container(
                            constraints:
                                BoxConstraints(maxHeight: double.infinity),
                            width: 374,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffF6F6FE),
                              // border:
                              //     Border.all(color: Color(0xff007BFF), width: 1)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 17.06,
                                          margin: EdgeInsets.only(
                                            left: 8,
                                            bottom: 5,
                                            top: 13,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/images/map-marker.svg",
                                          ),
                                        ),
                                        Container(
                                          //height: 19,
                                          margin: EdgeInsets.only(
                                              left: 15, top: 13, bottom: 5),
                                          child: Text(
                                            "${widget.addrressType}",
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                fontFamily: "SemiBold"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        width: 240,
                                        margin: EdgeInsets.only(left: 40),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          readOnly: true,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 10,
                                          initialValue:
                                              "${widget.flatHouseNo}, ${widget.area}, ${widget.nearBy}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Medium",
                                              color: Color(0xff6F6F6F)),
                                        )),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    provider.subsAddressSelection == true
                                        ? Navigator.of(context).push(
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    SavedAddress(
                                                      vehicleImagePath: widget
                                                          .vehicleImagePath,
                                                      vehicleBrandName: widget
                                                          .vehicleBrandName,
                                                      vehicleModelName: widget
                                                          .vehicleModelName,
                                                      vehicleTypeName: widget
                                                          .vehicleTypeName,
                                                      vehicleRegNo:
                                                          widget.vehicleRegNo,
                                                      vehicleId:
                                                          widget.vehicleId,
                                                      subscriptionId:
                                                          widget.subscriptionId,
                                                      subscriptionPrize: widget
                                                          .subscriptionPrize,
                                                    ),
                                                transitionsBuilder: (BuildContext context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secondaryAnimation,
                                                    Widget child) {
                                                  return new SlideTransition(
                                                    position: new Tween<Offset>(
                                                      //Left to right
                                                      begin: const Offset(
                                                          -1.0, 0.0),
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
                                        //           builder: (context) =>
                                        //               SavedAddress(
                                        //             vehicleImagePath:
                                        //                 widget.vehicleImagePath,
                                        //             vehicleBrandName:
                                        //                 widget.vehicleBrandName,
                                        //             vehicleModelName:
                                        //                 widget.vehicleModelName,
                                        //             vehicleTypeName:
                                        //                 widget.vehicleTypeName,
                                        //             vehicleRegNo:
                                        //                 widget.vehicleRegNo,
                                        //             vehicleId: widget.vehicleId,
                                        //             subscriptionId:
                                        //                 widget.subscriptionId,
                                        //             subscriptionPrize:
                                        //                 widget.subscriptionPrize,
                                        //           ),
                                        //         ),
                                        //       )
                                        : provider.isSpecialRequest == true
                                            ? Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    transitionDuration:
                                                        const Duration(
                                                            milliseconds: 400),
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        ServiceAddress(
                                                          vehicleImagePath: widget
                                                              .vehicleImagePath,
                                                          vehicleBrandName: widget
                                                              .vehicleBrandName,
                                                          vehicleModelName: widget
                                                              .vehicleModelName,
                                                          vehicleTypeName: widget
                                                              .vehicleTypeName,
                                                          vehicleRegNo: widget
                                                              .vehicleRegNo,
                                                          vehicleId:
                                                              widget.vehicleId,
                                                          serviceId: widget
                                                              .subscriptionId,
                                                          price: widget
                                                              .subscriptionPrize,
                                                        ),
                                                    transitionsBuilder:
                                                        (BuildContext context,
                                                            Animation<double> animation,
                                                            Animation<double> secondaryAnimation,
                                                            Widget child) {
                                                      return new SlideTransition(
                                                        position:
                                                            new Tween<Offset>(
                                                          //Left to right
                                                          begin: const Offset(
                                                              -1.0, 0.0),
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
                                            //           builder: (context) =>
                                            //               SavedAddress(
                                            //             vehicleImagePath:
                                            //                 widget.vehicleImagePath,
                                            //             vehicleBrandName:
                                            //                 widget.vehicleBrandName,
                                            //             vehicleModelName:
                                            //                 widget.vehicleModelName,
                                            //             vehicleTypeName:
                                            //                 widget.vehicleTypeName,
                                            //             vehicleRegNo:
                                            //                 widget.vehicleRegNo,
                                            //             vehicleId: widget.vehicleId,
                                            //             subscriptionId:
                                            //                 widget.subscriptionId,
                                            //             subscriptionPrize:
                                            //                 widget.subscriptionPrize,
                                            //           ),
                                            //         ),
                                            //       )
                                            : provider.isService == true
                                                ? Navigator.of(context).push(PageRouteBuilder(
                                                    transitionDuration: const Duration(milliseconds: 400),
                                                    pageBuilder: (context, animation, secondaryAnimation) => ServiceAddress(
                                                          vehicleImagePath: widget
                                                              .vehicleImagePath,
                                                          vehicleBrandName: widget
                                                              .vehicleBrandName,
                                                          vehicleModelName: widget
                                                              .vehicleModelName,
                                                          vehicleTypeName: widget
                                                              .vehicleTypeName,
                                                          vehicleRegNo: widget
                                                              .vehicleRegNo,
                                                          vehicleId:
                                                              widget.vehicleId,
                                                          serviceId: widget
                                                              .subscriptionId,
                                                          price: widget
                                                              .subscriptionPrize,
                                                        ),
                                                    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                                      return new SlideTransition(
                                                        position:
                                                            new Tween<Offset>(
                                                          //Left to right
                                                          begin: const Offset(
                                                              -1.0, 0.0),
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
                                                //           builder: (context) =>
                                                //               SavedAddress(
                                                //             vehicleImagePath:
                                                //                 widget.vehicleImagePath,
                                                //             vehicleBrandName:
                                                //                 widget.vehicleBrandName,
                                                //             vehicleModelName:
                                                //                 widget.vehicleModelName,
                                                //             vehicleTypeName:
                                                //                 widget.vehicleTypeName,
                                                //             vehicleRegNo:
                                                //                 widget.vehicleRegNo,
                                                //             vehicleId: widget.vehicleId,
                                                //             subscriptionId:
                                                //                 widget.subscriptionId,
                                                //             subscriptionPrize:
                                                //                 widget.subscriptionPrize,
                                                //           ),
                                                //         ),
                                                //       )
                                                : Container();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: 20, top: 20, right: 10),
                                      child: (Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontFamily: "SemiBold",
                                            fontSize: 14,
                                            color: Color(0xff007BFF)),
                                      ))),
                                ),
                              ],
                            ),
                          ),
                        ),
                        provider.isSpecialRequest == true
                            ? Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                child: Text(
                                  "Message",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "SemiBold",
                                      color: Color(0xff001F3F)),
                                ),
                              )
                            : Container(),
                        provider.isSpecialRequest == true
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 25, top: 20),
                                constraints: BoxConstraints(
                                    maxHeight: double.infinity, maxWidth: 374),
                                padding: EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color(0xff707070), width: 1)),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 10,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  controller: provider.messageSpecialController,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Medium",
                                      color: Color(0xff111111)),
                                ),
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            "Order Payment",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "SemiBold",
                                color: Color(0xff001F3F)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  "Basic",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Medium",
                                      color: Color(0xff545454)),
                                ),
                              ),
                              Spacer(),
                              Container(
                                  child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "₹",
                                        style: TextStyle(
                                            fontFamily: "SemiBold",
                                            fontSize: 18,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: "${widget.subscriptionPrize}",
                                        style: TextStyle(
                                            fontFamily: "SemiBold",
                                            fontSize: 18,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '/- month',
                                        style: TextStyle(
                                            fontFamily: "Medium",
                                            fontSize: 14,
                                            color: Colors.black)),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, top: 20),
                        //   child: Text(
                        //     "Payment Options",
                        //     style: TextStyle(
                        //         fontSize: 18,
                        //         fontFamily: "SemiBold",
                        //         color: Color(0xff001F3F)),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, top: 20),
                        //   height: 24,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         height: 21,
                        //         width: 29,
                        //         child:
                        //             Image.asset("assets/images/card-icon.png"),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(left: 33),
                        //         child: Text(
                        //           "Credit / Debit Card",
                        //           style: TextStyle(
                        //               fontSize: 16,
                        //               fontFamily: "Medium",
                        //               color: Color(0xff444444)),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Radio<int>(
                        //         value: 0,
                        //         activeColor: Color(0xff007BFF),
                        //         groupValue: provider.selectedPaymentCredit,
                        //         onChanged: (int? value) {
                        //           setState(() {
                        //             provider.selectedPaymentCredit = value!;
                        //             provider.selectedPaymentPhonepe = -1;
                        //             provider.selectedPaymentPaytm = -1;
                        //             provider.selectedPaymentGpay = -1;
                        //             provider.selectedPaymentUpi = -1;
                        //
                        //             print(
                        //                 "Selected Payment Credit: ${provider.selectedPaymentCredit}");
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, top: 20),
                        //   height: 24,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         height: 30,
                        //         width: 30,
                        //         child: Image.asset("assets/images/phonepe.png"),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(left: 33),
                        //         child: Text(
                        //           "PhonePe",
                        //           style: TextStyle(
                        //               fontSize: 16,
                        //               fontFamily: "Medium",
                        //               color: Color(0xff444444)),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Radio<int>(
                        //         value: 0,
                        //         activeColor: Color(0xff007BFF),
                        //         groupValue: provider.selectedPaymentPhonepe,
                        //         onChanged: (int? value) {
                        //           setState(() {
                        //             provider.selectedPaymentPhonepe = value!;
                        //             print(
                        //                 "Selected Payment Option Phonepe: ${provider.selectedPaymentPhonepe}");
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, top: 20),
                        //   height: 24,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         height: 15,
                        //         width: 48,
                        //         child:
                        //             Image.asset("assets/images/paytm-icon.png"),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(left: 13),
                        //         child: Text(
                        //           "Paytm",
                        //           style: TextStyle(
                        //               fontSize: 16,
                        //               fontFamily: "Medium",
                        //               color: Color(0xff444444)),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Radio<int>(
                        //         value: 0,
                        //         activeColor: Color(0xff007BFF),
                        //         groupValue: provider.selectedPaymentPaytm,
                        //         onChanged: (int? value) {
                        //           setState(() {
                        //             provider.selectedPaymentPaytm = value!;
                        //             print(
                        //                 "Selected Payment Option Paytm: ${provider.selectedPaymentPaytm}");
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, top: 20),
                        //   height: 24,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         height: 30,
                        //         width: 30,
                        //         child: Image.asset("assets/images/gpay.png"),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(left: 31),
                        //         child: Text(
                        //           "Gpay",
                        //           style: TextStyle(
                        //               fontSize: 16,
                        //               fontFamily: "Medium",
                        //               color: Color(0xff444444)),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Radio<int>(
                        //         value: 0,
                        //         activeColor: Color(0xff007BFF),
                        //         groupValue: provider.selectedPaymentGpay,
                        //         onChanged: (int? value) {
                        //           setState(() {
                        //             provider.selectedPaymentGpay = value!;
                        //             print(
                        //                 "Selected Payment Option Gpay: ${provider.selectedPaymentGpay}");
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, top: 20),
                        //   height: 24,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         height: 13,
                        //         width: 47,
                        //         child: Image.asset("assets/images/UPI.png"),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(left: 14),
                        //         child: Text(
                        //           "UPI",
                        //           style: TextStyle(
                        //               fontSize: 16,
                        //               fontFamily: "Medium",
                        //               color: Color(0xff444444)),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Radio<int>(
                        //         value: 0,
                        //         activeColor: Color(0xff007BFF),
                        //         groupValue: provider.selectedPaymentUpi,
                        //         onChanged: (int? value) {
                        //           setState(() {
                        //             provider.selectedPaymentUpi = value!;
                        //             print(
                        //                 "Selected Payment Option Upi: ${provider.selectedPaymentUpi}");
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 17),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.subsAddClicked
                        ? ColorTheme.themeLightGrayColor
                        : ColorTheme.themeGreenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    minimumSize: Size(374, 56),
                  ),
                  onPressed:
                      // provider.subsAddClicked
                      //     ?
                      () {
                    //

                    if (provider.isSpecialRequest == true) {
                      // provider.setsubsAddClickedDisableButton();

                      if (!provider.specialRequestClicked) {
                        provider.specialRequestClicked = true;
                        widget.subscriptionPrize == 0 ||
                                widget.subscriptionPrize == null
                            ? Fluttertoast.showToast(
                                msg:
                                    "Unable to proceed.Please enter a valid service price",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                            : createOrder(widget.subscriptionPrize);
                      }
                    } else if (provider.isService == true) {
                      if (!provider.serviceCLicked) {
                        provider.serviceCLicked = true;
                        widget.subscriptionPrize == 0 ||
                                widget.subscriptionPrize == null
                            ? Fluttertoast.showToast(
                                msg:
                                    "Unable to proceed.Please enter a valid subscription price",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                            : createOrder(widget.subscriptionPrize);
                        // provider.getUserServiceAddApi(
                        //     widget.vehicleId,
                        //     widget.addressId,
                        //     widget.subscriptionId,
                        //     widget.subscriptionPrize,
                        //     context);
                      }
                    } else {
                      //  provider.setsubsAddClickedDisableButton();

                      if (!provider.subsAddClicked) {
                        provider.subsAddClicked = true;
                        widget.subscriptionPrize == 0 ||
                                widget.subscriptionPrize == null
                            ? Fluttertoast.showToast(
                                msg:
                                    "Unable to proceed.Please enter a valid service price",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                            : createOrder(widget.subscriptionPrize);
                      }
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PayNowScreen(
                    //         vehicleId: widget.vehicleId,
                    //         addressId: provider.objAddressListResponse
                    //             .data[provider.selectedMyAddressIndex].id
                    //             .toString(),
                    //         subscriptionId: widget.subscriptionId,
                    //         subscriptionPrize: widget.subscriptionPrize),
                    //   ),
                    // );
                  },
                  // : null,
                  child: provider.isSpecialRequest
                      ? Text(
                          'Proceed to Payment',
                          style: TextStyle(
                              color: ColorTheme.themeBlackColor,
                              fontSize: 16,
                              fontFamily: "SemiBold"),
                        )
                      : provider.isService
                          ? Text(
                              'Proceed to Payment',
                              style: TextStyle(
                                  color: ColorTheme.themeBlackColor,
                                  fontSize: 16,
                                  fontFamily: "SemiBold"),
                            )
                          : Text(
                              'Subscribe',
                              style: TextStyle(
                                  color: ColorTheme.themeBlackColor,
                                  fontSize: 16,
                                  fontFamily: "SemiBold"),
                            )),
            )),
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

    Provider.of<YopeeProvider>(context, listen: false).isService == true
        ? Provider.of<YopeeProvider>(context, listen: false)
            .getUserServiceAddApi(
                widget.vehicleId,
                widget.addressId,
                widget.subscriptionId,
                widget.subscriptionPrize.toString(),
                context)
        : Provider.of<YopeeProvider>(context, listen: false).isSpecialRequest
            ? Provider.of<YopeeProvider>(context, listen: false)
                .getSpecialRequestAddApi(
                    widget.vehicleId,
                    widget.addressId,
                    Provider.of<YopeeProvider>(context, listen: false)
                        .messageSpecialController
                        .text,
                    Provider.of<YopeeProvider>(context, listen: false)
                        .formatted,
                    widget.subscriptionPrize.toString(),
                    widget.subscriptionId,
                    context)
            : Provider.of<YopeeProvider>(context, listen: false)
                .getSubscriptionAddApi(
                    widget.vehicleId,
                    widget.addressId,
                    widget.subscriptionId,
                    widget.subscriptionPrize.toString(),
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

  // Future<void> initiatePayment() async {
  //   String apiUrl = 'https://api.razorpay.com/v1/orders';
  //   // Make the API request to create an order
  //   http.Response response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'Basic ${base64Encode(utf8.encode('$razorPayApiKey:$razorPayApiSecret'))}',
  //     },
  //     body: jsonEncode(paymentData),
  //   );
  //   print("payment successfull:${response.body}");
  //   if (response.statusCode == 200) {
  //     // Parse the response to get the order ID
  //     var responseData = jsonDecode(response.body);
  //     String orderId = responseData['id'];
  //
  //     // Set up the payment options
  //     var options = {
  //       'key': razorPayApiKey,
  //       'amount': paymentData['amount'],
  //       'name': 'Yopee',
  //       'order_id': orderId,
  //       'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
  //       'external': {
  //         'wallets': ['paytm'] // optional, for adding support for wallets
  //       }
  //     };
  //
  //     // Open the Razorpay payment form
  //     _razorpay.open(options);
  //   } else {
  //     // Handle error response
  //     debugPrint('Error creating order: ${response.body}');
  //   }
  // }

  // create order
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
