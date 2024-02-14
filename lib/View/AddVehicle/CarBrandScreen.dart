import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/View/AddVehicle/AddVehicleScreen2.dart';
import 'package:yopee_customer/View/AddVehicle/VehicleTypeScreen.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';

import 'CarModelScreen.dart';

class CarBrandScreen extends StatefulWidget {
  String id;
  String userId;
  String vehicleTypeId;
  String carBrandId;
  String carModelId;
  String registrationNo;
  String carBrandName;
  String carModelName;

  CarBrandScreen({
    required this.id,
    required this.userId,
    required this.carBrandId,
    required this.carModelId,
    required this.vehicleTypeId,
    required this.registrationNo,
    required this.carBrandName,
    required this.carModelName,
  });

  CarBrandScreenState createState() => CarBrandScreenState();
}

class ImageData {
  final String imagePath;
  bool isSelected;

  ImageData({
    required this.imagePath,
    required this.isSelected,
  });
}

class CarBrandScreenState extends State<CarBrandScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);

      provider.getCarBrandListApi(context);

      provider.carBrandController.clear();
      // provider.selectedCarBrandIndex = -1;
      provider.carBrandController.addListener(() {
        provider.changeCarBrandSearchString(provider.carBrandController.text);
      });
      // provider.getVehicleTypeListApi(context);
      // String _searchText;
      //
      // provider.vehicleTypeController.addListener(() {
      //   provider
      //       .changeVehicleTypeSearchString(provider.vehicleTypeController.text);
      // });

      // if (provider.isVehicleEdit == true) {
      //   String registrationNumber = widget.registrationNo.toString();
      //   provider.RegNoOneEditController.text =
      //       registrationNumber.substring(0, 2);
      //   provider.RegNoTwoEditController.text =
      //       registrationNumber.substring(2, 4);
      //   provider.RegNoThreeEditController.text =
      //       registrationNumber.substring(4, 6);
      //   provider.RegNoFourEditController.text = registrationNumber.substring(6);
      // } else {
      //   provider.RegNoOneEditController.text = "";
      //   provider.RegNoTwoEditController.text = "";
      //   provider.RegNoThreeEditController.text = "";
      //   provider.RegNoFourEditController.text = "";
      // }
    });
  }

  @override
  void dispose() {
    var provider = Provider.of<YopeeProvider>(context, listen: false);

    // provider.vehicleTypeController.dispose();
    provider.carBrandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ImageData> imageDataList = [
      ImageData(
        imagePath: "assets/images/addVehicle/car-1.png",
        isSelected: false,
      ),
      ImageData(
        imagePath: "assets/images/addVehicle/car-2.png",
        isSelected: false,
      ),
      ImageData(
        imagePath: "assets/images/addVehicle/car-3.png",
        isSelected: false,
      ),
      ImageData(
        imagePath: "assets/images/addVehicle/car-4.png",
        isSelected: false,
      ),
      ImageData(
        imagePath: "assets/images/addVehicle/car-5.png",
        isSelected: false,
      ),
      ImageData(
        imagePath: "assets/images/addVehicle/car-6.png",
        isSelected: false,
      ),
      ImageData(
        imagePath: "assets/images/addVehicle/car-7.png",
        isSelected: false,
      ),
    ];

    var provider = Provider.of<YopeeProvider>(context, listen: false);

    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () {
          return provider.getCarBrandListApi(context);
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
                  onPressed: () => Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) =>
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
                      )),
                ),
                centerTitle: true,
                title:
                    // provider.isVehicleEdit == true
                    //     ? Text(
                    //         "Edit Vehicle",
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontFamily: "SemiBold",
                    //             color: Color(0xff313131)),
                    //       )
                    //     :
                    Text(
                  "Car Brand",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "SemiBold",
                      color: Color(0xff313131)),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 10, left: 5),
                    child: AnimSearchBar(
                      width: 365,
                      textController: provider.carBrandController,
                      onSuffixTap: () {
                        setState(() {
                          provider.carBrandController.clear();
                          // provider.changeVehicleTypeSearchString("");
                          // provider.vehicleTypeController.text = "";
                        });
                      },
                      color: Colors.transparent,
                      helpText: "Search Text...",
                      autoFocus: false,
                      boxShadow: false,
                      closeSearchOnSuffixTap: true,
                      animationDurationInMilli: 1000,
                      rtl: true,
                      onSubmitted: (String) {
                        // provider.changeVehicleTypeSearchString(String);
                        provider.changeCarBrandSearchString(String);
                      },
                    ),
                  ),
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
                      // Container(
                      //   margin: EdgeInsets.only(left: 20, top: 27),
                      //   child: Text(
                      //     "Select Your Car Brand",
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         fontFamily: "SemiBold",
                      //         color: Color(0xff001F3F)),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 24,
                      // ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        // itemCount: provider.objCarBrandListResponse.data.length,
                        itemCount: provider.carBrandDataArr.length,
                        itemBuilder: (context, index) {
                          var carBrandItems = provider.carBrandDataArr;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  provider.toggleCarBrandSelected(
                                      index, carBrandItems[index].name);

                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          CarModelScreen(
                                        carBrandName: carBrandItems[index].name,
                                        carBrandId:
                                            carBrandItems[index].id.toString(),
                                      ),
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
                                      //       // begin: const Offset(1.0, 0.0),
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

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return ScaleTransition(
                                          scale: animation.drive(tween),
                                          child: page,
                                        );
                                      },
                                    ));
                                  });
                                  imageDataList[index].isSelected = true;
                                },
                                child: Container(
                                  height: 85,
                                  width: 113,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  decoration: provider.selectedCarBrandIndex ==
                                          index
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: ColorTheme.themeGreenColor,
                                              width: 2))
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Color(0xffCCCCCC),
                                              width: 2)),
                                  child: Container(
                                    height: 35,
                                    width: 84,
                                    margin: EdgeInsets.only(
                                        top: 25,
                                        bottom: 25,
                                        left: 15,
                                        right: 14),
                                    child: Image.network(
                                      carBrandItems[index].image,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        Future.delayed(Duration.zero, () {
                                          Navigator.pushReplacementNamed(
                                              context, '/addVehicle');
                                        });

                                        return Container();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                // margin: EdgeInsets.only(
                                //   left: 15,
                                // ),
                                child: Text(
                                  carBrandItems[index].name,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Medium",
                                      color: Color(0xff333333)),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
