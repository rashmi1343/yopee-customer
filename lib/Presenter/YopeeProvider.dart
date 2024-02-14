import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yopee_customer/Entity/Response/Address/AddressAddResponse.dart';
import 'package:yopee_customer/Entity/Response/Address/AddressListResponse.dart';
import 'package:yopee_customer/Entity/Response/Profile/UploadPhotoResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/RenewSubsResponse.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleTypeResponse.dart';
import 'package:yopee_customer/Entity/UpcomingSubscriptionResponse.dart';
import 'package:yopee_customer/Interactor/ApiClient.dart';
import 'package:yopee_customer/Interactor/YopeeRepository.dart';
import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yopee_customer/Utility/Environment.dart';

import 'package:yopee_customer/View/GoogleMapScreen.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';
import 'package:yopee_customer/View/Menu/MoreMenu.dart';
import 'package:yopee_customer/View/Menu/MySubscription.dart';
import 'package:yopee_customer/View/Menu/Reports.dart';
import 'package:yopee_customer/View/Menu/SpecialRequestScreen.dart';
import 'package:yopee_customer/View/OTP/OtpVerification.dart';
import 'package:yopee_customer/View/RateWash.dart';
import 'package:yopee_customer/View/Splash/SplashScreen.dart';

import '../Entity/CheckUserVehicleResponse.dart';
import '../Entity/Response/AboutUsResponse.dart';
import '../Entity/Response/Address/AddressDeleteResponse.dart';
import '../Entity/Response/Address/AddressEditResponse.dart';
import '../Entity/Response/ContactUsResponse.dart';
import '../Entity/Response/DashboardResponse.dart';
import '../Entity/Response/Login/loginResponse.dart';
import '../Entity/Response/Login/LogoutResponse.dart';
import '../Entity/Response/Notification/DeleteNotificationResponse.dart';
import '../Entity/Response/Notification/NotificationStatusResponse.dart';
import '../Entity/Response/Notification/ReadNotificationResponse.dart';
import '../Entity/Response/Notification/UnreadNotificationResponse.dart';
import '../Entity/Response/Otp/ResendOtpResponse.dart';
import '../Entity/Response/Otp/otpResponse.dart';
import '../Entity/Response/Profile/ProfileUpdateResponse.dart';
import '../Entity/Response/Profile/ProfileViewResponse.dart';
import '../Entity/Response/RateWashResponse.dart';
import '../Entity/Response/ReportsListResponse.dart';
import '../Entity/Response/Services/ServiceDetailListResponse.dart';
import '../Entity/Response/Services/ServiceDetailsResponse.dart';
import '../Entity/Response/Services/ServicesResponse.dart';
import '../Entity/Response/SignupResponse.dart';
import '../Entity/Response/SpecialRequest/SpecialRequestAddResponse.dart';
import '../Entity/Response/SpecialRequest/SpecialRequestDeleteResponse.dart';
import '../Entity/Response/SpecialRequest/SpecialRequestListResponse.dart';
import '../Entity/Response/Subscription/BasicSubscriptionResponse.dart';
import '../Entity/Response/Subscription/SubscriptionDetailsResponse.dart';
import '../Entity/Response/Subscription/SubscriptionListResponse.dart';
import '../Entity/Response/Subscription/UserSubscriptionAddResponse.dart';
import '../Entity/Response/Subscription/UserSubscriptionListResponse.dart';
import '../Entity/Response/Vehicle/CarBrandResponse.dart';
import '../Entity/Response/Vehicle/CarModelResponse.dart';
import '../Entity/Response/Vehicle/VehicleAddResponse.dart';
import '../Entity/Response/Vehicle/VehicleDeleteResponse.dart';
import '../Entity/Response/Vehicle/VehicleEditResponse.dart';
import '../Entity/Response/Vehicle/VehicleListResponse.dart';
import '../Router/Routes.dart';
import '../View/Address/AddAddress.dart';
import '../View/Login/Login.dart';
import '../View/PlaceApiProvider.dart';
import '../View/VehicleList.dart';

class YopeeProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isSuccess = false;
  bool isError = false;
  final yopeeRepo = YopeeRepository();

  late BuildContext _providerContext;

  BuildContext get providerContext => _providerContext;

  void setProviderContext(BuildContext context) {
    _providerContext = context;
    notifyListeners();
  }

  int index = 0;
  bool isProfileEdit = false;
  bool otpRequestAgain = false;
  TextEditingController _profileNameController = TextEditingController();
  TextEditingController _profileEmailAddressController =
      TextEditingController();
  TextEditingController _profilePhoneNumberController = TextEditingController();

  TextEditingController get profileNameController => _profileNameController;

  TextEditingController get profileEmailAddressController =>
      _profileEmailAddressController;

  TextEditingController get profilePhoneNumberController =>
      _profilePhoneNumberController;

  String? currentAddress;
  String location = "";
  Position? currentPosition;

  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      notifyListeners();
      getAddressFromLatLng(currentPosition!, context);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  var cityName = "";
  Placemark? place;
  List<Placemark> placemarks = [];

  Future<void> getAddressFromLatLng(
      Position position, BuildContext context) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      place = placemarks[0];

      currentAddress = place!.street.toString() +
          ", " +
          place!.locality.toString() +
          ", " +
          place!.subLocality.toString() +
          ", " +
          place!.administrativeArea.toString() +
          ", " +
          place!.postalCode.toString();

      cityName = place!.subAdministrativeArea.toString();
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  bool _changeLocation = false;

  bool get changeLocation => _changeLocation;

  List<Placemark> changedLocation = [];

  void setChangeLocation(
      bool value, String location, List<Placemark> placemarks) {
    _changeLocation = value;
    changedLocation = placemarks;
    notifyListeners();
  }

  Future showAddressDialog(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 285,
            width: 374,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 18),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // height: 60,
                      width: 364,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 22, right: 22, top: 10),
                      //decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Text(
                            "Current Location",
                            style: TextStyle(
                                fontFamily: "SemiBold",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 1000),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      GoogleMapScreen(
                                        lat: currentPosition!.latitude,
                                        long: currentPosition!.longitude,
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
                                        // begin: const Offset(1.0, 0.0),
                                        // end: Offset.zero,

                                        //top to bottom
                                        // begin: const Offset(0.0, -1.0),
                                        // end: Offset.zero,

                                        //bottom to top
                                        begin: Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  }));
                            },
                            child: Text(
                              "Change",
                              style: TextStyle(
                                  fontFamily: "SemiBold",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                    decoration: BoxDecoration(
                        color: Color(0xffFAFAFA),
                        border: Border.all(
                            color: ColorTheme.themeLightGrayColor, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    height: 100,
                    child: Row(
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
                          constraints: BoxConstraints(
                              maxHeight: double.infinity, maxWidth: 200),
                          margin:
                              EdgeInsets.only(left: 12.94, top: 5, bottom: 8),
                          child: Text(
                            changeLocation == true
                                ? location
                                : currentAddress.toString(),
                            softWrap: true,
                            maxLines: null,
                            style: TextStyle(
                                fontSize: 13.5,
                                fontFamily: "SemiBold",
                                color: Color(0xff242424)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 21, right: 20, bottom: 10, top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.themeGreenColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        minimumSize: Size(374, 56),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/addAddress');
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
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE3F1FF),
                        side: BorderSide(width: 1.0, color: Color(0xff007BFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        minimumSize: Size(374, 56),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        changeLocation == true
                            ? getAddressAddApi(
                                "Other",
                                changedLocation.first.street.toString(),
                                changedLocation.first.locality.toString(),
                                changedLocation.first.subLocality.toString(),
                                context)
                            : getAddressAddApi(
                                "Other",
                                place!.street.toString(),
                                place!.locality.toString(),
                                place!.subLocality.toString(),
                                context);

                        // getCurrentPosition(context);
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
                ],
              ),
            ),
          );
        });
  }

  Future<void> navigateToLogin(BuildContext context) async {
    Navigator.of(context).push(loginscaleIn(Login(
      mobile: '',
    )));
    notifyListeners();
  }

  Route loginscaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      // transitionsBuilder: (BuildContext context, Animation<double> animation,
      //     Animation<double> secondaryAnimation, Widget child) {
      //   return new SlideTransition(
      //     position: new Tween<Offset>(
      //       //Left to right
      //       // begin: const Offset(-1.0, 0.0),
      //       // end: Offset.zero,
      //
      //       //Right to left
      //       begin: const Offset(1.0, 0.0),
      //       end: Offset.zero,
      //
      //       //top to bottom
      //       // begin: const Offset(0.0, -1.0),
      //       // end: Offset.zero,
      //
      //       //bottom to top
      //       // begin: Offset(0.0, 1.0),
      //       // end: Offset.zero,
      //     ).animate(animation),
      //     child: child,
      //   );
      // }
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  Future<void> navigateToOtp(BuildContext context) async {
    //  Navigator.of(context).pushNamed(Routes.otp);
    Navigator.of(context).push(scaleIn(OtpVerification()));
    notifyListeners();
  }

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => page,
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

              //bottom to top
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
        );
  }

  Future<void> navigateToDashboard(BuildContext context) async {
    // Navigator.of(context).pushNamed(Routes.dashboard).then((value) => null);

    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
      // transitionsBuilder: (BuildContext context, Animation<double> animation,
      //     Animation<double> secondaryAnimation, Widget child) {
      //   return new SlideTransition(
      //     position: new Tween<Offset>(
      //       //Left to right
      //       // begin: const Offset(-1.0, 0.0),
      //       // end: Offset.zero,
      //
      //       //Right to left
      //       begin: const Offset(1.0, 0.0),
      //       end: Offset.zero,
      //
      //       //top to bottom
      //       // begin: const Offset(0.0, -1.0),
      //       // end: Offset.zero,
      //
      //       //bottom to top
      //       // begin: Offset(0.0, 1.0),
      //       // end: Offset.zero,
      //     ).animate(animation),
      //     child: child,
      //   );
      // }
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: page,
        );
      },
    ));
    notifyListeners();
  }

  Future<void> navigateToSavedAddress(BuildContext context) async {
    Navigator.of(context).pushNamed(Routes.savedAddress);
    notifyListeners();
  }

  String _RegistrationNumber = "";

  String get RegistrationNumber => _RegistrationNumber;

  void setRegNumber(String value) {
    _RegistrationNumber = value;
    notifyListeners();
  }

  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  bool? _subsSelected = false;

  bool? get subsSelected => _subsSelected;

  String _timeDuration = "";
  String get timeDuration => _timeDuration;

  void setSelectedIndex(
    int indexValue,
    String formattedTime,
  ) {
    _selectedIndex = indexValue;
    //  _subsSelected = subsSelected;
    objBasicSubscriptionListResponse.data[indexValue].isPackageSelected =
        !objBasicSubscriptionListResponse.data![indexValue].isPackageSelected;

    _timeDuration = formattedTime;

    notifyListeners();
  }

  List<int> _selectedManageVehicle = [];

  List<int> get selectedManageVehicle => _selectedManageVehicle;

  void setSelectedManageVehicle(List<int> indexValue) {
    _selectedManageVehicle.addAll(indexValue);
    // for (int i = 0; i < objVehicleListResponse.data!.userVehicles.length; i++) {
    //   if (objVehicleListResponse.data!.userVehicles[i].id == selectedItem.id) {
    //     objVehicleListResponse.data!.userVehicles[i].selectedVehicle = true;
    //     break; // break the loop no need to continue
    //   }
    // }
    notifyListeners();
  }

  int _selectedImageIndex = 0;

  int get selectedImageIndex => _selectedImageIndex;

  void setSelectedImageIndex(int imageIndexValue) {
    _selectedImageIndex = imageIndexValue;
    notifyListeners();
  }

  bool _selectedSubsPkg = false;

  bool get selectedSubsPkg => _selectedSubsPkg;

  void setSelectedSubsPackage(bool package) {
    _selectedSubsPkg = package;
    notifyListeners();
  }

  bool _subscriptionSpecialvalue = true;

  bool get subscriptionSpecialvalue => _subscriptionSpecialvalue;

  void setsubscriptionSpecialvalue() {
    _subscriptionSpecialvalue = !_subscriptionSpecialvalue;
    notifyListeners();
  }

  bool subscriptionSilvervalue = false;
  bool subscriptionGoldvalue = false;
  TextEditingController _otp1Controller = TextEditingController();
  TextEditingController _otp2Controller = TextEditingController();
  TextEditingController _otp3Controller = TextEditingController();
  TextEditingController _otp4Controller = TextEditingController();

  TextEditingController get otp1Controller => _otp1Controller;

  TextEditingController get otp2Controller => _otp2Controller;

  TextEditingController get otp3Controller => _otp3Controller;

  TextEditingController get otp4Controller => _otp4Controller;

  TextEditingController _flatController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _nearByController = TextEditingController();

  TextEditingController get flatController => _flatController;

  TextEditingController get areaController => _areaController;

  TextEditingController get nearByController => _nearByController;

  void clearAllAddressText() {
    flatController.clear();
    areaController.clear();
    nearByController.clear();
  }

  String _selectedAddressType = "";

  String get selectedAddressType => _selectedAddressType;

  void setSelectedAddressTypeText(String selectedAddressTypeText) {
    _selectedAddressType = selectedAddressTypeText;
    notifyListeners();
  }

  bool _homeButtonEnabled = false;

  bool get homeButtonEnabled => _homeButtonEnabled;
  bool _workButtonEnabled = false;

  bool get workButtonEnabled => _workButtonEnabled;
  bool _otherButtonEnabled = false;

  bool get otherButtonEnabled => _otherButtonEnabled;

  // void setHomeButton(bool value) {
  //   _selectedAddressType = "Home";
  //   _homeButtonEnabled = value;
  //   _workButtonEnabled = false;
  //   _otherButtonEnabled = false;
  //   notifyListeners();
  // }
  //
  // void setWorkButton(bool value) {
  //   _selectedAddressType = "Work";
  //   _homeButtonEnabled = false;
  //   _workButtonEnabled = value;
  //   _otherButtonEnabled = false;
  //   notifyListeners();
  // }
  //
  // void setOtherButton(bool value) {
  //   _selectedAddressType = "Other";
  //   _homeButtonEnabled = false;
  //   _workButtonEnabled = false;
  //   _otherButtonEnabled = value;
  //   notifyListeners();
  // }

  String _addressTypeName = "";

  String get addressTypeName => _addressTypeName;

  void selectSaveAddressName(String buttonName) {
    _addressTypeName = buttonName;
    notifyListeners();
  }

  bool isAddressEdit = false;

  bool vehicleSaved = false;
  bool vehicleCount = false;

  int currentValue = 0;
  bool pushNotify = false;
  bool notifyMonthlyPayment = false;
  bool reportNavFromMenu = false;
  String email = "";
  String pwd = "";

  void signIn(String emailTxt, String pwdTxt) {
    email = emailTxt;
    pwd = pwdTxt;
    notifyListeners();
  }

  TextEditingController _loginPhoneNumberController = TextEditingController();

  TextEditingController get loginPhoneNumberController =>
      _loginPhoneNumberController;

  String someValue = '';

  updateLoginPhoneNumber(String newValue) {
    someValue = newValue;
    notifyListeners();
  }

  TextEditingController _RegNoOneEditController = TextEditingController();
  TextEditingController _RegNoTwoEditController = TextEditingController();
  TextEditingController _RegNoThreeEditController = TextEditingController();
  TextEditingController _RegNoFourEditController = TextEditingController();

  TextEditingController get RegNoOneEditController => _RegNoOneEditController;

  TextEditingController get RegNoTwoEditController => _RegNoTwoEditController;

  TextEditingController get RegNoThreeEditController =>
      _RegNoThreeEditController;

  TextEditingController get RegNoFourEditController => _RegNoFourEditController;

  TextEditingController _RegNoOneController = TextEditingController();

  TextEditingController get RegNoOneController => _RegNoOneController;
  TextEditingController _RegNoTwoController = TextEditingController();

  TextEditingController get RegNoTwoController => _RegNoTwoController;
  TextEditingController _RegNoThreeController = TextEditingController();

  TextEditingController get RegNoThreeController => _RegNoThreeController;
  TextEditingController _RegNoFourController = TextEditingController();

  TextEditingController get RegNoFourController => _RegNoFourController;

  bool loginClicked = false;
  bool otpClicked = false;
  Color _otpButtonColor = ColorTheme.themeLightGrayColor;

  Color get otpButtonColor => _otpButtonColor;

  // bool get otpClicked => _otpClicked;
  // void disableOtpButton() {
  //   _otpClicked = true;
  //   _otpButtonColor = ColorTheme.themeGreenColor;
  //   notifyListeners();
  // }
  //
  // void enableOtpButton() {
  //   _otpClicked = false;
  //   notifyListeners();
  // }
  bool? _valueBHChecked = false;

  bool? get valueBHChecked => _valueBHChecked;

  void setBHChecked(bool? value) {
    _valueBHChecked = value;
    notifyListeners();
  }

