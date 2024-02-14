import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/View/AddVehicle/AddVehicleScreen2.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';

import 'CarModelScreen.dart';

class AddNewVehicle extends StatefulWidget {
  String id;
  String userId;
  String vehicleTypeId;
  String carBrandId;
  String carModelId;
  String registrationNo;
  String carBrandName;
  String carModelName;

  AddNewVehicle({
    required this.id,
    required this.userId,
    required this.carBrandId,
    required this.carModelId,
    required this.vehicleTypeId,
    required this.registrationNo,
    required this.carBrandName,
    required this.carModelName,
  });

  AddNewVehicleState createState() => AddNewVehicleState();
}

class ImageData {
  final String imagePath;
  bool isSelected;

  ImageData({
    required this.imagePath,
    required this.isSelected,
  });
}

class AddNewVehicleState extends State<AddNewVehicle> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);

      provider.getCarBrandListApi(context);
      provider.carBrandController.clear();
      // provider.getVehicleTypeListApi(context);
      // String _searchText;
      //
      // provider.vehicleTypeController.addListener(() {
      //   provider
      //       .changeVehicleTypeSearchString(provider.vehicleTypeController.text);
      // });

      if (provider.isVehicleEdit == true) {
        String registrationNumber = widget.registrationNo.toString();
        provider.RegNoOneEditController.text =
            registrationNumber.substring(0, 2);
        provider.RegNoTwoEditController.text =
            registrationNumber.substring(2, 4);
        provider.RegNoThreeEditController.text =
            registrationNumber.substring(4, 6);
        provider.RegNoFourEditController.text = registrationNumber.substring(6);
      } else {
        provider.RegNoOneEditController.text = "";
        provider.RegNoTwoEditController.text = "";
        provider.RegNoThreeEditController.text = "";
        provider.RegNoFourEditController.text = "";
      }
    });
  }

  @override
  void dispose() {
    var provider = Provider.of<YopeeProvider>(context, listen: false);

    provider.vehicleTypeController.dispose();
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
          return provider.getVehicleTypeListApi("21", context);
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
                title: provider.isVehicleEdit == true
                    ? Text(
                        "Edit Vehicle",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "SemiBold",
                            color: Color(0xff313131)),
                      )
                    : Text(
                        "Add New Vehicle",
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
                      textController: provider.vehicleTypeController,
                      onSuffixTap: () {
                        setState(() {
                          provider.vehicleTypeController.clear();
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
                        provider.changeVehicleTypeSearchString(String);
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
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 27),
                        child: Text(
                          "Select Your Vehicle Type",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "SemiBold",
                              color: Color(0xff001F3F)),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
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
                        itemCount: provider.vehicleTypeDataArr.length,
                        itemBuilder: (context, index) {
                          var vehicleTypeItems = provider.vehicleTypeDataArr;
                          int selectedIndex = index;
                          print(("selectedIndex:$selectedIndex"));
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              provider.isVehicleEdit == true
                                  ? GestureDetector(
                                      onTap: () {
                                        // provider.setVehicleTypeColor(
                                        //     ColorTheme.themeGreenColor, selectedIndex);

                                        provider
                                            .toggleVehicleTypeSelected(index);
                                      },
                                      child: Container(
                                        height: 85,
                                        width: 113,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        decoration: widget.vehicleTypeId ==
                                                index
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: ColorTheme
                                                        .themeGreenColor,
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
                                            // imageDataList[index].imagePath),
                                            vehicleTypeItems[index].image,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              Navigator.pushReplacementNamed(
                                                  context, '/dashboard');
                                              return Container();
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        // provider.setVehicleTypeColor(
                                        //     ColorTheme.themeGreenColor, selectedIndex);

                                        provider
                                            .toggleVehicleTypeSelected(index);
                                      },
                                      child: Container(
                                        height: 85,
                                        width: 113,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        decoration: provider
                                                    .selectedVehicleIndex ==
                                                index
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: ColorTheme
                                                        .themeGreenColor,
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
                                            // imageDataList[index].imagePath),
                                            vehicleTypeItems[index].image,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              Navigator.pushReplacementNamed(
                                                  context, '/dashboard');
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
                                //margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  vehicleTypeItems[index].name,
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
                      GestureDetector(
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        AddVehicleScreen2(),
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
                                //       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                //   return ScaleTransition(
                                //     scale: animation.drive(tween),
                                //     child: page,
                                //   );
                                // },
                                ));

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => AddVehicleScreen2(),
                            //   ),
                            // );
                          });
                          // SchedulerBinding.instance.addPostFrameCallback((_) {

                          //  });

                          // Navigator.of(context).pushNamed('/addVehicle2');
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20, right: 10),
                          height: 59,
                          width: 374,
                          margin: provider.isCarBrandSelected == true
                              ? EdgeInsets.only(left: 20, right: 20, bottom: 8)
                              : EdgeInsets.only(
                                  left: 20, right: 20, bottom: 25),
                          decoration: BoxDecoration(
                              color: Color(0xffEEEEEE),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(
                                "Car Brand",
                                style: TextStyle(
                                    fontFamily: "SemiBold",
                                    fontSize: 16,
                                    color: Color(0xff333333)),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xff333333),
                              )
                            ],
                          ),
                        ),
                      ),
                      provider.isCarBrandSelected == true
                          ? Container(
                              height: 30,
                              width: 80,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(left: 20, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffFFF6F6),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Color(0xffE32222), width: 1)),
                              child: Center(
                                child: Text(
                                  provider.carBrandName,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Regular",
                                      color: Color(0xffE32222)),
                                ),
                              ),
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      CarModelScreen(
                                        carBrandName: '',
                                        carBrandId: widget.id,
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
                              //       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              //   return ScaleTransition(
                              //     scale: animation.drive(tween),
                              //     child: page,
                              //   );
                              // },
                              ));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => AddVehicleScreen3(
                          //         carBrandName: widget.carModelName,
                          //       ),
                          //     ));
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20, right: 10),
                          height: 59,
                          width: 374,
                          margin: provider.isCarModelSelected == true
                              ? EdgeInsets.only(left: 20, right: 20, bottom: 8)
                              : EdgeInsets.only(
                                  left: 20, right: 20, bottom: 25),
                          decoration: BoxDecoration(
                              color: Color(0xffEEEEEE),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(
                                "Car Model",
                                style: TextStyle(
                                    fontFamily: "SemiBold",
                                    fontSize: 16,
                                    color: Color(0xff333333)),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xff333333),
                              )
                            ],
                          ),
                        ),
                      ),
                      provider.isCarModelSelected == true
                          ? Container(
                              height: 30,
                              width: 80,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(left: 20, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffFFF6F6),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Color(0xffE32222), width: 1)),
                              child: Center(
                                child: Text(
                                  provider.carModelName,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Regular",
                                      color: Color(0xffE32222)),
                                ),
                              ),
                            )
                          : Container(),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                            ),
                            child: Text(
                              "Registration Number",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "SemiBold",
                                  color: Color(0xff001F3F)),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "BH",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Medium",
                                color: ColorTheme.themeDarkGrayColor),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xff007BFF),
                            value: provider.valueBHChecked,
                            onChanged: (bool? value) {
                              provider.setBHChecked(value);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      provider.valueBHChecked == true
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              height: 59,
                              width: 374,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 25, top: 11),
                              decoration: provider.RegistrationNumber.isEmpty
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xffEEEEEE), width: 1),
                                      borderRadius: BorderRadius.circular(10))
                                  : BoxDecoration(
                                      color: Color(0xffEEEEEE),
                                      borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  provider.isVehicleEdit == true
                                      ? Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: 'DL',
                                              // hintStyle: TextStyle(
                                              //     fontFamily: "Medium",
                                              //     fontSize: 14,
                                              //     color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoOneEditController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'YY',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 14,
                                                  color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoOneController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        ),
                                  Container(
                                    height: 50,
                                    width: 30,
                                    child: TextFormField(
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'BH',
                                        hintStyle: TextStyle(
                                            fontFamily: "Medium",
                                            fontSize: 14,
                                            color: Color(0xff8D8D8D)),
                                      ),
                                      controller: provider.RegNoTwoController,
                                      style: TextStyle(
                                          fontFamily: "Medium",
                                          fontSize: 14,
                                          color: Color(0xff8D8D8D)),
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(2),
                                      ],
                                    ),
                                  ),
                                  provider.isVehicleEdit == true
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: 'AQ',
                                              // hintStyle: TextStyle(
                                              //     fontFamily: "Medium",
                                              //     fontSize: 14,
                                              //     color: Color(0xff8D8D8D)),
                                            ),
                                            controller: provider
                                                .RegNoThreeEditController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 50,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '1234',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 14,
                                                  color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoThreeController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        ),
                                  provider.isVehicleEdit == true
                                      ? Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: '1234',
                                              // hintStyle: TextStyle(
                                              //     fontFamily: "Medium",
                                              //     fontSize: 14,
                                              //     color: Color(0xff8D8D8D)),
                                            ),
                                            controller: provider
                                                .RegNoFourEditController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'AQ',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 14,
                                                  color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoFourController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              height: 59,
                              width: 374,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 25, top: 11),
                              decoration: provider.RegistrationNumber.isEmpty
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xffEEEEEE), width: 1),
                                      borderRadius: BorderRadius.circular(10))
                                  : BoxDecoration(
                                      color: Color(0xffEEEEEE),
                                      borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  provider.isVehicleEdit == true
                                      ? Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: 'DL',
                                              // hintStyle: TextStyle(
                                              //     fontFamily: "Medium",
                                              //     fontSize: 14,
                                              //     color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoOneEditController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'DL',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 14,
                                                  color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoOneController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        ),
                                  provider.isVehicleEdit == true
                                      ? Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: '25',
                                              // hintStyle: TextStyle(
                                              //     fontFamily: "Medium",
                                              //     fontSize: 14,
                                              //     color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoTwoEditController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '25',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 14,
                                                  color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoTwoController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        ),
                                  provider.isVehicleEdit == true
                                      ? Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: 'AQ',
                                              // hintStyle: TextStyle(
                                              //     fontFamily: "Medium",
                                              //     fontSize: 14,
                                              //     color: Color(0xff8D8D8D)),
                                            ),
                                            controller: provider
                                                .RegNoThreeEditController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 30,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'AQ',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 14,
                                                  color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoThreeController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                          ),
                                        ),
                                  provider.isVehicleEdit == true
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: '1234',
                                              // hintStyle: TextStyle(
                                              //     fontFamily: "Medium",
                                              //     fontSize: 14,
                                              //     color: Color(0xff8D8D8D)),
                                            ),
                                            controller: provider
                                                .RegNoFourEditController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 50,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '1234',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Medium",
                                                  fontSize: 14,
                                                  color: Color(0xff8D8D8D)),
                                            ),
                                            controller:
                                                provider.RegNoFourController,
                                            style: TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14,
                                                color: Color(0xff8D8D8D)),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
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
                            if (provider.isVehicleEdit == true) {
                              String regnoEdit = provider
                                      .RegNoOneEditController.text
                                      .toString() +
                                  provider.RegNoTwoEditController.text
                                      .toString() +
                                  provider.RegNoThreeEditController.text
                                      .toString() +
                                  provider.RegNoFourEditController.text
                                      .toString();
                              print("RegistrationNumber:$regnoEdit ");

                              provider.setRegNumber(regnoEdit);
                              provider.getVehicleEditApi(
                                  widget.id.toString(),
                                  widget.userId.toString(),
                                  widget.vehicleTypeId.toString(),
                                  widget.carBrandId.toString(),
                                  widget.carModelId.toString(),
                                  provider.RegistrationNumber,
                                  context);
                            } else {
                              String regno = provider.RegNoOneController.text
                                      .toString() +
                                  provider.RegNoTwoController.text.toString() +
                                  provider.RegNoThreeController.text
                                      .toString() +
                                  provider.RegNoFourController.text.toString();
                              print("RegistrationNumber:$regno ");

                              provider.setRegNumber(regno);

                              if (provider.isVehicleTypeSelected == false) {
                                Fluttertoast.showToast(
                                    msg: "Please select vehicle type.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (provider.isCarBrandSelected == false) {
                                Fluttertoast.showToast(
                                    msg: "Please select car brand.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (provider.isCarModelSelected == false) {
                                Fluttertoast.showToast(
                                    msg: "Please select car model.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (provider.RegistrationNumber.isEmpty) {
                                Fluttertoast.showToast(
                                    msg:
                                        "The registration no field is required.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                provider.vehicleCount = true;
                                provider.getVehicleAddApi(
                                    "${provider.carVehicleTypeId}",
                                    "${provider.carBrandId}",
                                    "${provider.carModelId}",
                                    provider.RegistrationNumber,
                                    context);
                                provider.RegNoOneController.clear();
                                provider.RegNoTwoController.clear();
                                provider.RegNoThreeController.clear();
                                provider.RegNoFourController.clear();
                                // Navigator.of(context).pushNamed('/dashboard');
                              }
                            }
                          },
                          child: const Text(
                            'Add Vehicle',
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
      );
    });
  }
}
