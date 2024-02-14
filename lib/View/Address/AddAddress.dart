import 'dart:async';

import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maps_places_autocomplete/maps_places_autocomplete.dart';
import 'package:maps_places_autocomplete/model/place.dart';

import 'package:provider/provider.dart';

import 'package:search_map_location/widget/search_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/Utility/Environment.dart';
import 'package:yopee_customer/View/Address/saved_address.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';

import '../../Presenter/YopeeProvider.dart';

import 'StringConstants.dart';

//Model classes that will be used for auto complete
class Suggestion {
  final String placeId;
  final String description;
  final String title;

  Suggestion(this.placeId, this.description, this.title);
}

class PlaceDetail {
  String? address;
  double? latitude;
  double? longitude;
  String? name;

  PlaceDetail({
    this.address,
    this.latitude,
    this.longitude,
    this.name,
  });
}

class AddAddress extends StatefulWidget {
  String id;
  String indexId;
  String type;
  String flatHouseNo;
  String areaSector;
  String nearBy;
  String vehicleImagePath;
  String vehicleBrandName;
  String vehicleModelName;
  String vehicleTypeName;
  String vehicleRegNo;
  String vehicleId;
  String subscriptionId;
  int subscriptionPrize;

  AddAddress(
      {required this.id,
      required this.indexId,
      required this.type,
      required this.flatHouseNo,
      required this.areaSector,
      required this.nearBy,
      required this.vehicleImagePath,
      required this.vehicleBrandName,
      required this.vehicleModelName,
      required this.vehicleTypeName,
      required this.vehicleRegNo,
      required this.vehicleId,
      required this.subscriptionId,
      required this.subscriptionPrize});

  AddAddressState createState() => AddAddressState();
}

