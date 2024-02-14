import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import 'AddNewVehicle.dart';

class ImageData {
  final String imagePath;
  bool isSelected;

  ImageData({
    required this.imagePath,
    required this.isSelected,
  });
}

class AddVehicleScreen2 extends StatefulWidget {
  AddVehicleScreen2State createState() => AddVehicleScreen2State();
}

class AddVehicleScreen2State extends State<AddVehicleScreen2> {
  List<ImageData> imageDataList = [
    ImageData(
      imagePath: "assets/images/carBrand/Suzuki.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Hyundai.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Audi.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/BMW.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Citrogen.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Honda.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Mahindra.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Mercedes.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/MG_Motors.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Nissan.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Renault.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Tata.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Toyota.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Volkswagen.png",
      isSelected: false,
    ),
    ImageData(
      imagePath: "assets/images/carBrand/Volvo.png",
      isSelected: false,
    ),
  ];

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
    });
  }

  @override
  void dispose() {
    var provider = Provider.of<YopeeProvider>(context, listen: false);

    provider.carBrandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
                centerTitle: true,
                title: Text(
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
                      width: 390,
                      textController: provider.carBrandController,
                      onSuffixTap: () {
                        setState(() {
                          provider.carBrandController.clear();
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
                      SizedBox(
                        height: 40,
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
                                          AddNewVehicle(
                                        id: carBrandItems[index].id.toString(),
                                        userId: '',
                                        carBrandId: '',
                                        carModelId: '',
                                        vehicleTypeId: '',
                                        registrationNo: '',
                                        carBrandName: carBrandItems[index].name,
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
                                    //         carBrandName:
                                    //             carBrandItems[index].name,
                                    //         carModelName: '',
                                    //       ),
                                    //     ));
                                  });
                                  //imageDataList[index].isSelected = true;
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