// loginApi
  LoginResponse _objLoginResponse = LoginResponse(data: []);

  LoginResponse get objLoginResponse => _objLoginResponse;

  Future<LoginResponse> getLoginApi(String mobile, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final loginResponse = await yopeeRepo.loginRepo(mobile);
      _objLoginResponse = loginResponse;
      if (_objLoginResponse.status == 200) {
        //   if (_objLoginResponse.data is Map<String, dynamic>) {
        isLoading = false;
        isSuccess = true;
        isError = true;
        notifyListeners();

        if (_objLoginResponse.data.isEmpty) {
          // Fluttertoast.showToast(
          //     msg: "${_objLoginResponse.message}",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          // contactToAdministrator(
          //   context,
          // );
          loginClicked = false;
        } else {
          Fluttertoast.showToast(
              msg: "${_objLoginResponse.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          loginPhoneNumberController.clear();
          loginClicked = false;

          if (_objLoginResponse.data.isNotEmpty) {
            navigateToOtp(context);
          }
        }

        print("login api Called Successfully");
        // } else if (_objLoginResponse.data is List<dynamic>) {
        //   isLoading = false;
        //   isSuccess = true;
        //   isError = true;
        //
        //   notifyListeners();
        //
        //   print("login api error");
        //   Fluttertoast.showToast(
        //       msg: "${_objLoginResponse.message}",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        //   loginClicked = false;
        // }
      } else if (_objLoginResponse.status == 422) {
        Fluttertoast.showToast(
            msg: "${_objLoginResponse.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffF3CBCB),
            textColor: Colors.red,
            fontSize: 16.0);
      } else if (_objLoginResponse.status == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again.!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffF3CBCB),
            textColor: Colors.red,
            fontSize: 16.0);
      } else {
        isLoading = false;
        isError = false;
        loginClicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      loginClicked = false;
      notifyListeners();
      Fluttertoast.showToast(
          msg: "Network is unreachable!!\nPlease check your internet!.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffF3CBCB),
          textColor: Colors.red,
          fontSize: 16.0);

      print("Exception:$e");
    }
    return _objLoginResponse;
  }

  bool logoutClicked = false;

  // bool get logoutClicked => _logoutClicked;

  // void setlogoutClickedEnableButton() {
  //   _logoutClicked = true;
  //   notifyListeners();
  // }

  // void setlogoutClickedDisableButton() {
  //   _logoutClicked = true;
  //   notifyListeners();
  // }

  //Logout

  LogoutResponse _objLogoutResponse = LogoutResponse(data: []);

  LogoutResponse get objLogoutResponse => _objLogoutResponse;

  Future<LogoutResponse> getLogoutApi(
      String mobile, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      //  notifyListeners();
      final logoutResponse = await yopeeRepo.logoutRepo(mobile);
      _objLogoutResponse = logoutResponse;
      if (_objLogoutResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Logout successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);
        logoutClicked = false;
        Timer(
            const Duration(seconds: 0),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Login(
                          mobile: '',
                        ))));

        print("logout api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        logoutClicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      logoutClicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return _objLogoutResponse;
  }

  // Otp Verify
  OtpResponse _objOtpResponse = OtpResponse();

  OtpResponse get objOtpResponse => _objOtpResponse;

  Future<OtpResponse> getOtpApi(
      String userId, String otpNumber, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final otpResponse = await yopeeRepo.otpRepo(userId, otpNumber);
      _objOtpResponse = otpResponse;
      if (_objOtpResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        // Fluttertoast.showToast(
        //     msg: "You have logged in successfully with OTP.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: ColorTheme.themeGreenColor,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        otpClicked = false;
        otp1Controller.clear();
        otp2Controller.clear();
        otp3Controller.clear();
        otp4Controller.clear();

        navigateToDashboard(context);

        print("otp api Called Successfully");
      } else if (_objOtpResponse.status == 500) {
        Fluttertoast.showToast(
            msg: "OTP is invalid.\nPlease try again with correct OTP",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // enableOtpButton();
        //  notifyListeners();
        otpClicked = false;
        // isLoading = false;
        // isError = false;
        notifyListeners();
      } else {
        isLoading = false;
        isError = false;
        otpClicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      otpClicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return _objOtpResponse;
  }

  //Address List
  AddressListResponse _objAddressListResponse =
      AddressListResponse(message: "", status: 0, data: []);

  AddressListResponse get objAddressListResponse => _objAddressListResponse;

  Future<AddressListResponse> getAddressListApi(BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final addressListResponse = await yopeeRepo.addressListRepo(context);
      _objAddressListResponse = addressListResponse;
      if (_objAddressListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("address list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objAddressListResponse;
  }

  bool saveAddressClicked = false;

  // bool get saveAddressClicked => _saveAddressClicked;
  //
  // void setAddressEnableButton() {
  //   _saveAddressClicked = true;
  //   notifyListeners();
  // }
  //
  // void setAddressDisableButton() {
  //   _saveAddressClicked = false;
  //   notifyListeners();
  // }

  //Address Add
  AddressAddResponse _objAddressAddResponse = AddressAddResponse();

  AddressAddResponse get objAddressAddResponse => _objAddressAddResponse;

  Future<AddressAddResponse> getAddressAddApi(String type, String flatHouseNo,
      String areaSector, String nearBy, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      //  notifyListeners();
      final addressAddResponse = await yopeeRepo.addressAddRepo(
          type, flatHouseNo, areaSector, nearBy, context);
      _objAddressAddResponse = addressAddResponse;
      if (_objAddressAddResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        Fluttertoast.showToast(
            msg: "Address has been created successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);
        saveAddressClicked = false;

        print("address Add api Called Successfully");

        Timer(
            const Duration(seconds: 2),
            () => Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Dashboard(),
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
                  //       begin: const Offset(1.0, 0.0),
                  //       end: Offset.zero,
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
                )));
      } else {
        isLoading = false;
        isError = false;
        saveAddressClicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      saveAddressClicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return _objAddressAddResponse;
  }

  //Address Edit
  AddressEditResponse _objAddressEditResponse = AddressEditResponse();

  AddressEditResponse get objAddressEditResponse => _objAddressEditResponse;

  Future<AddressEditResponse> getAddressEditApi(
      String id,
      String type,
      String flatHouseNo,
      String areaSector,
      String nearBy,
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final addressEditResponse = await yopeeRepo.addressEditRepo(
          id, type, flatHouseNo, areaSector, nearBy, context);
      _objAddressEditResponse = addressEditResponse;
      if (_objAddressEditResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        Fluttertoast.showToast(
            msg: "Address has been updated successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     '/savedAddress', (Route<dynamic> route) => false);

        print("address edit api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objAddressEditResponse;
  }

  //Address Delete

  AddressDeleteResponse _objAddressDeleteResponse = AddressDeleteResponse();

  AddressDeleteResponse get objAddressDeleteResponse =>
      _objAddressDeleteResponse;

  Future<AddressDeleteResponse> getAddressDeleteApi(
      String id, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final addressDeleteResponse =
          await yopeeRepo.addressDeleteRepo(id, context);
      _objAddressDeleteResponse = addressDeleteResponse;
      if (_objAddressDeleteResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        Fluttertoast.showToast(
            msg: "Address has been deleted successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        getAddressListApi(context);

        print("address delete api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objAddressDeleteResponse;
  }

  bool isVehicleEdit = false;

  bool isChecked = false;
  int selectedMyVehicleIndex = -1;

  List<bool> _isVehicleSelected = [];

  List<bool> get isVehicleSelected => _isVehicleSelected;

  void toggleMyVehicleSelected(
    int index,
  ) {
    selectedMyVehicleIndex = index;

    objVehicleListResponse.data!.userVehicles![index].selectedVehicle =
        !objVehicleListResponse.data!.userVehicles![index].selectedVehicle;

    notifyListeners(); // To rebuild the Widget
  }

  int selectedMyAddressIndex = -1; // to know active index

  void toggleAddressSelection(int index) {
    selectedMyAddressIndex = index;
    objAddressListResponse.data[index].isAddressSelected =
        !objAddressListResponse.data[index].isAddressSelected;
    notifyListeners();
  }

  // void toggleManageVehicleSelected(
  //   int index,
  // ) {
  //   // selectedMyVehicleIndex = index;
  //   objVehicleListResponse.data!.userVehicles![index].manageVehicle =
  //       !objVehicleListResponse.data!.userVehicles![index].manageVehicle;
  //
  //   notifyListeners(); // To rebuild the Widget
  // }

  //Vehicle List
  VehicleListResponse _objVehicleListResponse = VehicleListResponse(
      //  data: VehicleListItem(totalUserVehicle: 0, userVehicles: []));
      data: VehicleListData(totalUserVehicle: 0, userVehicles: []),
      message: '',
      status: 0);

  VehicleListResponse get objVehicleListResponse => _objVehicleListResponse;

  Future<VehicleListResponse> getVehicleListApi(BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final vehicleListResponse = await yopeeRepo.vehicleListRepo(context);
      _objVehicleListResponse = vehicleListResponse;
      if (_objVehicleListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("vehicle list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objVehicleListResponse;
  }

  //Vehicle Add
  VehicleAddResponse _objAddVehicleResponse = VehicleAddResponse(
      message: '',
      status: 0,
      data: VehicleAddData(
          userId: 0,
          vehicleTypeId: '',
          carBrandId: '',
          carModelId: '',
          registrationNo: '',
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
          id: 0));

  VehicleAddResponse get objVehicleAddResponse => _objAddVehicleResponse;

  Future<VehicleAddResponse> getVehicleAddApi(
      String vehicleTypeId,
      String carBrandId,
      String carModelId,
      String registrationNo,
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final vehicleAddResponse = await yopeeRepo.vehicleAddRepo(
          vehicleTypeId, carBrandId, carModelId, registrationNo, context);
      _objAddVehicleResponse = vehicleAddResponse;
      if (_objAddVehicleResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        Fluttertoast.showToast(
            msg: "Vehicle has been created successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        selectedVehicleIndex = -1;
        selectedCarModelIndex = -1;
        selectedCarBrandIndex = -1;
        isCarModelSelected = false;
        isCarBrandSelected = false;

        RegNoOneEditController.clear();
        RegNoTwoEditController.clear();
        RegNoThreeEditController.clear();
        RegNoFourEditController.clear();

        // vehicleCount = true;

        Timer(
            const Duration(seconds: 2),
            () => subsVehicleSelection == true
                ? Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        VehicleList(
                          id: objSubsDetailsResponse.data.id.toString(),
                          price: objSubsDetailsResponse.data.price,
                          vehicleImagePath: '',
                          vehicleBrandName: '',
                          vehicleModelName: '',
                          vehicleTypeName: '',
                          vehicleRegNo: '',
                          vehicleId: '',
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
                    ))
                // Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => VehicleList(
                //                   id: objSubsDetailsResponse.data.id.toString(),
                //                   price:
                //                       objSubsDetailsResponse.data.price.toString(),
                //                   vehicleImagePath: '',
                //                   vehicleBrandName: '',
                //                   vehicleModelName: '',
                //                   vehicleTypeName: '',
                //                   vehicleRegNo: '',
                //                   vehicleId: '',
                //                 )))
                // : isService == true
                //     ? Navigator.of(context).push(PageRouteBuilder(
                //         transitionDuration: const Duration(milliseconds: 400),
                //         pageBuilder: (context, animation, secondaryAnimation) =>
                //             VehicleList(
                //               id: objSubsDetailsResponse.data.id.toString(),
                //               price:
                //                   objSubsDetailsResponse.data.price.toString(),
                //               vehicleImagePath: '',
                //               vehicleBrandName: '',
                //               vehicleModelName: '',
                //               vehicleTypeName: '',
                //               vehicleRegNo: '',
                //               vehicleId: '',
                //               serviceId: '',
                //             ),
                //         transitionsBuilder: (BuildContext context,
                //             Animation<double> animation,
                //             Animation<double> secondaryAnimation,
                //             Widget child) {
                //           return new SlideTransition(
                //             position: new Tween<Offset>(
                //               //Left to right
                //               begin: const Offset(-1.0, 0.0),
                //               end: Offset.zero,
                //
                //               //Right to left
                //               // begin: const Offset(1.0, 0.0),
                //               // end: Offset.zero,
                //
                //               //top to bottom
                //               // begin: const Offset(0.0, -1.0),
                //               // end: Offset.zero,
                //
                //               //   bottom to top
                //               // begin: Offset(0.0, 1.0),
                //               // end: Offset.zero,
                //             ).animate(animation),
                //             child: child,
                //           );
                //         }
                //         // transitionsBuilder:
                //         //     (context, animation, secondaryAnimation, page) {
                //         //   var begin = 0.0;
                //         //   var end = 1.0;
                //         //   var curve = Curves.ease;
                //         //
                //         //   var tween = Tween(begin: begin, end: end)
                //         //       .chain(CurveTween(curve: curve));
                //         //   return ScaleTransition(
                //         //     scale: animation.drive(tween),
                //         //     child: page,
                //         //   );
                //         // },
                //         ))
                : Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Dashboard(),
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
                    //       begin: const Offset(1.0, 0.0),
                    //       end: Offset.zero,
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
                  )));

        // Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => Dashboard())));

        print("vehicle Add api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objAddVehicleResponse;
  }

  //Service Price List
  ServiceDetailListResponse _objServicePriceResponse =
      ServiceDetailListResponse(data: [], message: '', status: 200);

  ServiceDetailListResponse get objServicePriceResponse =>
      _objServicePriceResponse;

  List<ServiceDetailListData> servicePriceList = [];

  int priceindex = 0;

  Future<ServiceDetailListResponse> getServicePriceApi(
      String carModelId, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      //  notifyListeners();
      final servicePriceResponse =
          await yopeeRepo.servicePriceListRepo(carModelId, context);
      _objServicePriceResponse = servicePriceResponse;
      if (_objServicePriceResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;
        servicePriceList = _objServicePriceResponse.data;
        if (priceindex >= 0 && priceindex < servicePriceList.length) {
          print("selectedIndex=${servicePriceList[priceindex]}");
        } else {
          print("Invalid Index");
        }

        notifyListeners();

        print("service price api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objServicePriceResponse;
  }

  bool _isServiceInactiveStatus = false;

  bool get isServiceInactiveStatus => _isServiceInactiveStatus;

  void isServiceInactive(String serviceName) {
    _isServiceInactiveStatus = servicePriceList.any((service) =>
        service.name == serviceName && service.status == "inactive");

    notifyListeners();
  }

  bool _isSubscriptionInactiveStatus = false;

  bool get isSubscriptionInactiveStatus => _isSubscriptionInactiveStatus;

  void isSubscriptionInactive(String subscriptionName) {
    _isSubscriptionInactiveStatus = subscriptionPriceList.any((subscription) =>
        subscription.name == subscriptionName &&
        subscription.status == "inactive");

    notifyListeners();
  }

  //Address Edit
  VehicleEditResponse _objEditVehicleResponse = VehicleEditResponse(
      message: '',
      status: 0,
      data: VehicleEditData(
          userId: 0,
          vehicleTypeId: '',
          carBrandId: '',
          carModelId: '',
          registrationNo: '',
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
          id: 0));

  VehicleEditResponse get objEditVehicleResponse => _objEditVehicleResponse;

  Future<VehicleEditResponse> getVehicleEditApi(
      String id,
      String userId,
      String vehicleTypeId,
      String carBrandId,
      String carModelId,
      String registrationNo,
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final vehicleEditResponse = await yopeeRepo.vehicleEditRepo(id, userId,
          vehicleTypeId, carBrandId, carModelId, registrationNo, context);
      _objEditVehicleResponse = vehicleEditResponse;
      if (_objEditVehicleResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        Fluttertoast.showToast(
            msg: "Vehicle has been updated successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        // navigateToSavedAddress(context);
        Timer(
            const Duration(seconds: 2),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard())));

        print("vehicle edit api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objEditVehicleResponse;
  }

  //Vehicle Delete

  VehicleDeleteResponse _objVehicleDeleteResponse = VehicleDeleteResponse(
      message: '',
      status: 0,
      data: VehicleDeleteData(
          id: 0,
          userId: 0,
          vehicleTypeId: 0,
          carBrandId: 0,
          carModelId: 0,
          registrationNo: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()));

  VehicleDeleteResponse get objVehicleDeleteResponse =>
      _objVehicleDeleteResponse;

  Future<VehicleDeleteResponse> getVehicleDeleteApi(
      String id, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final vehicleDeleteResponse =
          await yopeeRepo.vehicleDeleteRepo(id, context);
      _objVehicleDeleteResponse = vehicleDeleteResponse;
      if (_objVehicleDeleteResponse.status == 200) {
        if (_objVehicleDeleteResponse.data is Map<String, dynamic> &&
            _objVehicleDeleteResponse.data.isNotEmpty) {
          isLoading = false;
          isSuccess = true;
          isError = true;

          notifyListeners();

          Fluttertoast.showToast(
              msg: "${_objVehicleDeleteResponse.data}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorTheme.themeGreenColor,
              textColor: Colors.white,
              fontSize: 16.0);

          getVehicleListApi(context);

          print("vehicle delete api Called Successfully");
        } else if (_objVehicleDeleteResponse.data is List<dynamic> &&
            _objVehicleDeleteResponse.data.isEmpty) {
          isLoading = false;
          isSuccess = true;
          isError = true;

          notifyListeners();
          Fluttertoast.showToast(
              msg: "${_objVehicleDeleteResponse.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objVehicleDeleteResponse;
  }

  //Subscription Details

  SubscriptionDetailsResponse _objSubsDetailsResponse =
      SubscriptionDetailsResponse(
          message: '',
          status: 0,
          data: SubDetailsData(
              id: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              name: '',
              price: 0,
              duration: '',
              status: '',
              subscriptionDetails: [],
              image: '',
              media: []));

  SubscriptionDetailsResponse get objSubsDetailsResponse =>
      _objSubsDetailsResponse;

  Future<SubscriptionDetailsResponse> getSubsDetailsApi(
      String id, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final subsDetailsResponse = await yopeeRepo.subsDetailsRepo(id, context);
      _objSubsDetailsResponse = subsDetailsResponse;
      if (_objSubsDetailsResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        // Fluttertoast.showToast(
        //     msg: "Records retrieved successfully.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: ColorTheme.themeGreenColor,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        //  getAddressListApi(context);

        print("Subscription details api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objSubsDetailsResponse;
  }

  //Subscription List
  SubscriptionListResponse _objSubscriptionListResponse =
      SubscriptionListResponse(message: "", status: 0, data: []);

  SubscriptionListResponse get objSubscriptionListResponse =>
      _objSubscriptionListResponse;

  List<SubsListData> subscriptionPriceList = [];

  Future<SubscriptionListResponse> getSubscriptionListApi(
      String carModelId, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final subsListResponse =
          await yopeeRepo.subscriptionListRepo(carModelId, context);
      _objSubscriptionListResponse = subsListResponse;
      if (_objSubscriptionListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        subscriptionPriceList = _objSubscriptionListResponse.data;

        notifyListeners();

        print("subscription list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objSubscriptionListResponse;
  }

  //Basic Subscription List
  BasicSubscriptionResponse _objBasicSubscriptionListResponse =
      BasicSubscriptionResponse(message: "", status: 0, data: []);

  BasicSubscriptionResponse get objBasicSubscriptionListResponse =>
      _objBasicSubscriptionListResponse;

  Future<BasicSubscriptionResponse> getBasicSubscriptionListApi(
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final basicsubsListResponse =
          await yopeeRepo.baiscsubscriptionListRepo(context);
      _objBasicSubscriptionListResponse = basicsubsListResponse;
      if (_objBasicSubscriptionListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("basic subscription list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objBasicSubscriptionListResponse;
  }

  List<VehicleTypeData> _vehicleTypeList = [];

  void setVehicleTypeData(List<VehicleTypeData> vehicleTypes) {
    _vehicleTypeList = vehicleTypes;
    notifyListeners();
  }

  String vehicleTypeName = "";

  int getVehicleTypeNameByID(int id) {
    final vehicleTypeName = _vehicleTypeList.firstWhere(
        (element) => element.id == id,
        orElse: () =>
            VehicleTypeData(id: 0, name: "Unknown", image: '', media: []));

    print("vehicleTypeName:${vehicleTypeName.id}");
    return vehicleTypeName.id;
  }

  int selectedVehicleIndex = -1; // to know active index
  int carVehicleTypeId = 0;

  void toggleVehicleTypeSelected(int index) {
    isVehicleTypeSelected = true;
    selectedVehicleIndex = index;
    carVehicleTypeId = vehicleTypeDataArr[selectedVehicleIndex].id;
    print("carVehicleTypeId:$carVehicleTypeId");
    print(
        "carVehicleTypeName:${vehicleTypeDataArr[selectedVehicleIndex].name}");
    notifyListeners(); // To rebuild the Widget
  }

  Color _vehicleTypeColor = Color(0xffCCCCCC);

  Color get vehicleTypeColor => _vehicleTypeColor;

  void setVehicleTypeColor(Color color, int index) {
    _vehicleTypeColor = color;
    notifyListeners();
  }

  //Vehicle Type List
  VehicleTypeResponse _objVehicleTypeListResponse =
      VehicleTypeResponse(message: "", status: 0, data: []);

  VehicleTypeResponse get objVehicleTypeListResponse =>
      _objVehicleTypeListResponse;

  List<VehicleTypeData> vehicleTypeList = [];

  Future<VehicleTypeResponse> getVehicleTypeListApi(
      String modelId, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final vehicleTypeListResponse =
          await yopeeRepo.vehicleTypeListRepo(modelId, context);
      _objVehicleTypeListResponse = vehicleTypeListResponse;
      if (_objVehicleTypeListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        vehicleTypeList = _objVehicleTypeListResponse.data;

        print("vehicle type list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objVehicleTypeListResponse;
  }

  int selectedCarBrandIndex = -1; // to know active index
  String _carBrandName = "";

  String get carBrandName => _carBrandName;
  int carBrandId = 0;

  void toggleCarBrandSelected(int index, value) {
    isCarBrandSelected = true;
    _carBrandName = value;
    selectedCarBrandIndex = index;
    // carBrandId = objCarBrandListResponse.data[selectedCarBrandIndex].id;
    carBrandId = carBrandDataArr[selectedCarBrandIndex].id;
    print(" carBrandId:$carBrandId");

    notifyListeners(); // To rebuild the Widget
  }

  //Car Brand List
  CarBrandResponse _objCarBrandListResponse =
      CarBrandResponse(message: "", status: 0, data: []);

  CarBrandResponse get objCarBrandListResponse => _objCarBrandListResponse;

  Future<CarBrandResponse> getCarBrandListApi(BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final carBrandListResponse = await yopeeRepo.carBrandListRepo(context);
      _objCarBrandListResponse = carBrandListResponse;
      if (_objCarBrandListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("car brand list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objCarBrandListResponse;
  }

  int selectedCarModelIndex = -1; // to know active index
  String _carModelName = "";
  int carModelId = 0;

  String get carModelName => _carModelName;

  void toggleCarModelSelected(int index, String value) {
    isCarModelSelected = true;
    _carModelName = value;
    selectedCarModelIndex = index;

    // carModelId = objCarModelListResponse.data[selectedCarModelIndex].id;
    carModelId = carModelDataArr[selectedCarModelIndex].id;
    print(" carModelId:$carModelId");

    notifyListeners(); // To rebuild the Widget
  }

  //Car Model List
  CarModelResponse _objCarModelListResponse =
      CarModelResponse(message: "", status: 0, data: []);

  CarModelResponse get objCarModelListResponse => _objCarModelListResponse;

  Future<CarModelResponse> getCarModelListApi(
      String carBrandId, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final carModelListResponse =
          await yopeeRepo.carModelListRepo(carBrandId, context);
      _objCarModelListResponse = carModelListResponse;
      if (_objCarModelListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("car Model list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objCarModelListResponse;
  }

  //Car Service List
  ServicesResponse _objServicesResponse =
      ServicesResponse(message: "", status: 0, data: []);
  List<ServiceData> categoryItemlist = [];

  ServicesResponse get objServicesResponse => _objServicesResponse;

  Future<ServicesResponse> getCarServiceListApi(BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final carServiceListResponse =
          await yopeeRepo.carServiceListRepo(context);
      _objServicesResponse = carServiceListResponse;
      if (_objServicesResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        categoryItemlist = _objServicesResponse.data;

        print("car Service list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objServicesResponse;
  }

  //Car Service Details

  ServiceDetailsResponse _objServiceDetailResponse = ServiceDetailsResponse(
      message: '',
      status: 0,
      data: ServiceDetailData(
          id: 0,
          type: '',
          name: '',
          shortDescription: '',
          discountPrice: 0,
          price: 0,
          status: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          image: '',
          icon: '',
          media: [],
          getService: []));

  ServiceDetailsResponse get objServiceDetailResponse =>
      _objServiceDetailResponse;

  Future<ServiceDetailsResponse> getCarServiceDetailsApi(
      String id, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final serviceDetailsResponse =
          await yopeeRepo.serviceDetailsRepo(id, context);
      _objServiceDetailResponse = serviceDetailsResponse;
      if (_objServiceDetailResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        // Fluttertoast.showToast(
        //     msg: "Records retrieved successfully.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: ColorTheme.themeGreenColor,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        //  getAddressListApi(context);

        print("Service  details api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objServiceDetailResponse;
  }

  //Profile View
  ProfileViewResponse _objProfileViewResponse = ProfileViewResponse(
      data: ProfileViewData(
        id: 0,
        userType: '',
        status: '',
        email: '',
        countryCode: '',
        mobile: 0,
        latitude: '0',
        longitude: '0',
        address: '0',
        accessToken: '',
        pushNotification: 0,
        notifyMonthlyPayment: 0,
        profileImageUrl: '',
        name: '',
        accountDetails: 0,
      ),
      message: '',
      status: 0);

  int? _accountDetails;

  int? get accountDetails => _accountDetails;

  void setAccountDetails(int value) {
    _accountDetails = value;
    notifyListeners();
  }

  ProfileViewResponse get objProfileViewResponse => _objProfileViewResponse;

  Future<ProfileViewResponse> getProfileViewApi(BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final profileViewResponse = await yopeeRepo.profileViewRepo(context);
      _objProfileViewResponse = profileViewResponse;
      if (_objProfileViewResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;
        setAccountDetails(objProfileViewResponse.data.accountDetails);
        print("accountDetails:${accountDetails}");
        notifyListeners();

        Environment.profileName = objProfileViewResponse.data.name.toString();
        Environment.profileEmail = objProfileViewResponse.data.email.toString();

        print("profile view  api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objProfileViewResponse;
  }

  bool _profileUpdateClicked = true;

  bool get profileUpdateClicked => _profileUpdateClicked;

  void setEnableButton() {
    _profileUpdateClicked = true;
    notifyListeners();
  }

  void setDisableButton() {
    _profileUpdateClicked = false;
    notifyListeners();
  }

  //Profile update
  ProfileUpdateResponse _objProfileUpdateResponse = ProfileUpdateResponse(
      message: '',
      status: 0,
      data: ProfileUpdateData(
          id: 0,
          userType: '',
          status: "",
          email: "",
          countryCode: "",
          mobile: "",
          latitude: "",
          longitude: "",
          address: "",
          accessToken: "",
          pushNotification: 0,
          notifyMonthlyPayment: 0,
          profileImageUrl: "",
          name: "",
          accountDetails: 0));

  ProfileUpdateResponse get objProfileUpdateResponse =>
      objProfileUpdateResponse;

  Future<ProfileUpdateResponse> getProfileUpdateApi(
      String name, String email, String mobile, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final profileUpdateResponse =
          await yopeeRepo.profileUpdateRepo(name, email, mobile, context);
      _objProfileUpdateResponse = profileUpdateResponse;
      if (_objProfileUpdateResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;
        // _profileUpdateClicked = true;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Profile has been updated successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        print("profile update api Called Successfully");

        Timer(
            const Duration(seconds: 2),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard())));
      } else {
        isLoading = false;
        isError = false;
        //  _profileUpdateClicked = true;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      //  _profileUpdateClicked = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objProfileUpdateResponse;
  }

  String _aboutUsDesc = "";

  String? get aboutUsDesc => _aboutUsDesc;

  void setAboutUs(String value) {
    _aboutUsDesc = value;
    notifyListeners();
  }

  //About Us
  AboutUsResponse _objAboutUsResponse = AboutUsResponse(
    message: '',
    status: 0,
    data: AboutUsdata(slug: '', tittle: '', description: ''),
  );

  AboutUsResponse get objAboutUsResponse => _objAboutUsResponse;

  Future<AboutUsResponse> getAboutUsApi(
      String slug, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final aboutUsResponse = await yopeeRepo.aboutUsRepo(slug, context);
      _objAboutUsResponse = aboutUsResponse;
      if (_objAboutUsResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("about us api Called Successfully");

        _aboutUsDesc = _objAboutUsResponse.data.description.toString();
        print("aboutUsDesc:$_aboutUsDesc");

        // Timer(
        //     const Duration(seconds: 1),
        //     () => Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => MoreMenu())));
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objAboutUsResponse;
  }

  List<PlatformFile>? _paths;
  static var dio = Dio();
  var file = "";
  String _uploadFileName = "";

  String get uploadFileName => _uploadFileName;

  // XFile? image;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  Future pickImages(ImageSource media) async {
    try {
      image = await picker.pickImage(source: media);
      //if (image == null) return;

      //image = pickImage;

      var uploadImageUrl = Environment.baseUrl + Environment.uploadPhotoUrl;
      uploadImage(image, uploadImageUrl);
      notifyListeners();
      // FilePickerResult? imageResult = await FilePicker.platform.pickFiles(
      //   allowMultiple: true,
      //   type: FileType.custom,
      //   allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg'],
      // );
      //
      // print("imageResult:${imageResult.files.}")
      // if (imageResult != null) {
      //   List files = imageResult.paths
      //       .map((path) => MultipartFile.fromFileSync(
      //             path.toString(),
      //             filename: imageResult.paths.split("/").last,
      //             contentType: MediaType('image')
      //
      //           ))
      //       .toList();
      //   var dio = Dio();
      //   var formData = FormData.fromMap({
      //     'profile_image': files,
      //   });
      //   var response = await dio.post(uploadImageUrl, data: formData);
      //
      //   if (response.statusCode == 200) {
      //     isLoading = false;
      //     isSuccess = true;
      //     isError = true;
      //     notifyListeners();
      //
      //     Fluttertoast.showToast(
      //         msg: "Image Uploaded Successfully",
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.CENTER,
      //         timeInSecForIosWeb: 1,
      //         backgroundColor: ColorTheme.themeGreenColor,
      //         textColor: Colors.white,
      //         fontSize: 16.0);
      //
      //     print("upload api Called Successfully");
      //     // it's uploaded
      //   }
      // } else {
      //   // User canceled the picker
      // }
      // notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<UploadPhotoResponse> uploadImage(
      XFile? file, String uploadImageUrl) async {
    UploadPhotoResponse uploadPhotoResponse = UploadPhotoResponse();
    String fileName = file!.path.split('/').last;
    print("filnename:$fileName");
    FormData formData = FormData.fromMap({
      "profile_image":
          await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await dio.post(
      uploadImageUrl,
      data: formData,
      options: Options(
          headers: {"Authorization": "Bearer ${Environment.accessToken}"},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    if (response.statusCode == 200) {
      uploadPhotoResponse = UploadPhotoResponse.fromJson(response.data);
      Fluttertoast.showToast(
          msg: "Image Uploaded Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorTheme.themeGreenColor,
          textColor: Colors.white,
          fontSize: 16.0);

      print("upload api Called Successfully");
    }
    return uploadPhotoResponse;
  }

  String? dropdownvalue;
  String? vehicletypedropdownvalue;
  TextEditingController _messageController = TextEditingController();

  TextEditingController get messageController => _messageController;

  TextEditingController _feedbackController = TextEditingController();

  TextEditingController get feedbackController => _feedbackController;

  //Contact Us
  ContactUsResponse _objContactUsResponse = ContactUsResponse();

  ContactUsResponse get objContactUsResponse => _objContactUsResponse;

  Future<ContactUsResponse> getContactUsApi(
      String serviceName, String message, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final contactUsResponse =
          await yopeeRepo.contactUsRepo(serviceName, message, context);
      _objContactUsResponse = contactUsResponse;
      if (_objContactUsResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        Fluttertoast.showToast(
            msg: "Message sent successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        print("contact us api Called Successfully");

        Timer(
            const Duration(seconds: 2),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MoreMenu())));
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objContactUsResponse;
  }

  bool subsAddClicked = false;
  bool serviceCLicked = false;
  bool specialRequestClicked = false;

  // bool get subsAddClicked => _subsAddClicked;
  //
  // void setsubsAddClickedEnableButton() {
  //   _subsAddClicked = true;
  //   notifyListeners();
  // }
  //
  // void setsubsAddClickedDisableButton() {
  //   _subsAddClicked = false;
  //   notifyListeners();
  // }

  //Subscription Add
  UserSubscriptionAddResponse _objSubsAddResponse =
      UserSubscriptionAddResponse();

  UserSubscriptionAddResponse get objSubsAddResponse => _objSubsAddResponse;

  Future<UserSubscriptionAddResponse> getSubscriptionAddApi(
      String userVehicleId,
      String userAddressId,
      String subscriptionId,
      String amount,
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final subsAddResponse = await yopeeRepo.subsAddRepo(
          userVehicleId, userAddressId, subscriptionId, amount, context);
      _objSubsAddResponse = subsAddResponse;
      if (_objSubsAddResponse.status == 200) {
        if (objSubsAddResponse.data is Map<String, dynamic> &&
            objSubsAddResponse.data.isNotEmpty) {
          isLoading = false;
          isSuccess = true;
          isError = true;

          notifyListeners();
          Fluttertoast.showToast(
              msg: "${objSubsAddResponse.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorTheme.themeGreenColor,
              textColor: Colors.white,
              fontSize: 16.0);
          subsAddClicked = false;
          print("subscription  add api Called Successfully");

          Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Dashboard(),
                    // transitionsBuilder: (BuildContext context,
                    //     Animation<double> animation,
                    //     Animation<double> secondaryAnimation,
                    //     Widget child) {
                    //   return new SlideTransition(
                    //     position: new Tween<Offset>(
                    //       //Left to right
                    //       begin: const Offset(-1.0, 0.0),
                    //       end: Offset.zero,
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
                  ))

              // Navigator.push(
              // context, MaterialPageRoute(builder: (context) => Dashboard()))

              );
        } else if (objSubsAddResponse.data is List<dynamic> &&
            objSubsAddResponse.data.isEmpty) {
          isLoading = false;
          isSuccess = true;
          isError = true;

          notifyListeners();
          Fluttertoast.showToast(
              msg: "${objSubsAddResponse.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          subsAddClicked = false;
        }
      } else {
        isLoading = false;
        isError = false;
        subsAddClicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      subsAddClicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return _objSubsAddResponse;
  }

  bool subsVehicleSelection = false;
  bool subsAddressSelection = false;
  bool _subsEdit = false;

  bool get subsEdit => _subsEdit;

  void setSubsEdit(bool value) {
    _subsEdit = value;
    notifyListeners();
  }

  bool serviceVehicleEdit = false;
  bool serviceAddressEdit = false;

  bool isCarBrandSelected = false;
  bool isCarModelSelected = false;
  bool isVehicleTypeSelected = false;

  int _mySubscriptionIndex = -1;
  int get mySubscriptionIndex => _mySubscriptionIndex;

  void setMySubscriptionIndex(int value) {
    _mySubscriptionIndex = value;
    notifyListeners();
  }

  //User Subscription List0
  UserSubscriptionListResponse _objUserSubsListResponse =
      UserSubscriptionListResponse(data: [], message: '', status: 0);

  UserSubscriptionListResponse get objUserSubsListResponse =>
      _objUserSubsListResponse;

  Future<UserSubscriptionListResponse> getUserSubscriptionListApi(
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final userSubsListResponse = await yopeeRepo.userSubsListRepo(context);
      _objUserSubsListResponse = userSubsListResponse;
      if (_objUserSubsListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("user subscription list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objUserSubsListResponse;
  }

  //User Upcoming Subscription List0
  UpcomingSubscriptionResponse _objUserUpcomingSubsListResponse =
      UpcomingSubscriptionResponse(data: [], message: '', status: 0);

  UpcomingSubscriptionResponse get objUserUpcomingSubsListResponse =>
      _objUserUpcomingSubsListResponse;

  Future<UpcomingSubscriptionResponse> getUserUpcomingSubscriptionListApi(
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final userUpcomingSubsListResponse =
          await yopeeRepo.upcomingSubsRepo(context);
      _objUserUpcomingSubsListResponse = userUpcomingSubsListResponse;
      if (_objUserUpcomingSubsListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("user Upcoming subscription list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objUserUpcomingSubsListResponse;
  }

  int selectedPaymentCredit = 1;
  int selectedPaymentPhonepe = 1;
  int selectedPaymentGpay = 1;
  int selectedPaymentPaytm = 1;
  int selectedPaymentUpi = 1;

  //Reports List
  ReportsListResponse _objReportsListResponse = ReportsListResponse(data: []);

  ReportsListResponse get objReportsListResponse => _objReportsListResponse;

  List<ReportService> serviceReport = [];

  Future<ReportsListResponse> getReportsListApi(
      String month, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final reportsListResponse =
          await yopeeRepo.reportsListRepo(month, context);
      _objReportsListResponse = reportsListResponse;
      if (_objReportsListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("reports list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objReportsListResponse;
  }

  bool _isSpecialRequest = false;

  bool get isSpecialRequest => _isSpecialRequest;

  void setIsSpecialRequest(bool value) {
    _isSpecialRequest = value;
    notifyListeners();
  }

  //Special Request  List
  SpecialRequestListResponse _objSpecialRequestListResponse =
      SpecialRequestListResponse(data: [], message: '', status: 0);

  SpecialRequestListResponse get objSpecialRequestListResponse =>
      _objSpecialRequestListResponse;

  Future<SpecialRequestListResponse> getSpecialRequestListApi(
      String month, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final specialRequestListResponse =
          await yopeeRepo.specialReqListRepo(month, context);
      _objSpecialRequestListResponse = specialRequestListResponse;
      if (_objSpecialRequestListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("Special Request list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objSpecialRequestListResponse;
  }

  TextEditingController _messageSpecialController = TextEditingController();

  TextEditingController get messageSpecialController =>
      _messageSpecialController;

  //Special Request  Add
  SpecialRequestAddResponse _objSpecialRequestAddResponse =
      SpecialRequestAddResponse();

  SpecialRequestAddResponse get objSpecialRequestAddResponse =>
      _objSpecialRequestAddResponse;

  Future<SpecialRequestAddResponse> getSpecialRequestAddApi(
      String userVehicleId,
      String userAddressId,
      String message,
      String requestDate,
      String amount,
      String serviceId,
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final specialRequestAddResponse = await yopeeRepo.specialReqAddRepo(
          userVehicleId,
          userAddressId,
          message,
          requestDate,
          amount,
          serviceId,
          context);
      _objSpecialRequestAddResponse = specialRequestAddResponse;
      if (_objSpecialRequestAddResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        Fluttertoast.showToast(
            msg: "Special Request has been created successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);
        specialRequestClicked = false;

        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SpecialRequestScreen())));

        print("Special Request add api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        specialRequestClicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      specialRequestClicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return _objSpecialRequestAddResponse;
  }

  //Special Request  Delete
  SpecialRequestDeleteResponse _objSpecialRequestDeleteResponse =
      SpecialRequestDeleteResponse();

  SpecialRequestDeleteResponse get objSpecialRequestDeleteResponse =>
      _objSpecialRequestDeleteResponse;

  Future<SpecialRequestDeleteResponse> getSpecialRequestDeleteApi(
      String id, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final specialRequestDeleteResponse =
          await yopeeRepo.specialReqDeleteRepo(id, context);
      _objSpecialRequestDeleteResponse = specialRequestDeleteResponse;
      if (_objSpecialRequestDeleteResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        Fluttertoast.showToast(
            msg: "Special Request has been deleted successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        print("Special Request delete api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objSpecialRequestDeleteResponse;
  }

  //Dashboard
  DashboardResponse _objDashboardResponse = DashboardResponse(
      message: '',
      status: 0,
      data: DashboardData(
          banners: Banners(
              currentPage: 0,
              data: [],
              firstPageUrl: '',
              from: 0,
              lastPage: 0,
              lastPageUrl: '',
              links: [],
              nextPageUrl: '',
              path: '',
              perPage: 0,
              to: 0,
              total: 0,
              prevPageUrl: ''),
          services: Banners(
              currentPage: 0,
              data: [],
              firstPageUrl: '',
              from: 0,
              lastPage: 0,
              lastPageUrl: '',
              links: [],
              nextPageUrl: '',
              path: '',
              perPage: 0,
              to: 0,
              total: 0,
              prevPageUrl: ''),
          rating: Rating(
              currentPage: 0,
              data: [],
              firstPageUrl: '',
              from: 0,
              lastPage: 0,
              lastPageUrl: '',
              links: [],
              path: '',
              perPage: 0,
              to: 0,
              total: 0,
              nextPageUrl: '',
              prevPageUrl: ''),
          userProfile: DashboardUser(
            accessToken: '',
            id: 0,
            userType: '',
            status: '',
            email: "",
            countryCode: '',
            mobile: 0,
            userCategoryType: '',
            userDocVerification: '',
            latitude: '',
            longitude: '',
            address: '',
            pushNotification: 0,
            notifyMonthlyPayment: 0,
            accountDetails: 0,
            name: '',
            profileImageUrl: '',
            documentImageUrl: '',
          )));

  DashboardResponse get objDashboardResponse => _objDashboardResponse;

  Future<DashboardResponse> getDashboardApi(BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final dashboardResponse = await yopeeRepo.dashboardRepo(context);
      _objDashboardResponse = dashboardResponse;
      if (_objDashboardResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("Dashboard api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objDashboardResponse;
  }

  bool isReadNotification = false;

  bool _markAll = false;

  bool get markAll => _markAll;

  void setMarkAllNotification(bool value) {
    _markAll = value;
    notifyListeners();
  }

  //Read Notification

  ReadNotificationResponse _objReadNotificationResponse =
      ReadNotificationResponse();

  ReadNotificationResponse get objReadNotificationResponse =>
      _objReadNotificationResponse;

  Future<ReadNotificationResponse> getReadNotificationApi(
      String id, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final readNotificationResponse =
          await yopeeRepo.readNotificationRepo(id, context);
      _objReadNotificationResponse = readNotificationResponse;
      if (_objReadNotificationResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        isReadNotification = true;
        getListNotificationApi("", context);
        // Fluttertoast.showToast(
        //     msg: "Profile has been updated successfully.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: ColorTheme.themeGreenColor,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        print("Read Notification api Called Successfully");

        // Timer(
        //     const Duration(seconds: 2),
        //     () => Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => NotificationScreen())));
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objReadNotificationResponse;
  }

  //Delete Notification

  DeleteNotificationResponse _objDeleteNotificationResponse =
      DeleteNotificationResponse();

  DeleteNotificationResponse get objDeleteNotificationResponse =>
      _objDeleteNotificationResponse;

  Future<DeleteNotificationResponse> getDeleteNotificationApi(
      String receiverId, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final deleteNotificationResponse =
          await yopeeRepo.deleteNotificationRepo(receiverId, context);
      _objDeleteNotificationResponse = deleteNotificationResponse;
      if (_objDeleteNotificationResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        getListNotificationApi("", context);
        // Fluttertoast.showToast(
        //     msg: "Profile has been updated successfully.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: ColorTheme.themeGreenColor,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        print("Delete Notification api Called Successfully");

        // Timer(
        //     const Duration(seconds: 2),
        //         () => Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => Dashboard())));
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objDeleteNotificationResponse;
  }

  //List Notification

  bool _isUnreadNotificationVisible = false;

  bool get isUnreadNotificationVisible => _isUnreadNotificationVisible;

  void setUnreadNotificationVisibility(bool value) {
    _isUnreadNotificationVisible = value;
    notifyListeners();
  }

  String? _receiverId;

  String? get receiverId => _receiverId;

  UnreadNotificationResponse _objListNotificationResponse =
      UnreadNotificationResponse(data: [], message: '', status: 0);

  UnreadNotificationResponse get objListNotificationResponse =>
      _objListNotificationResponse;

  Future<UnreadNotificationResponse> getListNotificationApi(
      String status, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final listNotificationResponse =
          await yopeeRepo.listNotificationRepo(status, context);
      _objListNotificationResponse = listNotificationResponse;
      if (_objListNotificationResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        // Fluttertoast.showToast(
        //     msg: "Profile has been updated successfully.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: ColorTheme.themeGreenColor,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        print("List Notification api Called Successfully");

        // Timer(
        //     const Duration(seconds: 2),
        //         () => Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => Dashboard())));
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objListNotificationResponse;
  }

  // Notification Status

  NotificationStatusResponse _objNotificationStatusResponse =
      NotificationStatusResponse(data: NotificationData());

  NotificationStatusResponse get objNotificationStatusResponse =>
      _objNotificationStatusResponse;

  Future<NotificationStatusResponse> getNotificationStatusApi(
      String pushNotification, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final notificationStatusResponse =
          await yopeeRepo.notificationStatusRepo(pushNotification, context);
      _objNotificationStatusResponse = notificationStatusResponse;
      if (_objNotificationStatusResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        // getListNotificationApi("", context);

        // _objNotificationStatusResponse.data.pushNotification == "0"
        //     ? Fluttertoast.showToast(
        //         msg: "Notification is Off.",
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.CENTER,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: Colors.red,
        //         textColor: Colors.white,
        //         fontSize: 16.0)
        //     : Fluttertoast.showToast(
        //         msg: "Notification is On.",
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.CENTER,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: ColorTheme.themeGreenColor,
        //         textColor: Colors.white,
        //         fontSize: 16.0);

        print("Notification Status api Called Successfully");

        // Timer(
        //     const Duration(seconds: 2),
        //         () => Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => Dashboard())));
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objNotificationStatusResponse;
  }

  // Rate wash

  // RateWashResponse _objRateWashResponse = RateWashResponse(
  //     data: RateWashData(icon: '', rating: '', feedback: '', media: []));
  //
  // RateWashResponse get objRateWashResponse => _objRateWashResponse;
  double _rating = 0;

  double get rating => _rating;

  void setRating(double rating) {
    _rating = rating;
    notifyListeners();
  }

  List<File> images = [];
  List<File> selectedRateWashImages = [];

  Future getRateWashImages(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    XFile? xfilePick = pickedFile;

    //  if (xfilePick.isNotEmpty) {
    // for (var i = 0; i < xfilePick.length; i++) {
    selectedRateWashImages.add(File(xfilePick!.path));
    notifyListeners();
    // }
    // }
  }

  final ImagePicker ratewashpicker = ImagePicker();

  Future getImage(ImageSource source) async {
    var image = await ratewashpicker.pickImage(source: source);

    selectedRateWashImages.add(File(image!.path));
    notifyListeners();
  }

  bool isRateWashSubmit = false;

  List<MultipartFile> newList = [];

  uploadRateWashImage(String bookingId, String icon, String rating,
      String feedback, BuildContext context) async {
    String rateWashUrl = Environment.baseUrl + Environment.rateWashUrl;
    print("RateWash url:${rateWashUrl}");
    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${Environment.accessToken}'
    };

    var request = http.MultipartRequest('POST', Uri.parse(rateWashUrl));
    for (int i = 0; i < selectedImages.length; i++) {
      final f =
          await http.MultipartFile.fromPath('document', selectedImages[i].path);
      request.files.add(f);
      print("uploaded document :${f.filename}");
    }

    request.fields['booking_id'] = bookingId;
    request.fields['icon'] = icon;
    request.fields['rating'] = rating;
    request.fields['feedback'] = feedback;
    request.headers.addAll(headers);

    printRateWashParams(request);

    var response = request.send();
    Fluttertoast.showToast(
        msg: "Rating submitted successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorTheme.themeGreenColor,
        textColor: Colors.white,
        fontSize: 16.0);
    print("Rating submitted Successfully");

    Timer(
        const Duration(seconds: 1),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Reports())));

    return response;
  }

  Future<RateWashResponse> getRateWashApi(String bookingId, String icon,
      String rating, String feedback, BuildContext context) async {
    RateWashResponse objRateWashResponse = RateWashResponse(
        data: RateWashDataItems(icon: '', rating: '', feedback: '', media: []));
    String rateWashUrl = Environment.baseUrl + Environment.rateWashUrl;
    print("RateWash url:${rateWashUrl}");
    try {
      final headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> rateWashParams = {
        "booking_id": bookingId,
        "icon": icon,
        "rating": rating,
        "feedback": feedback
      };

      var request = http.MultipartRequest('POST', Uri.parse(rateWashUrl));

      request.fields['booking_id'] = bookingId;
      request.fields['icon'] = icon;
      request.fields['rating'] = rating;
      request.fields['feedback'] = feedback;
      request.headers.addAll(headers);

      // if (image != null) {
      //   request.files.add(
      //       await http.MultipartFile.fromPath('document[]', uploadFileName));
      // }

      for (int i = 0; i < selectedImages.length; i++) {
        final f = await http.MultipartFile.fromPath(
            'document', selectedImages[i].path);
        request.files.add(f);
      }

      printRateWashParams(request);
      // var body = profileUpdateParams;
      // final encoding = Encoding.getByName('utf-8');

      // print("profileUpdateParams :$body ");

      // final response = await http.post(Uri.parse(profileUpdateUrl),
      //     body: body, headers: headers);

      final response = await request.send();
      var res = await http.Response.fromStream(response);

      // print("profile update body:${response.body}");

      int statusCode = res.statusCode;
      print("rate wash statusCode: ${res.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objRateWashResponse = RateWashResponse.fromJson(jsonDecode(res.body));

        print("objRateWashResponse:${objRateWashResponse.data}");
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        isRateWashSubmit = false;

        Fluttertoast.showToast(
            msg: "Rating submitted successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        print("Rating submitted Successfully");

        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Reports())));
        return objRateWashResponse;
      } else if (statusCode == 500) {
        isLoading = false;
        isError = false;
        isRateWashSubmit = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      isRateWashSubmit = false;
      notifyListeners();
      print("Exception:$e");
    }
    return objRateWashResponse;
  }

  String? sharetext = 'Share Yopee App';
  String? sharelink = 'https://binarymetrix-staging.com';

  bool _isRateWashSelected = false;
  int _selectedRateWash = -1;

  int get selectedRateWash => _selectedRateWash;

  bool get isRateWashSelected => _isRateWashSelected;

  void setRateWashSelected(int index, bool value) {
    _selectedRateWash = index;
    _isRateWashSelected = value;
    notifyListeners();
  }

  List<File> selectedImages = [];

  Future getWashImages(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000, source: source);
    XFile? xfilePick = pickedFile;

    // if (xfilePick!.isNotEmpty) {
    //  for (var i = 0; i < xfilePick.length; i++) {
    selectedImages.add(File(xfilePick!.path));
    notifyListeners();
    //}
    // }
  }

  Future getImages(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
    notifyListeners();
  }

  void printRateWashParams(http.MultipartRequest request) {
    request.fields.forEach((key, value) {
      print("Rate Wash Params $key:$value");
    });
  }

  bool _isService = false;

  bool get isService => _isService;

  void setIsService(bool value) {
    _isService = value;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();
  String _date = "";

  String get date => _date;

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2022, 8),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      String reportDate = DateFormat("yyyy-MM-dd").format(selectedDate);
      _date = DateFormat("dd MMM, yyyy").format(selectedDate);

      setDate(_date);
      print("date:$date");
      getReportsListApi(reportDate, context);
      notifyListeners();
    }
  }

  DateTime selectedMyServiceDate = DateTime.now();
  String _dateMyService = "";

  String get dateMyService => _dateMyService;

  void setDateMyService(String date) {
    _dateMyService = dateMyService;
    notifyListeners();
  }

  Future<void> selectDateMyService(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedMyServiceDate,
        firstDate: DateTime(2022, 8),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedMyServiceDate) {
      selectedMyServiceDate = picked;
      String MyServiceDate =
          DateFormat("yyyy-MM-dd").format(selectedMyServiceDate);
      _dateMyService = DateFormat("dd MMM, yyyy").format(selectedMyServiceDate);

      setDateMyService(_dateMyService);
      print("dateMyService:$dateMyService");
      getUserServiceListApi(MyServiceDate, context);
      notifyListeners();
    }
  }

  DateTime selectedMySpecialReqDate = DateTime.now();
  String _dateMySpecialReq = "";

  String get dateMySpecialReq => _dateMySpecialReq;

  void setDateMySubscription(String date) {
    _dateMySpecialReq = dateMySpecialReq;
    notifyListeners();
  }

  Future<void> selectDateMySpecialReq(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedMySpecialReqDate,
        firstDate: DateTime(2022, 8),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedMySpecialReqDate) {
      selectedMySpecialReqDate = picked;
      String MySpecialReqDate =
          DateFormat("yyyy-MM-dd").format(selectedMySpecialReqDate);
      _dateMySpecialReq =
          DateFormat("dd MMM, yyyy").format(selectedMySpecialReqDate);

      setDateMyService(_dateMySpecialReq);
      print("dateMySpecialReq:$dateMySpecialReq");
      getSpecialRequestListApi(MySpecialReqDate, context);
      notifyListeners();
    }
  }

  int? _accountDetailsKey = 0;

  int? get accountDetailsKey => _accountDetailsKey;

  void setProfileAccountDetails(int? value) {
    _accountDetailsKey = value;
    notifyListeners();
  }

  String? _carName;

  String? get carName => _carName;

  void getCarName(String? value) {
    _carName = value;
    notifyListeners();
  }

  String? _carNameWash;

  String? get carNameWash => _carNameWash;

  void getCarNameWash(String? value) {
    _carNameWash = value;
    notifyListeners();
  }

  String? _regNumber;

  String? get regNumber => _regNumber;

  void getRegNumber(String? value) {
    _regNumber = value;
    notifyListeners();
  }

  String? _regNumberWash;

  String? get regNumberWash => _regNumberWash;

  void getRegNumberWash(String? value) {
    _regNumberWash = value;
    notifyListeners();
  }

  String? _fullMessage;

  String? get fullMessage => _fullMessage;

  void getfullMessage(String? value) {
    _fullMessage = value;
    notifyListeners();
  }

  String washMessage = "";
  String? _fullMessageWash;

  String? get fullMessageWash => _fullMessageWash;

  void getfullMessageWash(String? value) {
    _fullMessage = value;
    notifyListeners();
  }

  contactToAdministrator(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                width: 250,
                constraints: BoxConstraints(maxHeight: double.infinity),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          // width: double.infinity,
                          // decoration: BoxDecoration(
                          //   color: ColorTheme.themeWhiteColor,
                          //   borderRadius: BorderRadius.circular(
                          //     5.00,
                          //   ),
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18, top: 14, right: 18, bottom: 20),
                                child: Text(
                                  " No longer active.!!",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                //  width: 152.00,
                                margin: EdgeInsets.only(
                                  left: 18,
                                  top: 3,
                                  right: 18,
                                ),
                                child: Text(
                                  "Please contact your Administrator.",
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: 'Medium',
                                    fontWeight: FontWeight.w400,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  // String carNameNotify= extractCarName(listNotificationItem[index]
  //     .message
  //     .content
  //     .toString());
  //
  // String extractCarName(String message){
  //   Match match=carNameExps.firstMatch(message)??RegExpMatch("",-1,-1,"");
  //   return match.group(1)??"";
  // }

  //User Service  List
  SpecialRequestListResponse _objUserServiceListResponse =
      SpecialRequestListResponse(data: [], message: '', status: 0);

  SpecialRequestListResponse get objUserServiceListResponse =>
      _objUserServiceListResponse;

  Future<SpecialRequestListResponse> getUserServiceListApi(
      String month, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final userServiceListResponse =
          await yopeeRepo.userServiceListRepo(month, context);
      _objUserServiceListResponse = userServiceListResponse;
      if (_objUserServiceListResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();

        print("User Service list api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      print("Exception:$e");
    }
    return _objUserServiceListResponse;
  }

  //User Service   Add
  SpecialRequestAddResponse _objUserServiceAddResponse =
      SpecialRequestAddResponse();

  SpecialRequestAddResponse get objUserServiceAddResponse =>
      _objUserServiceAddResponse;

  Future<SpecialRequestAddResponse> getUserServiceAddApi(
      String userVehicleId,
      String userAddressId,
      String amount,
      String serviceId,
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final userServiceAddResponse = await yopeeRepo.userServiceAddRepo(
          userVehicleId, userAddressId, amount, serviceId, context);
      _objUserServiceAddResponse = userServiceAddResponse;
      if (_objUserServiceAddResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        Fluttertoast.showToast(
            msg: "Service Added.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        serviceCLicked = false;

        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard())));

        print(" User Service add api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        serviceCLicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      serviceCLicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return _objUserServiceAddResponse;
  }

  bool isvehicleTypeVisible = false;

  //search vehicle type
  String _searchVehicleTypeString = "";
  String _searchVehicleTypeText = "";
  TextEditingController vehicleTypeController = TextEditingController();

  String get searchVehicleTypeString => _searchVehicleTypeString;

  void changeVehicleTypeSearchString(String searchString) {
    _searchVehicleTypeString = searchString;
    print("search Vehicle type :${_searchVehicleTypeString}");
    notifyListeners();
  }

  void changeVehicleTypeSearchText(String searchString) {
    _searchVehicleTypeText = searchString;
    notifyListeners();
  }

  //for searchBar in VehicleType
  UnmodifiableListView<VehicleTypeData> get vehicleTypeDataArr =>
      _searchVehicleTypeString.isEmpty
          ? UnmodifiableListView(objVehicleTypeListResponse.data)
          : UnmodifiableListView(objVehicleTypeListResponse.data.where(
              (element) => element.name
                  .toLowerCase()
                  .contains(_searchVehicleTypeString)));

  //search car brand
  String _searchCarBrandString = "";
  String _searchCarBrandText = "";
  TextEditingController carBrandController = TextEditingController();

  String get searchCarBrandString => _searchCarBrandString;

  void changeCarBrandSearchString(String searchString) {
    _searchCarBrandString = searchString;
    print("search car brand :${_searchCarBrandString}");
    notifyListeners();
  }

  void changeCarBrandSearchText(String searchString) {
    _searchCarBrandText = searchString;
    notifyListeners();
  }

  //for searchBar in Car Brand
  UnmodifiableListView<CarBrandData> get carBrandDataArr =>
      _searchCarBrandString.isEmpty
          ? UnmodifiableListView(objCarBrandListResponse.data)
          : UnmodifiableListView(objCarBrandListResponse.data.where((element) =>
              element.name.toLowerCase().contains(_searchCarBrandString)));

  //search car model
  String _searchCarModelString = "";
  String _searchCarModelText = "";
  TextEditingController carModelController = TextEditingController();

  String get searchCarModelString => _searchCarModelString;

  void changeCarModelSearchString(String searchString) {
    _searchCarModelString = searchString;
    print("search car model :${_searchCarModelString}");
    notifyListeners();
  }

  void changeCarModelSearchText(String searchString) {
    _searchCarModelText = searchString;
    notifyListeners();
  }

  //for searchBar in Car Brand
  UnmodifiableListView<CarModelData> get carModelDataArr =>
      _searchCarModelString.isEmpty
          ? UnmodifiableListView(objCarModelListResponse.data)
          : UnmodifiableListView(objCarModelListResponse.data.where((element) =>
              element.name.toLowerCase().contains(_searchCarModelString)));

  late final Completer<GoogleMapController> controller = Completer();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  //
  // final sessionToken = Uuid().v4();
  // final provider = PlaceApiProvider(Uuid().v4());
  // List<Suggestion> suggestion = [];
  //
  // // final String sessionToken;
  // final apiKey = "AIzaSyC5P-65Eudaq-dqA46AMtpGH9CT_uv-2w8";
  //
  // http.Request createGetRequest(String url) =>
  //     http.Request('GET', Uri.parse(url));
  //
  // Future<List<Suggestion>> fetchSuggestions(String input) async {
  //   final url =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:sg&key=$apiKey&sessiontoken=$sessionToken';
  //   var request = createGetRequest(url);
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final data = await response.stream.bytesToString();
  //     final result = json.decode(data);
  //
  //     print(result);
  //
  //     if (result['status'] == 'OK') {
  //       return result['predictions']
  //           .map<Suggestion>((p) => Suggestion(p['place_id'], p['description'],
  //               p['structured_formatting']['main_text']))
  //           .toList();
  //     }
  //     if (result['status'] == 'ZERO_RESULTS') {
  //       return [];
  //     }
  //     throw Exception(result['error_message']);
  //   } else {
  //     throw Exception('Failed to fetch suggestion');
  //   }
  // }
  //
  // Future<PlaceDetail> getPlaceDetailFromId(String placeId) async {
  //   final url =
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=formatted_address,name,geometry/location&key=$apiKey&sessiontoken=$sessionToken';
  //   var request = createGetRequest(url);
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final data = await response.stream.bytesToString();
  //     final result = json.decode(data);
  //     print(result);
  //
  //     if (result['status'] == 'OK') {
  //       // build result
  //       final place = PlaceDetail();
  //       place.address = result['result']['formatted_address'];
  //       place.latitude = result['result']['geometry']['location']['lat'];
  //       place.longitude = result['result']['geometry']['location']['lng'];
  //       place.name = result['result']['geometry']['name'];
  //       return place;
  //     }
  //     throw Exception(result['error_message']);
  //   } else {
  //     throw Exception('Failed to fetch suggestion');
  //   }
  // }

  bool signupClicked = false;

  TextEditingController _signupNameController = TextEditingController();
  TextEditingController _signupEmailAddressController = TextEditingController();
  TextEditingController _signupPhoneNumberController = TextEditingController();

  TextEditingController get signupNameController => _signupNameController;

  TextEditingController get signupEmailAddressController =>
      _signupEmailAddressController;
  TextEditingController _signupAddressController = TextEditingController();

  TextEditingController get signupPhoneNumberController =>
      _signupPhoneNumberController;

  TextEditingController get signupAddressController => _signupAddressController;
  SignUpResponse objSignUpResponse = SignUpResponse(data: SignUpData());

  //Signup
  Future<SignUpResponse> signUpApi(
      String name, String email, String mobile, BuildContext context) async {
    //image = await picker.pickImage(source: media);
    // String fileName = image!.path.split('/').last;
    // print("filnename:$fileName");

    String signUpUrl = Environment.baseUrl + Environment.signupUrl;
    print("SignUp url:${signUpUrl}");
    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      Map<String, String> signupParams = {
        "name": name,
        "email": email,
        "mobile": mobile,
      };
      // final encoding = Encoding.getByName('utf-8');

      print("signup params:$signupParams");

      final response = await http.post(
        Uri.parse(signUpUrl),
        body: signupParams,
        //encoding: encoding,
      );

      print("signup body:${response.body}");

      int statusCode = response.statusCode;
      print("Signup statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        objSignUpResponse = SignUpResponse.fromJson(jsonDecode(response.body));
        // Environment.loginMobileNumber =
        //     objLoginResponse.data!.mobile.toString();
        // print("Login Mobile Number:${Environment.loginMobileNumber}");
        Fluttertoast.showToast(
            msg: "${objSignUpResponse.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        Timer(
            const Duration(seconds: 2),
            () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    Login(mobile: objSignUpResponse.data.mobile.toString()))));

        signupNameController.clear();
        signupEmailAddressController.clear();
        signupPhoneNumberController..clear();

        return objSignUpResponse;
      } else if (response.statusCode == 422) {
        Fluttertoast.showToast(
            msg: "The mobile number has already been taken.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      throw Exception(e);
    }
    return objSignUpResponse;

    // try {
    //   final headers = {
    //     // 'Charset': 'utf-8',
    //     'Authorization': 'Bearer ${Environment.accessToken}'
    //   };
    //   Map<String, dynamic> profileUpdateParams = {
    //     "name": name,
    //     "email": email,
    //     "mobile": mobile,
    //   };
    //
    //   var request = http.MultipartRequest('POST', Uri.parse(signUpUrl));
    //
    //   request.fields['name'] = name;
    //   request.fields['email'] = email;
    //   request.fields['mobile'] = mobile;
    //
    //   request.headers.addAll(headers);
    //
    //   // final path = await FilePicker.platform.pickFiles(allowMultiple: true);
    //   // String? filePath = path?.files.single.path;
    //
    //   //  print("filePath:$filePath");
    //
    //   // if (signupdocumentImage != null) {
    //   //   String filename = signupdocumentImage!.path.split('/').last;
    //   //
    //   //   request.files.add(await http.MultipartFile.fromPath(
    //   //       'document_image', signupdocumentImage!.path,
    //   //       filename: filename));
    //   // }
    //
    //   // var body = profileUpdateParams;
    //   // final encoding = Encoding.getByName('utf-8');
    //
    //   // print("profileUpdateParams :$body ");
    //
    //   // final response = await http.post(Uri.parse(profileUpdateUrl),
    //   //     body: body, headers: headers);
    //
    //   final response = await request.send();
    //   var res = await http.Response.fromStream(response);
    //
    //   // print("profile update body:${response.body}");
    //
    //   int statusCode = res.statusCode;
    //   print("profile update statusCode: ${res.statusCode}");
    //
    //   if (statusCode == 200) {
    //     // var data = await jsonDecode(response.body);
    //     // print("profileupdate_data:$data");
    //     objSignUpResponse = SignUpResponse.fromJson(jsonDecode(res.body));
    //
    //     print("objSignUpResponse:${objSignUpResponse.data}");
    //
    //     Fluttertoast.showToast(
    //         msg: "Signup Successful.Please login with your credentials!.",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.CENTER,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: ColorTheme.themeGreenColor,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //
    //     print("signup api Called Successfully");
    //
    //     signupNameController.clear();
    //     signupPhoneNumberController.clear();
    //     signupEmailAddressController.clear();
    //     signupClicked = false;
    //
    //     Timer(
    //         const Duration(seconds: 2),
    //         () => Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context) =>
    //                 Login(mobile: objSignUpResponse.data.mobile.toString()))));
    //     return objSignUpResponse;
    //   } else if (statusCode == 500) {}
    // } catch (e) {
    //   throw Exception(e);
    // }
    // return objSignUpResponse;
  }

  int _selectedSubscriptionprice = 0;

  int get selectedSubscriptionprice => _selectedSubscriptionprice;

  void setselectedSubscriptionprice(int value) {
    _selectedSubscriptionprice = value;
    notifyListeners();
  }

  int _selectedSubscriptionId = 0;

  int get selectedSubscriptionId => _selectedSubscriptionId;

  void setselectedSubscriptionId(int value) {
    _selectedSubscriptionId = value;
    notifyListeners();
  }

  int _selectedServiceprice = 0;

  int get selectedServiceprice => _selectedServiceprice;

  void setselectedServiceprice(int value) {
    _selectedServiceprice = value;
    notifyListeners();
  }

  int _selectedServiceId = 0;

  int get selectedServiceId => _selectedServiceId;

  void setselectedServiceId(int value) {
    _selectedServiceId = value;
    notifyListeners();
  }

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //Renew Subscription
  RenewSubsResponse _objRenewResponse =
      RenewSubsResponse(data: RenewSubsData());

  RenewSubsResponse get objRenewResponse => _objRenewResponse;

  Future<RenewSubsResponse> getRenewSubsApi(
      String userVehicleId,
      String userAddressId,
      String subsId,
      String fromDate,
      String amount,
      BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final renewResponse = await yopeeRepo.renewSubsRepo(
          userVehicleId, userAddressId, subsId, fromDate, amount, context);
      _objRenewResponse = renewResponse;
      if (_objRenewResponse.status == 200) {
        isLoading = false;
        isSuccess = true;
        isError = true;

        notifyListeners();
        Fluttertoast.showToast(
            msg: "${_objRenewResponse.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        //  serviceCLicked = false;

        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => MySubscription())));

        print(" Renew api Called Successfully");
      } else {
        isLoading = false;
        isError = false;
        serviceCLicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      serviceCLicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return _objRenewResponse;
  }

  //Check User Vehicle
  CheckUserVehicleResponse _objCheckUserVehicleResponse =
      CheckUserVehicleResponse(data: CheckUserVehicleData());

  CheckUserVehicleResponse get objCheckUserVehicleResponse =>
      _objCheckUserVehicleResponse;

  Future<CheckUserVehicleResponse> getCheckUSerVehicleApi(
      String id, BuildContext context) async {
    try {
      isLoading = true;
      isError = false;
      // notifyListeners();
      final checkUserVehicleResponse =
          await yopeeRepo.checkUserVehicleRepo(id, context);
      _objCheckUserVehicleResponse = checkUserVehicleResponse;
      if (_objCheckUserVehicleResponse.status == 200) {
        if (_objCheckUserVehicleResponse.data is Map<String, dynamic> &&
            _objCheckUserVehicleResponse.data.isNotEmpty) {
          isLoading = false;
          isSuccess = true;
          isError = true;

          notifyListeners();

          Fluttertoast.showToast(
              msg: "${_objCheckUserVehicleResponse.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorTheme.themeGreenColor,
              textColor: Colors.white,
              fontSize: 16.0);

          //  serviceCLicked = false;

          // Timer(
          //     const Duration(seconds: 1),
          //         () => Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => MySubscription())));

          print(" Check User Vehicle api Called Successfully");
        } else if (_objCheckUserVehicleResponse.data is List<dynamic> &&
            _objCheckUserVehicleResponse.data.isEmpty) {
          isLoading = false;
          isSuccess = true;
          isError = true;

          notifyListeners();
          _objCheckUserVehicleResponse.message!.contains('Selected')
              ? Fluttertoast.showToast(
                  msg: "${_objCheckUserVehicleResponse.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0)
              : Fluttertoast.showToast(
                  msg: "${_objCheckUserVehicleResponse.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
        }
      } else {
        isLoading = false;
        isError = false;
        serviceCLicked = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      serviceCLicked = false;
      notifyListeners();
      print("Exception:$e");
    }
    return objCheckUserVehicleResponse;
  }

  //Resend Otp
  ResendOtpResponse _objResendOtpResponse =
      ResendOtpResponse(data: [], message: '', status: 0);

  ResendOtpResponse get objResendOtpResponse => _objResendOtpResponse;
  Future<ResendOtpResponse> getResendOtpApi(
      String mobileNumber, BuildContext context) async {
    String resendotpUrl = Environment.baseUrl + Environment.resendOtpUrl;
    print("ResendOtp url:${resendotpUrl}");
    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      Map<String, String> resendOtPParams = {
        "mobile": mobileNumber,
        "country_code": "+91"
      };
      // final encoding = Encoding.getByName('utf-8');

      print("resendOtPParams:$resendOtPParams");

      final response = await http.post(
        Uri.parse(resendotpUrl),
        body: resendOtPParams,
        //encoding: encoding,
      );

      print("resend body:${response.body}");

      int statusCode = response.statusCode;
      print("Resend statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        _objResendOtpResponse =
            ResendOtpResponse.fromJson(jsonDecode(response.body));
        // Environment.loginMobileNumber =
        //     objLoginResponse.data!.mobile.toString();
        // print("Login Mobile Number:${Environment.loginMobileNumber}");
        Fluttertoast.showToast(
            msg: "${_objResendOtpResponse.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorTheme.themeGreenColor,
            textColor: Colors.white,
            fontSize: 16.0);

        return _objResendOtpResponse;
      }
    } catch (e) {
      throw Exception(e);
    }
    return _objResendOtpResponse;
  }
}