class AddAddressState extends State<AddAddress> {
  final SearchController _searchController = SearchController();
  final TextEditingController _textEditingController = TextEditingController();
  final focusNode = FocusNode();
  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      _onChanged();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);

      //provider.setAddressEnableButton();
      provider.isAddressEdit == true
          ? Container()
          : provider.clearAllAddressText();

      if (provider.isAddressEdit == true) {
        provider.flatController.text = widget.flatHouseNo;
        provider.areaController.text = widget.areaSector;
        provider.nearByController.text = widget.nearBy;
        provider.setSelectedAddressTypeText(widget.type);
      } else {
        provider.setSelectedAddressTypeText("");
      }
    });
  }

  Future<bool> willPopCallback() async {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
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

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    var provider = Provider.of<YopeeProvider>(context, listen: false);

    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: willPopCallback,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            leading: IconButton(
              iconSize: 25,
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                provider.subsAddressSelection == true
                    ? Navigator.pop(context)
                    : provider.reportNavFromMenu == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SavedAddress(
                                  vehicleImagePath: "",
                                  vehicleBrandName: "",
                                  vehicleModelName: "",
                                  vehicleTypeName: "",
                                  vehicleRegNo: "",
                                  vehicleId: "",
                                  subscriptionId: "",
                                  subscriptionPrize: 0),
                            ),
                          )
                        : Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 400),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Dashboard(),
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
              },
            ),
            title: provider.isAddressEdit == true
                ? Text(
                    "Edit Address",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SemiBold",
                        color: ColorTheme.themeBlackColor),
                  )
                : provider.subsAddressSelection == true
                    ? Text(
                        "Add New Address",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SemiBold",
                            color: ColorTheme.themeBlackColor),
                      )
                    : Text(
                        "Add New Address",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        width: 374,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        margin: EdgeInsets.only(
                            left: 10, top: 21, right: 10, bottom: 11),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 10,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: "Medium"),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search for area, street name...',
                            hintStyle: TextStyle(
                                fontFamily: "Medium",
                                fontSize: 16,
                                color: Color(0xff7D7D7D)),
                            focusColor: Colors.white,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: IconButton(
                              color: Color(0xffE7C810),
                              icon:
                                  SvgPicture.asset("assets/images/search.svg"),
                              onPressed: () async {},
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                _controller.clear();
                                provider.areaController.clear();
                              },
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 150, maxWidth: 374),
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _placeList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _controller.text =
                                      _placeList[index]["description"];
                                  provider.areaController.text =
                                      _placeList[index]["description"];
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  _placeList[index]["description"],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Medium",
                                      color: Colors.black),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 255,
                        width: 374,
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 26),
                        child: Image.asset(
                          "assets/images/addAddress.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 11),
                        child: Text(
                          "Save address as*",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Medium",
                              color: Color(0xff7B7B7B)),
                        ),
                      ),
                      provider.isAddressEdit == true
                          ? Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    right: 10,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          provider.selectedAddressType == "Home"
                                              ? ColorTheme.themeGreenColor
                                              : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      minimumSize: Size(101, 42),
                                    ),
                                    onPressed: () => provider
                                        .setSelectedAddressTypeText("Home"),
                                    child: const Text(
                                      'Home',
                                      style: TextStyle(
                                          color: ColorTheme.themeBlackColor,
                                          fontSize: 15,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          provider.selectedAddressType == "Work"
                                              ? ColorTheme.themeGreenColor
                                              : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      minimumSize: Size(101, 42),
                                    ),
                                    onPressed: () => provider
                                        .setSelectedAddressTypeText("Work"),
                                    child: const Text(
                                      'Work',
                                      style: TextStyle(
                                          color: ColorTheme.themeBlackColor,
                                          fontSize: 15,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          provider.selectedAddressType ==
                                                  "Other"
                                              ? ColorTheme.themeGreenColor
                                              : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      minimumSize: Size(101, 42),
                                    ),
                                    onPressed: () => provider
                                        .setSelectedAddressTypeText("Other"),
                                    child: const Text(
                                      'Other',
                                      style: TextStyle(
                                          color: ColorTheme.themeBlackColor,
                                          fontSize: 15,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    right: 10,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          provider.selectedAddressType == "Home"
                                              ? ColorTheme.themeGreenColor
                                              : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      minimumSize: Size(101, 42),
                                    ),
                                    onPressed: () => provider
                                        .setSelectedAddressTypeText("Home"),
                                    child: const Text(
                                      'Home',
                                      style: TextStyle(
                                          color: ColorTheme.themeBlackColor,
                                          fontSize: 15,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          provider.selectedAddressType == "Work"
                                              ? ColorTheme.themeGreenColor
                                              : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      minimumSize: Size(101, 42),
                                    ),
                                    onPressed: () => provider
                                        .setSelectedAddressTypeText("Work"),
                                    child: const Text(
                                      'Work',
                                      style: TextStyle(
                                          color: ColorTheme.themeBlackColor,
                                          fontSize: 15,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          provider.selectedAddressType ==
                                                  "Other"
                                              ? ColorTheme.themeGreenColor
                                              : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      minimumSize: Size(101, 42),
                                    ),
                                    onPressed: () => provider
                                        .setSelectedAddressTypeText("Other"),
                                    child: const Text(
                                      'Other',
                                      style: TextStyle(
                                          color: ColorTheme.themeBlackColor,
                                          fontSize: 15,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Container(
                        //  margin: EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                provider.isAddressEdit == true
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 21,
                                            bottom: 20,
                                            top: 30,
                                            right: 20),
                                        child: TextFormField(
                                          controller: provider.flatController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 5,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   LengthLimitingTextInputFormatter(30),
                                          // ],
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffCCCCCC)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xff00FF00)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 21,
                                            bottom: 20,
                                            top: 30,
                                            right: 20),
                                        child: TextFormField(
                                          controller: provider.flatController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 5,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   LengthLimitingTextInputFormatter(30),
                                          // ],
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xffCCCCCC)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xff00FF00)),
                                              ),
                                              label: Text(
                                                'Flat / House no / Floor / Building *',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Medium",
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ),
                                provider.isAddressEdit == true
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 21,
                                            bottom: 20,
                                            top: 30,
                                            right: 20),
                                        child: TextFormField(
                                          controller: provider.areaController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 5,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   LengthLimitingTextInputFormatter(35),
                                          // ],
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffCCCCCC)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xff00FF00)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 21, bottom: 20, right: 20),
                                        child: TextField(
                                          controller: provider.areaController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 5,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   LengthLimitingTextInputFormatter(30),
                                          // ],
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xffCCCCCC)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xff00FF00)),
                                              ),
                                              label: Text(
                                                'Area / Sector / Locality *',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Medium",
                                                    color: Color(0xff838383)),
                                              )),
                                        ),
                                      ),
                                provider.isAddressEdit == true
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 21,
                                            bottom: 20,
                                            top: 30,
                                            right: 20),
                                        child: TextFormField(
                                          controller: provider.nearByController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 5,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   LengthLimitingTextInputFormatter(30),
                                          // ],
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffCCCCCC)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xff00FF00)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 21, bottom: 20, right: 20),
                                        child: TextField(
                                          controller: provider.nearByController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 5,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   LengthLimitingTextInputFormatter(30),
                                          // ],
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xffCCCCCC)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xff00FF00)),
                                              ),
                                              label: Text(
                                                'Nearby Landmark (optional)',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Medium",
                                                    color: Color(0xff838383)),
                                              )),
                                        ),
                                      ),
                              ]),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 21, right: 20, bottom: 35),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: provider.saveAddressClicked
                                ? ColorTheme.themeDarkGrayColor
                                : ColorTheme.themeGreenColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            minimumSize: Size(374, 56),
                          ),
                          onPressed: () {
                            print(
                                "selectedAddressType:${provider.selectedAddressType}");

                            if (_formKey.currentState!.validate()) {
                              if (provider.flatController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "The flat house no field is required!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (provider.areaController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "The area sector field is required.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (provider.selectedAddressType.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "The type field is required.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (provider.isAddressEdit == true) {
                                //  provider.setAddressDisableButton();
                                provider.getAddressEditApi(
                                    widget.id,
                                    provider.selectedAddressType,
                                    provider.flatController.text,
                                    provider.areaController.text,
                                    provider.nearByController.text,
                                    context);
                                // Timer(
                                //     const Duration(seconds: 1),
                                //     () => provider.subsAddressSelection ==
                                //             true
                                //         ? Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) =>
                                //                   SavedAddress(
                                //                 vehicleImagePath: widget
                                //                     .vehicleImagePath,
                                //                 vehicleBrandName: widget
                                //                     .vehicleBrandName,
                                //                 vehicleModelName: widget
                                //                     .vehicleModelName,
                                //                 vehicleTypeName: widget
                                //                     .vehicleTypeName,
                                //                 vehicleRegNo:
                                //                     widget.vehicleRegNo,
                                //                 vehicleId:
                                //                     widget.vehicleId,
                                //                 subscriptionId:
                                //                     widget.subscriptionId,
                                //                 subscriptionPrize: widget
                                //                     .subscriptionPrize,
                                //               ),
                                //             ),
                                //           )
                                //         : provider.reportNavFromMenu ==
                                //                 true
                                //             ? Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       SavedAddress(
                                //                     vehicleImagePath: widget
                                //                         .vehicleImagePath,
                                //                     vehicleBrandName: widget
                                //                         .vehicleBrandName,
                                //                     vehicleModelName: widget
                                //                         .vehicleModelName,
                                //                     vehicleTypeName: widget
                                //                         .vehicleTypeName,
                                //                     vehicleRegNo: widget
                                //                         .vehicleRegNo,
                                //                     vehicleId:
                                //                         widget.vehicleId,
                                //                     subscriptionId: widget
                                //                         .subscriptionId,
                                //                     subscriptionPrize: widget
                                //                         .subscriptionPrize,
                                //                   ),
                                //                 ),
                                //               )
                                //             : Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       Dashboard(),
                                //                 ),
                                //               ));
                              } else if (!provider.saveAddressClicked) {
                                // if (!provider.saveAddressClicked) {
                                // provider.setAddressDisableButton();
                                provider.saveAddressClicked = true;
                                provider.getAddressAddApi(
                                    provider.selectedAddressType,
                                    provider.flatController.text,
                                    provider.areaController.text,
                                    provider.nearByController.text,
                                    context);
                                // Timer(
                                //     const Duration(seconds: 1),
                                //     () => provider.subsAddressSelection ==
                                //             true
                                //         ? Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) =>
                                //                   SavedAddress(
                                //                 vehicleImagePath: widget
                                //                     .vehicleImagePath,
                                //                 vehicleBrandName: widget
                                //                     .vehicleBrandName,
                                //                 vehicleModelName: widget
                                //                     .vehicleModelName,
                                //                 vehicleTypeName: widget
                                //                     .vehicleTypeName,
                                //                 vehicleRegNo:
                                //                     widget.vehicleRegNo,
                                //                 vehicleId:
                                //                     widget.vehicleId,
                                //                 subscriptionId:
                                //                     widget.subscriptionId,
                                //                 subscriptionPrize: widget
                                //                     .subscriptionPrize,
                                //               ),
                                //             ),
                                //           )
                                //         : provider.reportNavFromMenu ==
                                //                 true
                                //             ? Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       SavedAddress(
                                //                     vehicleImagePath: widget
                                //                         .vehicleImagePath,
                                //                     vehicleBrandName: widget
                                //                         .vehicleBrandName,
                                //                     vehicleModelName: widget
                                //                         .vehicleModelName,
                                //                     vehicleTypeName: widget
                                //                         .vehicleTypeName,
                                //                     vehicleRegNo: widget
                                //                         .vehicleRegNo,
                                //                     vehicleId:
                                //                         widget.vehicleId,
                                //                     subscriptionId: widget
                                //                         .subscriptionId,
                                //                     subscriptionPrize: widget
                                //                         .subscriptionPrize,
                                //                   ),
                                //                 ),
                                //               )
                                //             : Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       Dashboard(),
                                //                 ),
                                //               ));
                                //  }

                                // }
                              }
                            }
                          },
                          child: const Text(
                            'Save address',
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

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String PLACES_API_KEY = AppString.google_map_api_key;

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }
}
