import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/Presenter/YopeeProvider.dart';
import 'package:yopee_customer/View/AddVehicle/CarBrandScreen.dart';
import 'package:yopee_customer/View/AddVehicle/VehicleTypeScreen.dart';

import '../../Utility/ColorTheme.dart';
import 'AddNewVehicle.dart';

class CarModelScreen extends StatefulWidget {
  String carBrandName;
  String carBrandId;

  CarModelScreen({required this.carBrandName, required this.carBrandId});

  CarModelScreenState createState() => CarModelScreenState();
}

class CarModelScreenState extends State<CarModelScreen> {
  List<String> carModel = [
    "Swift",
    "Brezza",
    "FRONX",
    "Ertiga",
    "Baleno",
    "Maruti Suzuki Dezire",
    "Wagon R",
    "Jimny",
    "Alto 800",
    "Alto K10",
    "Celerio",
    "XL6",
    "Eeco"
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      provider.getCarModelListApi(widget.carBrandId, context);
      provider.carModelController.clear();
      // provider.selectedCarModelIndex = -1;
      provider.carModelController.addListener(() {
        provider.changeCarModelSearchString(provider.carModelController.text);
      });
    });
  }

  @override
  void dispose() {
    var provider = Provider.of<YopeeProvider>(context, listen: false);

    provider.carModelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () {
          return provider.getCarModelListApi(widget.carBrandId, context);
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
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CarBrandScreen(
                        id: '',
                        userId: '',
                        carBrandId: widget.carBrandId,
                        carModelId: '',
                        vehicleTypeId: '',
                        registrationNo: '',
                        carBrandName: widget.carBrandName,
                        carModelName: '',
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
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, page) {
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
                  "Car Model",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "SemiBold",
                      color: Color(0xff313131)),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 10, left: 5),
                    child: AnimSearchBar(
                      width: 390,
                      textController: provider.carModelController,
                      onSuffixTap: () {
                        setState(() {
                          provider.carModelController.clear();
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
                        provider.changeCarModelSearchString(String);
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
                    children: [
                      ListView.builder(
                        // itemCount: provider.objCarModelListResponse.data.length,
                        itemCount: provider.carModelDataArr.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int sectionIndex) {
                          var carModelItems = provider.carModelDataArr;
                          return GestureDetector(
                            onTap: () {
                              provider.toggleCarModelSelected(sectionIndex,
                                  carModelItems[sectionIndex].name);

                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      VehicleTypeScreen(
                                    id: carModelItems[sectionIndex]
                                        .id
                                        .toString(),
                                    userId: '',
                                    carBrandId: widget.carBrandId,
                                    carModelId: '',
                                    vehicleTypeId: '',
                                    registrationNo: '',
                                    carBrandName: widget.carBrandName,
                                    carModelName:
                                        carModelItems[sectionIndex].name,
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

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    return ScaleTransition(
                                      scale: animation.drive(tween),
                                      child: page,
                                    );
                                  },
                                ));

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => AddNewVehicle(
                                //         id: '',
                                //         userId: '',
                                //         carBrandId: '',
                                //         carModelId: '',
                                //         vehicleTypeId: '',
                                //         registrationNo: '',
                                //         carBrandName: widget.carBrandName,
                                //         carModelName:
                                //             carModelItems[sectionIndex].name,
                                //       ),
                                //     ));
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                padding: EdgeInsets.only(
                                    left: 20, top: 16, right: 16),
                                width: 374,
                                height: 50,
                                decoration: provider.selectedCarModelIndex ==
                                        sectionIndex
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: ColorTheme.themeGreenColor,
                                            width: 1),
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Color(0xffCCCCCC), width: 1),
                                      ),
                                child: Text(
                                  carModelItems[sectionIndex].name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Medium",
                                    color: Color(0xff333333),
                                  ),
                                )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
