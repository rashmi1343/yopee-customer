import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:yopee_customer/View/Address/AddAddress.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';
import '../Address/StringConstants.dart';
import '../Payment/PaymentScreen.dart';

class ServiceAddress extends StatefulWidget {
  String vehicleImagePath;
  String vehicleBrandName;
  String vehicleModelName;
  String vehicleTypeName;
  String vehicleRegNo;
  String vehicleId;
  String serviceId;
  int price;

  ServiceAddress(
      {required this.vehicleImagePath,
      required this.vehicleBrandName,
      required this.vehicleModelName,
      required this.vehicleTypeName,
      required this.vehicleRegNo,
      required this.vehicleId,
      required this.serviceId,
      required this.price});

  ServiceAddressState createState() => ServiceAddressState();
}

class ServiceAddressState extends State<ServiceAddress> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      _onChanged();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
      provider.getAddressListApi(context);
    });
  }

  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    print("service id:${widget.serviceId}");
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return Scaffold(
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
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              title: Text(
                "Address",
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
                    provider.isSpecialRequest == true
                        ? Container(
                            height: 60,
                            width: 364,
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.only(left: 22, right: 22, top: 10),
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
                                Navigator.of(context).pushNamed('/addAddress');
                              },
                            ))
                        : Container(),
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
                            icon: SvgPicture.asset("assets/images/search.svg"),
                            onPressed: () async {},
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              _controller.clear();
                              // provider.areaController.clear();
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
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.objAddressListResponse.data.length,
                        itemBuilder: (context, index) {
                          var addressListItem =
                              provider.objAddressListResponse.data;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints:
                                    BoxConstraints(maxHeight: double.infinity),
                                margin: EdgeInsets.only(
                                    left: 20, top: 10, right: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xffFAFAFA),
                                    border: Border.all(
                                        color: ColorTheme.themeLightGrayColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          margin:
                                              EdgeInsets.only(left: 5, top: 30),
                                          child: InkWell(
                                            onTap: () {
                                              provider.toggleAddressSelection(
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
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff007BFF)),
                                                    child: Container(
                                                        height: 12.09,
                                                        width: 9,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: SvgPicture.asset(
                                                          "assets/images/check-solid.svg",
                                                          color: Colors.white,
                                                        )),
                                                  )
                                                : Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffC2C2C2),
                                                            width: 2)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container()),
                                                  ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 22,
                                              ),
                                              height: 20,
                                              width: 17.06,
                                              child: SvgPicture.asset(
                                                "assets/images/map-marker.svg",
                                              ),
                                            ),
                                            Container(
                                              width: 250,
                                              margin: EdgeInsets.only(
                                                  left: 12.94,
                                                  top: 5,
                                                  bottom: 8),
                                              child: Text(
                                                addressListItem[index]
                                                    .flatHouseNo
                                                    .toString(),
                                                softWrap: true,
                                                maxLines: 10,
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontFamily: "SemiBold",
                                                    color: Color(0xff242424)),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    addressListItem[index].nearby == "" ||
                                            addressListItem[index].nearby ==
                                                null
                                        ? Container(
                                            width: 250,
                                            margin: EdgeInsets.only(
                                              left: 77,
                                            ),
                                            child: Text(
                                              "${addressListItem[index].areaSector.toString()}",
                                              softWrap: true,
                                              maxLines: 10,
                                              style: TextStyle(
                                                  fontSize: 12.5,
                                                  fontFamily: "Medium",
                                                  color: Color(0xff6F6F6F)),
                                            ),
                                          )
                                        : Container(
                                            width: 250,
                                            margin: EdgeInsets.only(
                                              left: 77,
                                            ),
                                            child: Text(
                                              "${addressListItem[index].areaSector.toString()}, ${addressListItem[index].nearby.toString()}",
                                              softWrap: true,
                                              maxLines: 10,
                                              style: TextStyle(
                                                  fontSize: 12.5,
                                                  fontFamily: "Medium",
                                                  color: Color(0xff6F6F6F)),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 27),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffE3F1FF),
                          side:
                              BorderSide(width: 1.0, color: Color(0xff007BFF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          minimumSize: Size(374, 56),
                        ),
                        onPressed: () {
                          //  Navigator.of(context).pushNamed('/serviceAddress');
                        },
                        child: const Text(
                          'Use current location',
                          style: TextStyle(
                              color: ColorTheme.themeBlackColor,
                              fontSize: 16,
                              fontFamily: "SemiBold"),
                        ),
                      ),
                    ),
                    provider.isService == true
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentScreen(
                                        vehicleImagePath:
                                            widget.vehicleImagePath,
                                        vehicleBrandName:
                                            widget.vehicleBrandName,
                                        vehicleModelName:
                                            widget.vehicleModelName,
                                        vehicleTypeName: widget.vehicleTypeName,
                                        vehicleRegNo: widget.vehicleRegNo,
                                        vehicleId: widget.vehicleId,
                                        addressId: provider
                                            .objAddressListResponse
                                            .data[
                                                provider.selectedMyAddressIndex]
                                            .id
                                            .toString(),
                                        addrressType: provider
                                            .objAddressListResponse
                                            .data[
                                                provider.selectedMyAddressIndex]
                                            .type
                                            .toString(),
                                        flatHouseNo: provider
                                            .objAddressListResponse
                                            .data[provider.selectedMyAddressIndex]
                                            .flatHouseNo
                                            .toString(),
                                        area: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].areaSector.toString(),
                                        nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                        subscriptionId: widget.serviceId,
                                        subscriptionPrize: widget.price.toInt()),
                                  ),
                                );
                              },
                              child: const Text(
                                'Select Address',
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
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                    minimumSize: Size(374, 56),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentScreen(
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
                                            addrressType:
                                                provider.objAddressListResponse.data[provider.selectedMyAddressIndex].type
                                                    .toString(),
                                            flatHouseNo: provider
                                                .objAddressListResponse
                                                .data[provider
                                                    .selectedMyAddressIndex]
                                                .flatHouseNo
                                                .toString(),
                                            area: provider
                                                .objAddressListResponse
                                                .data[provider.selectedMyAddressIndex]
                                                .areaSector
                                                .toString(),
                                            nearBy: provider.objAddressListResponse.data[provider.selectedMyAddressIndex].nearby.toString(),
                                            subscriptionId: widget.serviceId,
                                            subscriptionPrize: widget.price),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Select Address',
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
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                    minimumSize: Size(374, 56),
                                  ),
                                  onPressed: () {
                                    provider.setIsService(true);
                                    Navigator.of(context)
                                        .pushNamed('/addAddress');
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
                  ],
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
