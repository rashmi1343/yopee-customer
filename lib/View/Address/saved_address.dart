import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/Utility/Environment.dart';
import 'package:yopee_customer/View/Address/AddAddress.dart';
import 'package:yopee_customer/View/Payment/PaymentScreen.dart';
import 'package:yopee_customer/View/VehicleList.dart';

import '../../Presenter/YopeeProvider.dart';
import '../Menu/MoreMenu.dart';

class SavedAddress extends StatefulWidget {
  String vehicleImagePath;
  String vehicleBrandName;
  String vehicleModelName;
  String vehicleTypeName;
  String vehicleRegNo;
  String vehicleId;
  String subscriptionId;
  int subscriptionPrize;

  SavedAddress(
      {required this.vehicleImagePath,
      required this.vehicleBrandName,
      required this.vehicleModelName,
      required this.vehicleTypeName,
      required this.vehicleRegNo,
      required this.vehicleId,
      required this.subscriptionId,
      required this.subscriptionPrize});

  SavedAddressState createState() => SavedAddressState();
}

class SavedAddressState extends State<SavedAddress> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      provider.getAddressListApi(context);
      // provider.toggleAddressSelection(-1);
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
        : Provider.of<YopeeProvider>(context, listen: false)
                    .subsAddressSelection ==
                true
            ? Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    VehicleList(
                      id: widget.subscriptionId,
                      price: widget.subscriptionPrize,
                      vehicleImagePath: widget.vehicleImagePath,
                      vehicleBrandName: widget.vehicleBrandName,
                      vehicleModelName: widget.vehicleModelName,
                      vehicleTypeName: widget.vehicleTypeName,
                      vehicleRegNo: widget.vehicleRegNo,
                      vehicleId: widget.vehicleId,
                      serviceId: '',
                      serviceName: '',
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

    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: willPopCallback,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                iconSize: 25,
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Provider.of<YopeeProvider>(context, listen: false)
                              .reportNavFromMenu ==
                          true
                      ? Navigator.of(context).push(PageRouteBuilder(
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
                      : provider.subsAddressSelection == true
                          ? Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  VehicleList(
                                    id: widget.subscriptionId,
                                    price: widget.subscriptionPrize,
                                    vehicleImagePath: widget.vehicleImagePath,
                                    vehicleBrandName: widget.vehicleBrandName,
                                    vehicleModelName: widget.vehicleModelName,
                                    vehicleTypeName: widget.vehicleTypeName,
                                    vehicleRegNo: widget.vehicleRegNo,
                                    vehicleId: widget.vehicleId,
                                    serviceId: '',
                                    serviceName: '',
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
                          //                 builder: (context) => VehicleList(
                          //                       id: widget.subscriptionId,
                          //                       price: widget.subscriptionPrize,
                          //                       vehicleImagePath:
                          //                           widget.vehicleImagePath,
                          //                       vehicleBrandName:
                          //                           widget.vehicleBrandName,
                          //                       vehicleModelName:
                          //                           widget.vehicleModelName,
                          //                       vehicleTypeName: widget.vehicleTypeName,
                          //                       vehicleRegNo: widget.vehicleRegNo,
                          //                       vehicleId: widget.vehicleId,
                          //                     )),
                          //           )
                          : Navigator.of(context).pushNamedAndRemoveUntil(
                              '/dashboard', (Route<dynamic> route) => false);
                }),
            title: Text(
              "Saved Addresses",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "SemiBold",
                  color: ColorTheme.themeBlackColor),
            ),
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
                    children: [
                      provider.reportNavFromMenu == true
                          ? Container()
                          : provider.subsAddressSelection == true
                              ? Container(
                                  height: 60,
                                  width: 364,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: 22, right: 22, top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xffF6F6FE)),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.add,
                                      color: Color(0xff007BFF),
                                      size: 20,
                                    ),
                                    title: Text(
                                      "Add New Address",
                                      style: TextStyle(
                                          fontFamily: "SemiBold",
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xff007BFF),
                                      size: 20,
                                    ),
                                    onTap: () {
                                      provider.isAddressEdit = false;
                                      provider.subsAddressSelection = true;

                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 400),
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  AddAddress(
                                                    id: "",
                                                    indexId: Environment
                                                        .selectedIndex
                                                        .toString(),
                                                    type: "",
                                                    flatHouseNo: "",
                                                    areaSector: "",
                                                    nearBy: "",
                                                    vehicleImagePath:
                                                        widget.vehicleImagePath,
                                                    vehicleBrandName:
                                                        widget.vehicleBrandName,
                                                    vehicleModelName:
                                                        widget.vehicleModelName,
                                                    vehicleTypeName:
                                                        widget.vehicleTypeName,
                                                    vehicleRegNo:
                                                        widget.vehicleRegNo,
                                                    vehicleId: widget.vehicleId,
                                                    subscriptionId:
                                                        widget.subscriptionId,
                                                    subscriptionPrize: widget
                                                        .subscriptionPrize,
                                                  ),
                                              transitionsBuilder: (BuildContext
                                                      context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                  Widget child) {
                                                return new SlideTransition(
                                                  position: new Tween<Offset>(
                                                    //Left to right
                                                    // begin: const Offset(-1.0, 0.0),
                                                    // end: Offset.zero,

                                                    //Right to left
                                                    begin:
                                                        const Offset(1.0, 0.0),
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
                                      //     builder: (context) => AddAddress(
                                      //       id: "",
                                      //       indexId: Environment.selectedIndex
                                      //           .toString(),
                                      //       type: "",
                                      //       flatHouseNo: "",
                                      //       areaSector: "",
                                      //       nearBy: "",
                                      //       vehicleImagePath:
                                      //           widget.vehicleImagePath,
                                      //       vehicleBrandName:
                                      //           widget.vehicleBrandName,
                                      //       vehicleModelName:
                                      //           widget.vehicleModelName,
                                      //       vehicleTypeName:
                                      //           widget.vehicleTypeName,
                                      //       vehicleRegNo: widget.vehicleRegNo,
                                      //       vehicleId: widget.vehicleId,
                                      //       subscriptionId:
                                      //           widget.subscriptionId,
                                      //       subscriptionPrize:
                                      //           widget.subscriptionPrize,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                  ))
                              : provider.isSpecialRequest == true
                                  ? Container(
                                      height: 60,
                                      width: 364,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left: 22, right: 22, top: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xffF6F6FE)),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.add,
                                          color: Color(0xff007BFF),
                                          size: 20,
                                        ),
                                        title: Text(
                                          "Add New Address",
                                          style: TextStyle(
                                              fontFamily: "SemiBold",
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xff007BFF),
                                          size: 20,
                                        ),
                                        onTap: () {
                                          provider.isAddressEdit = false;
                                          provider.subsAddressSelection = true;

                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      AddAddress(
                                                        id: "",
                                                        indexId: Environment
                                                            .selectedIndex
                                                            .toString(),
                                                        type: "",
                                                        flatHouseNo: "",
                                                        areaSector: "",
                                                        nearBy: "",
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
                                                        subscriptionId: widget
                                                            .subscriptionId,
                                                        subscriptionPrize: widget
                                                            .subscriptionPrize,
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
                                          //     builder: (context) => AddAddress(
                                          //       id: "",
                                          //       indexId: Environment.selectedIndex
                                          //           .toString(),
                                          //       type: "",
                                          //       flatHouseNo: "",
                                          //       areaSector: "",
                                          //       nearBy: "",
                                          //       vehicleImagePath:
                                          //           widget.vehicleImagePath,
                                          //       vehicleBrandName:
                                          //           widget.vehicleBrandName,
                                          //       vehicleModelName:
                                          //           widget.vehicleModelName,
                                          //       vehicleTypeName:
                                          //           widget.vehicleTypeName,
                                          //       vehicleRegNo: widget.vehicleRegNo,
                                          //       vehicleId: widget.vehicleId,
                                          //       subscriptionId:
                                          //           widget.subscriptionId,
                                          //       subscriptionPrize:
                                          //           widget.subscriptionPrize,
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                      ))
                                  : Container(),
                      provider.objAddressListResponse.data.isEmpty
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 300),
                                child: Text(
                                  "No Address Found!!",
                                  style: TextStyle(
                                      fontFamily: "Medium",
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  provider.objAddressListResponse.data.length,
                              itemBuilder: (context, index) {
                                var addressListItem =
                                    provider.objAddressListResponse.data;

                                return Card(
                                  elevation: 1,
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 18, bottom: 15),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: double.infinity),
                                    width: 380,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffFAFAFA),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff0000000A),
                                          blurRadius: 20.0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        provider.reportNavFromMenu == true
                                            ? Container()
                                            : provider.subsAddressSelection ==
                                                    true
                                                ? Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: InkWell(
                                                      onTap: () {
                                                        provider
                                                            .toggleAddressSelection(
                                                                index);
                                                        print(
                                                            "selectedIndex:${provider.selectedMyAddressIndex}");

                                                        //    });
                                                      },
                                                      child: index ==
                                                              provider
                                                                  .selectedMyAddressIndex
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/images/check-solid.svg",
                                                                    color: Colors
                                                                        .white,
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

                                                // Align(
                                                //         alignment: Alignment.centerLeft,
                                                //         child: Container(
                                                //           margin:
                                                //               EdgeInsets.only(left: 3),
                                                //           alignment: Alignment.topLeft,
                                                //           height: 30,
                                                //           width: 30,
                                                //           padding: EdgeInsets.all(5),
                                                //           child: Checkbox(
                                                //             checkColor: Colors.white,
                                                //             activeColor:
                                                //                 Color(0xff007BFF),
                                                //             value:
                                                //                 addressListItem[index]
                                                //                     .isAddressSelected,
                                                //             shape: CircleBorder(),
                                                //             onChanged: (bool? value) {
                                                //               provider
                                                //                   .toggleAddressSelection(
                                                //                       index);
                                                //             },
                                                //           ),
                                                //         ),
                                                //       )
                                                : provider.reportNavFromMenu ==
                                                        true
                                                    ? Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: InkWell(
                                                          onTap: () {
                                                            provider
                                                                .toggleAddressSelection(
                                                                    index);
                                                            print(
                                                                "selectedIndex:${provider.selectedMyAddressIndex}");

                                                            //    });
                                                          },
                                                          child: index ==
                                                                  provider
                                                                      .selectedMyAddressIndex
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
                                                                        color: Colors
                                                                            .white,
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
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          10.0),
                                                                      child:
                                                                          Container()),
                                                                ),
                                                        ),
                                                      )

                                                    // Align(
                                                    //         alignment: Alignment.centerLeft,
                                                    //         child: Container(
                                                    //           margin:
                                                    //               EdgeInsets.only(left: 3),
                                                    //           alignment: Alignment.topLeft,
                                                    //           height: 30,
                                                    //           width: 30,
                                                    //           padding: EdgeInsets.all(5),
                                                    //           child: Checkbox(
                                                    //             checkColor: Colors.white,
                                                    //             activeColor:
                                                    //                 Color(0xff007BFF),
                                                    //             value:
                                                    //                 addressListItem[index]
                                                    //                     .isAddressSelected,
                                                    //             shape: CircleBorder(),
                                                    //             onChanged: (bool? value) {
                                                    //               provider
                                                    //                   .toggleAddressSelection(
                                                    //                       index);
                                                    //             },
                                                    //           ),
                                                    //         ),
                                                    //       )
                                                    : Container(),
                                        SizedBox(
                                          width: 11.04,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 19,
                                                        top: 22,
                                                        right: 12),
                                                    height: 20,
                                                    width: 17.06,
                                                    child: SvgPicture.asset(
                                                      "assets/images/map-marker.svg",
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 22, right: 12),
                                                    child: Text(
                                                      addressListItem![index]
                                                          .type
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.5,
                                                          fontFamily:
                                                              "SemiBold",
                                                          color: ColorTheme
                                                              .themeBlackColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              addressListItem[index].nearby ==
                                                          null ||
                                                      addressListItem[index]
                                                              .nearby ==
                                                          ""
                                                  ? Wrap(children: [
                                                      Container(
                                                          width: 245,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 50),
                                                          child: TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            readOnly: true,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            minLines: 1,
                                                            maxLines: 10,
                                                            initialValue:
                                                                "${addressListItem[index].flatHouseNo.toString()}, ${addressListItem[index].areaSector.toString()}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Medium",
                                                                color: Color(
                                                                    0xff6F6F6F)),
                                                          )

                                                          // Text(
                                                          //   "${addressListItem[index].flatHouseNo.toString()}, ${addressListItem[index].areaSector.toString()}",
                                                          //   softWrap: true,
                                                          //   maxLines: 10,
                                                          //   style: TextStyle(
                                                          //       fontSize: 12,
                                                          //       fontFamily:
                                                          //           "Medium",
                                                          //       color: Color(
                                                          //           0xff6F6F6F)),
                                                          // ),
                                                          ),
                                                    ])
                                                  : Wrap(children: [
                                                      Container(
                                                          width: 245,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 50),
                                                          child: TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            readOnly: true,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            minLines: 1,
                                                            maxLines: 10,
                                                            initialValue:
                                                                "${addressListItem[index].flatHouseNo.toString()}, ${addressListItem[index].areaSector.toString()}, ${addressListItem[index].nearby.toString()}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Medium",
                                                                color: Color(
                                                                    0xff6F6F6F)),
                                                          )

                                                          // Text(
                                                          //   "${addressListItem[index].flatHouseNo.toString()}, ${addressListItem[index].areaSector.toString()}, ${addressListItem[index].nearby.toString()}",
                                                          //   softWrap: true,
                                                          //   maxLines: 10,
                                                          //   style: TextStyle(
                                                          //       fontSize: 12,
                                                          //       fontFamily:
                                                          //           "Medium",
                                                          //       color: Color(
                                                          //           0xff6F6F6F)),
                                                          // ),
                                                          ),
                                                    ]),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 50),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        provider.isAddressEdit =
                                                            true;
                                                        Environment
                                                                .selectedIndex =
                                                            index;
                                                        print(
                                                            "selected address index:${Environment.selectedIndex}");

                                                        Navigator.of(context).push(
                                                            PageRouteBuilder(
                                                                transitionDuration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            400),
                                                                pageBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation) =>
                                                                    AddAddress(
                                                                      id: addressListItem[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      indexId: Environment
                                                                          .selectedIndex
                                                                          .toString(),
                                                                      type: addressListItem[
                                                                              index]
                                                                          .type
                                                                          .toString(),
                                                                      flatHouseNo: addressListItem[
                                                                              index]
                                                                          .flatHouseNo
                                                                          .toString(),
                                                                      areaSector: addressListItem[
                                                                              index]
                                                                          .areaSector
                                                                          .toString(),
                                                                      nearBy: addressListItem[
                                                                              index]
                                                                          .nearby
                                                                          .toString(),
                                                                      vehicleImagePath:
                                                                          widget
                                                                              .vehicleImagePath,
                                                                      vehicleBrandName:
                                                                          widget
                                                                              .vehicleBrandName,
                                                                      vehicleModelName:
                                                                          widget
                                                                              .vehicleModelName,
                                                                      vehicleTypeName:
                                                                          widget
                                                                              .vehicleTypeName,
                                                                      vehicleRegNo:
                                                                          widget
                                                                              .vehicleRegNo,
                                                                      vehicleId:
                                                                          widget
                                                                              .vehicleId,
                                                                      subscriptionId:
                                                                          widget
                                                                              .subscriptionId,
                                                                      subscriptionPrize:
                                                                          widget
                                                                              .subscriptionPrize,
                                                                    ),
                                                                transitionsBuilder: (BuildContext context,
                                                                    Animation<
                                                                            double>
                                                                        animation,
                                                                    Animation<
                                                                            double>
                                                                        secondaryAnimation,
                                                                    Widget
                                                                        child) {
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
                                                        //         AddAddress(
                                                        //       id: addressListItem[
                                                        //               index]
                                                        //           .id
                                                        //           .toString(),
                                                        //       indexId: Environment
                                                        //           .selectedIndex
                                                        //           .toString(),
                                                        //       type:
                                                        //           addressListItem[
                                                        //                   index]
                                                        //               .type
                                                        //               .toString(),
                                                        //       flatHouseNo:
                                                        //           addressListItem[
                                                        //                   index]
                                                        //               .flatHouseNo
                                                        //               .toString(),
                                                        //       areaSector:
                                                        //           addressListItem[
                                                        //                   index]
                                                        //               .areaSector
                                                        //               .toString(),
                                                        //       nearBy:
                                                        //           addressListItem[
                                                        //                   index]
                                                        //               .nearby
                                                        //               .toString(),
                                                        //       vehicleImagePath: widget
                                                        //           .vehicleImagePath,
                                                        //       vehicleBrandName: widget
                                                        //           .vehicleBrandName,
                                                        //       vehicleModelName: widget
                                                        //           .vehicleModelName,
                                                        //       vehicleTypeName: widget
                                                        //           .vehicleTypeName,
                                                        //       vehicleRegNo: widget
                                                        //           .vehicleRegNo,
                                                        //       vehicleId: widget
                                                        //           .vehicleId,
                                                        //       subscriptionId: widget
                                                        //           .subscriptionId,
                                                        //       subscriptionPrize:
                                                        //           widget
                                                        //               .subscriptionPrize,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            border: Border.all(
                                                                color: ColorTheme
                                                                    .themeLightGrayColor)),
                                                        child: Image.asset(
                                                            "assets/images/edit.png"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        provider
                                                            .getAddressDeleteApi(
                                                                addressListItem[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                context);
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            border: Border.all(
                                                                color: ColorTheme
                                                                    .themeLightGrayColor)),
                                                        child: Image.asset(
                                                            "assets/images/cancel.png"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          border: Border.all(
                                                              color: ColorTheme
                                                                  .themeLightGrayColor)),
                                                      child: Image.asset(
                                                          "assets/images/share.png"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    ],
                  ),
                ),
          bottomNavigationBar: provider.reportNavFromMenu == true
              ? Container(
                  margin:
                      const EdgeInsets.only(left: 21, right: 20, bottom: 35),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTheme.themeGreenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      minimumSize: Size(374, 56),
                    ),
                    onPressed: () {
                      provider.isAddressEdit = false;

                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                              AddAddress(
                                id: "",
                                indexId: Environment.selectedIndex.toString(),
                                type: "",
                                flatHouseNo: "",
                                areaSector: "",
                                nearBy: "",
                                vehicleImagePath: "",
                                vehicleBrandName: "",
                                vehicleModelName: "",
                                vehicleTypeName: "",
                                vehicleRegNo: "",
                                vehicleId: "",
                                subscriptionId: "",
                                subscriptionPrize: 0,
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

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AddAddress(
                      //       id: "",
                      //       indexId: Environment.selectedIndex.toString(),
                      //       type: "",
                      //       flatHouseNo: "",
                      //       areaSector: "",
                      //       nearBy: "",
                      //       vehicleImagePath: "",
                      //       vehicleBrandName: "",
                      //       vehicleModelName: "",
                      //       vehicleTypeName: "",
                      //       vehicleRegNo: "",
                      //       vehicleId: "",
                      //       subscriptionId: "",
                      //       subscriptionPrize: "",
                      //     ),
                      //   ),
                      // );
                      //  Navigator.of(context).pushNamed('/addAddress');
                    },
                    child: const Text(
                      'Add new address',
                      style: TextStyle(
                          color: ColorTheme.themeBlackColor,
                          fontSize: 16,
                          fontFamily: "SemiBold"),
                    ),
                  ),
                )
              : provider.subsAddressSelection == true
                  ? Container(
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
                          provider.isAddressEdit = false;
                          provider.subsVehicleSelection = true;
                          provider.subsAddressSelection = true;

                          provider.selectedMyAddressIndex == -1
                              ? Fluttertoast.showToast(
                                  msg: "Please select a address",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0)
                              : Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
                                      vehicleImagePath: widget.vehicleImagePath,
                                      vehicleBrandName: widget.vehicleBrandName,
                                      vehicleModelName: widget.vehicleModelName,
                                      vehicleTypeName: widget.vehicleTypeName,
                                      vehicleRegNo: widget.vehicleRegNo,
                                      vehicleId: widget.vehicleId,
                                      addressId: provider
                                          .objAddressListResponse
                                          .data[provider.selectedMyAddressIndex]
                                          .id
                                          .toString(),
                                      addrressType: provider
                                          .objAddressListResponse
                                          .data[provider.selectedMyAddressIndex]
                                          .type
                                          .toString(),
                                      flatHouseNo: provider
                                          .objAddressListResponse
                                          .data[provider.selectedMyAddressIndex]
                                          .flatHouseNo
                                          .toString(),
                                      area: provider
                                          .objAddressListResponse
                                          .data[provider.selectedMyAddressIndex]
                                          .areaSector
                                          .toString(),
                                      nearBy: provider
                                          .objAddressListResponse
                                          .data[provider.selectedMyAddressIndex]
                                          .nearby
                                          .toString(),
                                      subscriptionId: widget.subscriptionId,
                                      subscriptionPrize:
                                          widget.subscriptionPrize),
                                  transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
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
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => PaymentScreen(
                          //               vehicleImagePath:
                          //                   widget.vehicleImagePath,
                          //               vehicleBrandName:
                          //                   widget.vehicleBrandName,
                          //               vehicleModelName:
                          //                   widget.vehicleModelName,
                          //               vehicleTypeName: widget.vehicleTypeName,
                          //               vehicleRegNo: widget.vehicleRegNo,
                          //               vehicleId: widget.vehicleId,
                          //               addressId: provider
                          //                   .objAddressListResponse
                          //                   .data[
                          //                       provider.selectedMyAddressIndex]
                          //                   .id
                          //                   .toString(),
                          //               addrressType: provider
                          //                   .objAddressListResponse
                          //                   .data[
                          //                       provider.selectedMyAddressIndex]
                          //                   .type
                          //                   .toString(),
                          //               flatHouseNo: provider
                          //                   .objAddressListResponse
                          //                   .data[provider.selectedMyAddressIndex]
                          //                   .flatHouseNo
                          //                   .toString(),
                          //               area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                          //               nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                          //               subscriptionId: widget.subscriptionId,
                          //               subscriptionPrize: widget.subscriptionPrize),
                          //         ),
                          //       );
                          //  Navigator.of(context).pushNamed('/addAddress');
                        },
                        child: const Text(
                          'Select address',
                          style: TextStyle(
                              color: ColorTheme.themeBlackColor,
                              fontSize: 16,
                              fontFamily: "SemiBold"),
                        ),
                      ),
                    )
                  : provider.isSpecialRequest == true
                      ? Container(
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
                              provider.isAddressEdit = false;
                              provider.subsVehicleSelection = true;
                              provider.subsAddressSelection = true;

                              provider.selectedMyAddressIndex == -1
                                  ? Fluttertoast.showToast(
                                      msg: "Please select a address",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                  : Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
                                          vehicleImagePath:
                                              widget.vehicleImagePath,
                                          vehicleBrandName:
                                              widget.vehicleBrandName,
                                          vehicleModelName:
                                              widget.vehicleModelName,
                                          vehicleTypeName:
                                              widget.vehicleTypeName,
                                          vehicleRegNo: widget.vehicleRegNo,
                                          vehicleId: widget.vehicleId,
                                          addressId:
                                              provider.objAddressListResponse.data[provider.selectedMyAddressIndex].id
                                                  .toString(),
                                          addrressType: provider
                                              .objAddressListResponse
                                              .data[provider
                                                  .selectedMyAddressIndex]
                                              .type
                                              .toString(),
                                          flatHouseNo: provider
                                              .objAddressListResponse
                                              .data[provider.selectedMyAddressIndex]
                                              .flatHouseNo
                                              .toString(),
                                          area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                                          nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                          subscriptionId: widget.subscriptionId,
                                          subscriptionPrize: widget.subscriptionPrize),
                                      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
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
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => PaymentScreen(
                              //               vehicleImagePath:
                              //                   widget.vehicleImagePath,
                              //               vehicleBrandName:
                              //                   widget.vehicleBrandName,
                              //               vehicleModelName:
                              //                   widget.vehicleModelName,
                              //               vehicleTypeName:
                              //                   widget.vehicleTypeName,
                              //               vehicleRegNo: widget.vehicleRegNo,
                              //               vehicleId: widget.vehicleId,
                              //               addressId:
                              //                   provider.objAddressListResponse.data[provider.selectedMyAddressIndex].id
                              //                       .toString(),
                              //               addrressType:
                              //                   provider.objAddressListResponse.data[provider.selectedMyAddressIndex].type
                              //                       .toString(),
                              //               flatHouseNo: provider
                              //                   .objAddressListResponse
                              //                   .data[provider
                              //                       .selectedMyAddressIndex]
                              //                   .flatHouseNo
                              //                   .toString(),
                              //               area: provider
                              //                   .objAddressListResponse
                              //                   .data[provider.selectedMyAddressIndex]
                              //                   .areaSector
                              //                   .toString(),
                              //               nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                              //               subscriptionId: widget.subscriptionId,
                              //               subscriptionPrize: widget.subscriptionPrize),
                              //         ),
                              //       );
                              //  Navigator.of(context).pushNamed('/addAddress');
                            },
                            child: const Text(
                              'Select address',
                              style: TextStyle(
                                  color: ColorTheme.themeBlackColor,
                                  fontSize: 16,
                                  fontFamily: "SemiBold"),
                            ),
                          ),
                        )
                      : Container(
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
                              provider.isAddressEdit = false;

                              Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      AddAddress(
                                        id: "",
                                        indexId: Environment.selectedIndex
                                            .toString(),
                                        type: "",
                                        flatHouseNo: "",
                                        areaSector: "",
                                        nearBy: "",
                                        vehicleImagePath:
                                            widget.vehicleImagePath,
                                        vehicleBrandName:
                                            widget.vehicleBrandName,
                                        vehicleModelName:
                                            widget.vehicleModelName,
                                        vehicleTypeName: widget.vehicleTypeName,
                                        vehicleRegNo: widget.vehicleRegNo,
                                        vehicleId: widget.vehicleId,
                                        subscriptionId: widget.subscriptionId,
                                        subscriptionPrize:
                                            widget.subscriptionPrize,
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

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => AddAddress(
                              //       id: "",
                              //       indexId:
                              //           Environment.selectedIndex.toString(),
                              //       type: "",
                              //       flatHouseNo: "",
                              //       areaSector: "",
                              //       nearBy: "",
                              //       vehicleImagePath: widget.vehicleImagePath,
                              //       vehicleBrandName: widget.vehicleBrandName,
                              //       vehicleModelName: widget.vehicleModelName,
                              //       vehicleTypeName: widget.vehicleTypeName,
                              //       vehicleRegNo: widget.vehicleRegNo,
                              //       vehicleId: widget.vehicleId,
                              //       subscriptionId: widget.subscriptionId,
                              //       subscriptionPrize: widget.subscriptionPrize,
                              //     ),
                              //   ),
                              // );
                              //  Navigator.of(context).pushNamed('/addAddress');
                            },
                            child: const Text(
                              'Add new address',
                              style: TextStyle(
                                  color: ColorTheme.themeBlackColor,
                                  fontSize: 16,
                                  fontFamily: "SemiBold"),
                            ),
                          ),
                        ),
        ),
      );
    });
  }
}
