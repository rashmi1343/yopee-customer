import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import '../../Utility/Environment.dart';

class Profile extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      provider.setEnableButton();
      provider.getProfileViewApi(context);
      provider.profileNameController.text =
          provider.objProfileViewResponse.data!.name == null ||
                  provider.objProfileViewResponse.data!.name == ""
              ? ""
              : provider.objProfileViewResponse.data!.name.toString();
      provider.profileEmailAddressController.text =
          provider.objProfileViewResponse.data!.email == null ||
                  provider.objProfileViewResponse.data!.name == ""
              ? ""
              : provider.objProfileViewResponse.data!.email.toString();
      provider.profilePhoneNumberController.text =
          Environment.loginMobileNumber;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isEmpty || !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return Scaffold(
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
                  // Navigator.of(context).pushNamed('/dashboard');

                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                "My Account",
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
                  SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      provider.image != null
                          ? Container(
                              margin: EdgeInsets.only(left: 150, right: 150),
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: Image.file(
                                  //to show image, you type like this.
                                  File(provider.image!.path),
                                  fit: BoxFit.cover,
                                ).image,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(left: 150, right: 150),
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(50),
                              // ),
                              child: provider.isProfileEdit == true
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundImage: Image.network(provider
                                              .objProfileViewResponse
                                              .data!
                                              .profileImageUrl
                                              .toString())
                                          .image,
                                    )
                                  : Image.asset(
                                      "assets/images/menu/profile.png"),
                            ),
                      Positioned(
                        left: 200,
                        right: 130,
                        top: 43,
                        child: Container(
                          height: 30,
                          width: 30,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/images/edit.svg",
                              color: Colors.white,
                              height: 60,
                              width: 60,
                            ),
                            onPressed: () {
                              // provider.pickImages();

                              imageDialog(provider, context);
                              //Navigator.of(context).pushNamed('/profile');
                            },
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff0072C6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "Medium"),
                              ),
                            ),
                            provider.isProfileEdit == true
                                // ? Container(
                                //     height: 50,
                                //     width: 374,
                                //     padding: EdgeInsets.only(
                                //         left: 16, top: 15, bottom: 16),
                                //     decoration: BoxDecoration(
                                //         border: Border.all(
                                //             color: Color(0xff707070), width: 1),
                                //         borderRadius: BorderRadius.circular(6)),
                                //     margin: EdgeInsets.only(left: 20, right: 20),
                                //     child: TextFormField(
                                //       controller: provider.profileNameController,
                                //       keyboardType: TextInputType.text,
                                //       textInputAction: TextInputAction.next,
                                //       validator: (value) {
                                //         if (value!.length < 2) {
                                //           return 'Name not long enough';
                                //         }
                                //       },
                                //       decoration: const InputDecoration(
                                //           border: InputBorder.none,
                                //           hintText: "Enter Your Name",
                                //           contentPadding: EdgeInsets.all(10.0),
                                //           hintStyle: TextStyle(
                                //               fontSize: 15,
                                //               fontFamily: "Medium",
                                //               color: ColorTheme.themeGrayColor)),
                                //       style: TextStyle(
                                //           fontSize: 15, fontFamily: "Medium"),
                                //     ),
                                //   )
                                ? TextFormField(
                                    controller: provider.profileNameController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.length < 2) {
                                        return 'Name not long enough';
                                      }
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(30),
                                    ],
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff707070),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                              color: ColorTheme.themeGreenColor,
                                              width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff707070),
                                              width: 1),
                                        ),
                                        hintText: "Enter Your Name",
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Medium",
                                            color: ColorTheme.themeGrayColor)),
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: "Medium"),
                                  )
                                : Container(
                                    height: 50,
                                    width: 374,
                                    padding: EdgeInsets.only(
                                        left: 16, top: 15, bottom: 16),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff707070), width: 1),
                                        borderRadius: BorderRadius.circular(6)),
                                    // margin:
                                    //     EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      "${provider.objProfileViewResponse.data?.name}",
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: "Medium"),
                                    ),
                                  ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Email Address",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "Medium"),
                              ),
                            ),
                            provider.isProfileEdit == true
                                ? TextFormField(
                                    controller:
                                        provider.profileEmailAddressController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9@a-zA-Z.]")),
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: validateEmail,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff707070),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                              color: ColorTheme.themeGreenColor,
                                              width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff707070),
                                              width: 1),
                                        ),
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintText: "Enter email address",
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Medium",
                                            color: ColorTheme.themeGrayColor)),
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: "Medium"),
                                  )
                                : Container(
                                    height: 50,
                                    width: 374,
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      top: 15,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff707070), width: 1),
                                        borderRadius: BorderRadius.circular(6)),
                                    // margin:
                                    //     EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      provider
                                          .objProfileViewResponse.data!.email
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: "Medium"),
                                    ),
                                  ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Phone No.",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "Medium"),
                              ),
                            ),
                            // provider.isProfileEdit == true
                            //     ? TextFormField(
                            //         controller:
                            //             provider.profilePhoneNumberController,
                            //         keyboardType: TextInputType.phone,
                            //         inputFormatters: <TextInputFormatter>[
                            //           LengthLimitingTextInputFormatter(10),
                            //         ],
                            //         validator: (value) {
                            //           if (value!.isEmpty) {
                            //             return "Please Enter a Phone Number";
                            //           } else if (!RegExp(
                            //                   r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                            //               .hasMatch(value)) {
                            //             return "Please Enter a Valid Phone Number";
                            //           }
                            //         },
                            //         decoration: InputDecoration(
                            //             enabledBorder: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(6.0),
                            //               borderSide: BorderSide(
                            //                   color: Color(0xff707070),
                            //                   width: 1),
                            //             ),
                            //             focusedBorder: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(6.0),
                            //               borderSide: BorderSide(
                            //                   color: ColorTheme.themeGreenColor,
                            //                   width: 1),
                            //             ),
                            //             border: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(6.0),
                            //               borderSide: BorderSide(
                            //                   color: Color(0xff707070),
                            //                   width: 1),
                            //             ),
                            //             contentPadding: EdgeInsets.all(10.0),
                            //             hintText: "Enter Phone Number",
                            //             hintStyle: TextStyle(
                            //                 fontSize: 15,
                            //                 fontFamily: "Medium",
                            //                 color: ColorTheme.themeGrayColor)),
                            //         textInputAction: TextInputAction.done,
                            //         style: TextStyle(
                            //             fontSize: 15, fontFamily: "Medium"),
                            //       )
                            //     :
                            Container(
                              height: 50,
                              width: 374,
                              padding: EdgeInsets.only(
                                  left: 16, top: 15, bottom: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff707070), width: 1),
                                  borderRadius: BorderRadius.circular(6)),
                              //   margin: EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                provider.objProfileViewResponse.data!.mobile
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15, fontFamily: "Medium"),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 15, top: 17),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // disabledBackgroundColor:
                            //     ColorTheme.themeDarkGrayColor,
                            backgroundColor: provider.profileUpdateClicked
                                ? ColorTheme.themeGreenColor
                                : ColorTheme.themeDarkGrayColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            minimumSize: Size(374, 56),
                          ),
                          onPressed: provider.profileUpdateClicked
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // Navigator.of(context).pushNamed('/addVehicle');
                                    if (provider
                                        .profileNameController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Please enter your name!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else if (provider
                                        .profileEmailAddressController
                                        .text
                                        .isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Please enter email address!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    // else if (provider
                                    //     .profilePhoneNumberController
                                    //     .text
                                    //     .isEmpty) {
                                    //   Fluttertoast.showToast(
                                    //       msg: "Please enter phone number!",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.CENTER,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.red,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0);
                                    // }
                                    else {
                                      provider.setDisableButton();
                                      provider.getProfileUpdateApi(
                                          provider.profileNameController.text,
                                          provider.profileEmailAddressController
                                              .text,
                                          provider.objProfileViewResponse.data!
                                              .mobile
                                              .toString(),
                                          context);
                                    }
                                  }
                                }
                              : null,
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                                color: ColorTheme.themeBlackColor,
                                fontSize: 16,
                                fontFamily: "SemiBold"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
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
                      provider.pickImages(ImageSource.gallery);
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
                      provider.pickImages(ImageSource.camera);
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
