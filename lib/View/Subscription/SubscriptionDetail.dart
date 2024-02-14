import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/View/VehicleList.dart';

import '../../Entity/Response/Subscription/BasicSubscriptionResponse.dart';
import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import 'Subscription.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  String id;
  String name;
  int price;
  String image;
  String timeDuration;
  List<SubscriptionDetails> longDesc;

  // String imagePath;

  SubscriptionDetailScreen({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.longDesc,
    required this.timeDuration,
  });

  SubscriptionDetailScreenState createState() =>
      SubscriptionDetailScreenState();
}

class SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      // provider.getSubsDetailsApi(widget.id, context);
      // provider.subscriptionSpecialvalue = true;
    });
  }

  Future<bool> willPopCallback() async {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => Subscription(),
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
                                        Subscription(),
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
                                // Navigator.of(context)
                                //     .pushNamed('/subscription');
                              },
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Container(
                              // margin: const EdgeInsets.only(
                              //   left: 69,
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
                        SizedBox(
                          height: 29,
                        ),
                        Container(
                          // height: 528,
                          constraints: BoxConstraints(
                              maxHeight: 528, maxWidth: double.infinity),
                          // width: 374,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, //change here don't //worked
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxHeight: double.infinity,
                                        maxWidth: double.infinity),
                                    margin: EdgeInsets.only(left: 15, top: 21),
                                    child: Image.network(
                                      widget.image,
                                      height: 68,
                                      width: 68,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxHeight: double.infinity,
                                            maxWidth: double.infinity),
                                        margin:
                                            EdgeInsets.only(left: 10, top: 30),
                                        child: Text(
                                          widget.name,
                                          style: TextStyle(
                                              fontFamily: "SemiBold",
                                              fontSize: 14.5,
                                              color: Color(0xff575757)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              constraints: BoxConstraints(
                                                  maxHeight: double.infinity,
                                                  maxWidth: double.infinity),
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 15),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "₹${widget.price}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: "SemiBold",
                                                      color: Color(0xff2D2D2D)),
                                                  children: [
                                                    TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "SemiBold",
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                              )

                                              // Text(
                                              //   "₹${provider.objSubsDetailsResponse.data.price}",
                                              //   style: TextStyle(
                                              //       fontFamily: "SemiBold",
                                              //       fontSize: 30,
                                              //       color: Color(0xff2D2D2D)),
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
                                            constraints: BoxConstraints(
                                                maxHeight: double.infinity,
                                                maxWidth: double.infinity),
                                            margin: EdgeInsets.only(
                                                left: 11, top: 15),
                                            child: const Text(
                                              "Per\nMonth",
                                              style: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 12.5,
                                                  color: Color(0xff2D2D2D)),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 9, top: 15),
                                            height: 35,
                                            width: 2,
                                            color: Color(0xff575757),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                                maxHeight: double.infinity,
                                                maxWidth: double.infinity),
                                            margin: EdgeInsets.only(
                                                left: 11, top: 15, right: 10),
                                            child: Text(
                                              "${widget.timeDuration}",
                                              style: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 12.5,
                                                  color: Color(0xff2D2D2D)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 20, bottom: 40),
                                    child: InkWell(
                                      onTap: () {
                                        provider.setsubscriptionSpecialvalue();
                                        // setState(() {
                                        //   provider.subscriptionSpecialvalue =
                                        //       !provider
                                        //           .subscriptionSpecialvalue;
                                        // });
                                      },
                                      child: provider.subscriptionSpecialvalue
                                          ? Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff007BFF)),
                                              child: Container(
                                                  height: 12.09,
                                                  width: 9,
                                                  padding: EdgeInsets.all(5),
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
                                                      color: Color(0xffC2C2C2),
                                                      width: 2)),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Container()),
                                            ),
                                    ),
                                  )
                                ],
                              ),
                              widget.longDesc.isEmpty
                                  ? Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 200),
                                        child: Text(
                                          "No details available!!",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "Medium",
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                  : Flexible(
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: widget.longDesc.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final subsdetail = widget.longDesc;

                                          print("id:${widget.id}");
                                          return Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 21, top: 10),
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Color(0xff007BFF),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 8,
                                                    right: 20,
                                                    top: 10),
                                                width: 250,
                                                child: Text(
                                                  subsdetail[index].name,
                                                  softWrap: true,
                                                  maxLines: 30,
                                                  style: TextStyle(
                                                    fontFamily: "Medium",
                                                    fontSize: 14,
                                                    color: Color(0xff007BFF),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 36,
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
                              provider.subsVehicleSelection = true;

                              provider.subscriptionSpecialvalue == false
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
                                          VehicleList(
                                            id: widget.id.toString(),
                                            price: widget.price,
                                            vehicleImagePath: '',
                                            vehicleBrandName: '',
                                            vehicleModelName: '',
                                            vehicleTypeName: '',
                                            vehicleRegNo: '',
                                            vehicleId: '',
                                            serviceId: '',
                                            serviceName: widget.name,
                                            longDesc: widget.longDesc,
                                            image: widget.image,
                                            timeDuration: widget.timeDuration,
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
                                      // },
                                      ));

                              // Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => VehicleList(
                              //             id: provider
                              //                 .objSubsDetailsResponse.data.id
                              //                 .toString(),
                              //             price: provider
                              //                 .objSubsDetailsResponse.data.price
                              //                 .toString(),
                              //             vehicleImagePath: '',
                              //             vehicleBrandName: '',
                              //             vehicleModelName: '',
                              //             vehicleTypeName: '',
                              //             vehicleRegNo: '',
                              //             vehicleId: '',
                              //           ),
                              //         ),
                              //       );

                              // provider.getSubscriptionAddApi(
                              //     userVehicleId,
                              //     userAddressId,
                              //     provider.objSubsDetailsResponse.data.id,
                              //     provider.objSubsDetailsResponse.data.price,
                              //     context);
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
