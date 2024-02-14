import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yopee_customer/Utility/ColorTheme.dart';

import '../../Presenter/YopeeProvider.dart';

class RateWashData {
  final String imagePath;
  bool isSelected;
  String name;

  RateWashData({
    required this.imagePath,
    required this.isSelected,
    required this.name,
  });
}

class RateWash extends StatefulWidget {
  String bookingId;

  RateWash({required this.bookingId});

  RateWashState createState() => RateWashState();
}

class RateWashState extends State<RateWash> {
  List<RateWashData> imageDataList = [
    RateWashData(
      imagePath: "assets/images/sad.png",
      isSelected: false,
      name: 'Sad',
    ),
    RateWashData(
      imagePath: "assets/images/normal.png",
      isSelected: false,
      name: 'Normal',
    ),
    RateWashData(
      imagePath: "assets/images/good.png",
      isSelected: false,
      name: 'Good',
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      // DateTime today = DateTime.now();
      // String month = DateFormat("MMMM").format(today);
      // provider.getReportsListApi(month, context);
    });
  }

  Future<bool> _willPopCallback() async {
    Navigator.of(context).pushNamed('/reports');
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
          backgroundColor: Colors.white,
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
                    Navigator.of(context).pushNamed('/reports');
                  },
                ),
                centerTitle: true,
                title: Text(
                  "Rate Wash",
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
                  // physics: ScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "How Likely are you to answer to this",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Medium",
                              color: Color(0xff646464)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "question?",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Medium",
                              color: Color(0xff646464)),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        width: 354,
                        height: 83,
                        margin: EdgeInsets.only(left: 21),
                        alignment: Alignment.center,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: imageDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  provider.setRateWashSelected(index, true);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectedRateWash == index
                                        ? Card(
                                            //   color: Colors.white,
                                            elevation: 1,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 73,
                                              width: 73,
                                              child: Image.asset(
                                                imageDataList[index].imagePath,
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          )
                                        : Image.asset(
                                            imageDataList[index].imagePath,
                                            height: 50,
                                            width: 50,
                                          ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 51,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 21),
                        child: Text(
                          "Upload Images",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Medium",
                              color: Color(0xff646464)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 103,
                        margin: EdgeInsets.only(left: 21, right: 21, top: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffF6F6FE),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                //height: 300.0,
                                child: provider.selectedImages.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.only(left: 21),
                                        alignment: Alignment.center,
                                        height: 64.81,
                                        width: 68,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(50),
                                        // ),
                                        child: Image.asset(
                                            "assets/images/menu/profile.png"),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            provider.selectedImages.length,
                                        scrollDirection: Axis.horizontal,
                                        // gridDelegate:
                                        //     const SliverGridDelegateWithFixedCrossAxisCount(
                                        //         crossAxisCount: 3),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Center(
                                              child: kIsWeb
                                                  ? Image.network(provider
                                                      .selectedImages[index]
                                                      .path)
                                                  : Row(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: 15,
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 64.81,
                                                              width: 68,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: Image.file(
                                                                          provider
                                                                              .selectedImages[index])
                                                                      .image,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 68,
                                                              bottom: 48,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    provider
                                                                        .selectedImages
                                                                        .removeAt(
                                                                            index);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 15,
                                                                  width: 15,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .black26),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ));
                                        },
                                      ),
                              ),
                            ),
                            // provider.image != null
                            //     ? Container(
                            //         margin: EdgeInsets.only(
                            //           left: 21,
                            //         ),
                            //         alignment: Alignment.center,
                            //         height: 64.81,
                            //         width: 68,
                            //         decoration: BoxDecoration(
                            //           image: DecorationImage(
                            //             image: Image.file(
                            //               //to show image, you type like this.
                            //               File(provider.image!.path),
                            //               fit: BoxFit.cover,
                            //             ).image,
                            //           ),
                            //         ),
                            //       )
                            //     : Container(
                            //         margin: EdgeInsets.only(left: 21),
                            //         alignment: Alignment.center,
                            //         height: 64.81,
                            //         width: 68,
                            //         // decoration: BoxDecoration(
                            //         //   borderRadius: BorderRadius.circular(50),
                            //         // ),
                            //         child: Image.asset(
                            //             "assets/images/menu/profile.png"),
                            //       ),
                            GestureDetector(
                              onTap: () {
                                imageDialog(provider, context);
                              },
                              child: Container(
                                width: 68,
                                height: 64.41,
                                margin: EdgeInsets.only(left: 11, right: 11),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff0000001A), //New
                                      blurRadius: 10.0,
                                    )
                                  ],
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(18),
                                  child: SvgPicture.asset(
                                    "assets/images/add-plus.svg",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 21, top: 25),
                        child: Text(
                          "Let us know your Feedback",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Medium",
                              color: Color(0xff646464)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 103,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 21, right: 21, top: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffF6F6FE),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: provider.feedbackController,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Medium",
                              color: Color(0xff111111)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 21, top: 25),
                        child: Text(
                          "Rating",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Medium",
                              color: Color(0xff646464)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 103,
                        margin: EdgeInsets.only(left: 21, right: 21, top: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffF6F6FE),
                            borderRadius: BorderRadius.circular(15)),
                        child: RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 32,
                          glow: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                          itemBuilder: (context, _) => SizedBox(
                            height: 15,
                            width: 15,
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                            provider.setRating(rating);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 25, top: 33),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // disabledBackgroundColor:
                            //     ColorTheme.themeDarkGrayColor,
                            backgroundColor: provider.isRateWashSubmit
                                ? ColorTheme.themeLightGrayColor
                                : ColorTheme.themeGreenColor,

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            minimumSize: Size(374, 56),
                          ),
                          onPressed: () {
                            if (provider.feedbackController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Feedback is required!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              if (!provider.isRateWashSubmit) {
                                provider.isRateWashSubmit = true;
                                provider.uploadRateWashImage(
                                    widget.bookingId,
                                    imageDataList[provider.selectedRateWash]
                                        .name,
                                    provider.rating.toString(),
                                    provider.feedbackController.text,
                                    context);
                              }
                            }
                          },
                          child: const Text(
                            'Submit',
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

  void imageDialog(YopeeProvider provider, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              'Please choose media to select',
              style: TextStyle(
                  fontSize: 15, fontFamily: "SemiBold", color: Colors.black),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      provider.getWashImages(ImageSource.gallery);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'From Gallery',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Medium",
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      provider.getWashImages(ImageSource.camera);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.camera),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'From Camera',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Medium",
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: ColorTheme.themeLightGrayColor,
                    //   // shape: RoundedRectangleBorder(
                    //   //     borderRadius: BorderRadius.circular(6.0)),
                    //   // minimumSize: Size(374, 56),
                    // ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Medium",
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
