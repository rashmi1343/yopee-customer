import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yopee_customer/Entity/Response/Address/AddressAddResponse.dart';
import 'package:yopee_customer/Entity/Response/Address/AddressListResponse.dart';
import 'package:yopee_customer/Entity/Response/DashboardResponse.dart';
import 'package:yopee_customer/Entity/Response/Profile/ProfileUpdateResponse.dart';
import 'package:yopee_customer/Entity/Response/Services/ServiceDetailListResponse.dart';
import 'package:yopee_customer/Entity/Response/Services/ServiceDetailsResponse.dart';
import 'package:yopee_customer/Entity/Response/SpecialRequest/SpecialRequestListResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/RenewSubsResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/SubscriptionDetailsResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/UserSubscriptionAddResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/UserSubscriptionListResponse.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/CarBrandResponse.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleTypeResponse.dart';
import 'package:yopee_customer/Utility/ColorTheme.dart';
import 'package:yopee_customer/Utility/Environment.dart';

import '../Entity/CheckUserVehicleResponse.dart';
import '../Entity/Response/AboutUsResponse.dart';
import '../Entity/Response/Address/AddressDeleteResponse.dart';
import '../Entity/Response/Address/AddressEditResponse.dart';
import '../Entity/Response/ContactUsResponse.dart';
import '../Entity/Response/Login/LogoutResponse.dart';
import '../Entity/Response/Notification/DeleteNotificationResponse.dart';
import '../Entity/Response/Notification/NotificationStatusResponse.dart';
import '../Entity/Response/Notification/ReadNotificationResponse.dart';
import '../Entity/Response/Notification/UnreadNotificationResponse.dart';
import '../Entity/Response/Profile/ProfileViewResponse.dart';
import '../Entity/Response/RateWashResponse.dart';
import '../Entity/Response/ReportsListResponse.dart';
import '../Entity/Response/Services/ServicesResponse.dart';
import '../Entity/Response/SpecialRequest/SpecialRequestAddResponse.dart';
import '../Entity/Response/SpecialRequest/SpecialRequestDeleteResponse.dart';
import '../Entity/Response/Subscription/BasicSubscriptionResponse.dart';
import '../Entity/Response/Subscription/SubscriptionListResponse.dart';
import '../Entity/Response/Vehicle/CarModelResponse.dart';
import '../Entity/Response/Vehicle/VehicleAddResponse.dart';
import '../Entity/Response/Vehicle/VehicleDeleteResponse.dart';
import '../Entity/Response/Vehicle/VehicleEditResponse.dart';
import '../Entity/Response/Vehicle/VehicleListResponse.dart';
import '../Entity/Response/Login/loginResponse.dart';
import 'package:http/http.dart' as http;

import '../Entity/Response/Otp/otpResponse.dart';
import '../Entity/UpcomingSubscriptionResponse.dart';
import '../View/Login/Login.dart';

class YopeeApiClient {
  //login/Signin
  Future<LoginResponse> loginApi(String mobile) async {
    LoginResponse objLoginResponse = LoginResponse(data: []);
    String loginUrl = Environment.baseUrl + Environment.loginUrl;
    print("login url:${loginUrl}");

    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      Map<String, String> loginParams = {
        "mobile": mobile,
        "country_code": "+91",
        "user_type": "customer"
      };
      // final encoding = Encoding.getByName('utf-8');

      print("login params:$loginParams");

      final response = await http.post(
        Uri.parse(loginUrl),
        body: loginParams,
        //encoding: encoding,
      );

      print("login body:${response.body}");

      int statusCode = response.statusCode;
      print("Login statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objLoginResponse = loginResponseFromJson(response.body);

        if (objLoginResponse.data.isEmpty) {
          Fluttertoast.showToast(
              msg: "${objLoginResponse.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xffF3CBCB),
              textColor: Colors.red,
              fontSize: 16.0);
        } else {
          Environment.loginMobileNumber =
              objLoginResponse.data[0].mobile.toString();
          print("Login Mobile Number:${Environment.loginMobileNumber}");
        }
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again.!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffF3CBCB),
            textColor: Colors.red,
            fontSize: 16.0);
      } else if (statusCode == 422) {
        Fluttertoast.showToast(
            msg: "${objLoginResponse.message}",
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
    return objLoginResponse;
  }

  //Logout Response
  Future<LogoutResponse> logoutApi(String mobile) async {
    LogoutResponse objLogoutResponse = LogoutResponse(data: []);
    String logoutUrl = Environment.baseUrl + Environment.logoutUrl;
    print("logout url:${logoutUrl}");

    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      Map<String, String> logoutParams = {
        "mobile": mobile,
        "country_code": "+91",
        "user_type": "customer"
      };
      // final encoding = Encoding.getByName('utf-8');

      print("logout params:$logoutParams");

      final response = await http.post(
        Uri.parse(logoutUrl),
        body: logoutParams,
        //encoding: encoding,
      );

      print("logout body:${response.body}");

      int statusCode = response.statusCode;
      print("Logout statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objLogoutResponse = logoutResponseFromJson(response.body);
      } else if (statusCode == 422) {}
    } catch (e) {
      throw Exception(e);
    }
    return objLogoutResponse;
  }

  //Otp Verify
  Future<OtpResponse> otpVerifyApi(String userId, String otpNumber) async {
    OtpResponse objOtpResponse = OtpResponse();
    String otpVerifyUrl = Environment.baseUrl + Environment.otpVerifyUrl;
    print("Otp url:${otpVerifyUrl}");

    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      Map<String, String> otpParams = {
        "user_id": userId,
        "otp_number": otpNumber
      };
      // final encoding = Encoding.getByName('utf-8');

      print("otpparams:$otpParams");

      final response = await http.post(
        Uri.parse(otpVerifyUrl),
        body: otpParams,
        //encoding: encoding,
      );

      print("otp body:${response.body}");

      int statusCode = response.statusCode;
      print("Otp statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objOtpResponse = otpResponseFromJson(response.body);
        Environment.accessToken = objOtpResponse.data!.accessToken.toString();
        print("Access Token:${Environment.accessToken}");
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "OTP is invalid.\nPlease try again with correct OTP",
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
    return objOtpResponse;
  }

  // Address List
  Future<AddressListResponse> addressListApi(BuildContext context) async {
    AddressListResponse objAddressListResponse =
        AddressListResponse(message: "", status: 0, data: []);

    String addressListUrl = Environment.baseUrl + Environment.addressListUrl;
    print("Address list url:${addressListUrl}");

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      final response = await http.get(
        Uri.parse(addressListUrl),
        headers: headers,
      );

      print("Address list body:${response.body}");

      int statusCode = response.statusCode;
      print("Address list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        //final addressListItem = jsonDecode(response.body);
        var data = await json.decode(json.encode(response.body));
        objAddressListResponse = addressListResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objAddressListResponse;
  }

  //Address Add
  Future<AddressAddResponse> addressAddApi(String type, String flatHouseNo,
      String areaSector, String nearBy, BuildContext context) async {
    AddressAddResponse objAddAddressResponse = AddressAddResponse();
    String addAddressUrl = Environment.baseUrl + Environment.addressAddUrl;
    print("Add Address url:${addAddressUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> addAddressParams = {
        "type": type,
        "flat_house_no": flatHouseNo,
        "area_sector": areaSector,
        "nearby": nearBy
      };
      // final encoding = Encoding.getByName('utf-8');

      print("addAddressParams :$addAddressParams ");

      final response = await http.post(Uri.parse(addAddressUrl),
          body: addAddressParams, headers: headers
          //encoding: encoding,
          );

      print("add address body:${response.body}");

      int statusCode = response.statusCode;
      print("Add address statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objAddAddressResponse = addressAddResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      } else if (statusCode == 422) {
        objAddAddressResponse = addressAddResponseFromJson(response.body);
        Fluttertoast.showToast(
            msg: "${objAddAddressResponse.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Login(),
        //   ),
        // );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objAddAddressResponse;
  }

  // Address Edit
  Future<AddressEditResponse> addressEditApi(
      String id,
      String type,
      String flatHouseNo,
      String areaSector,
      String nearBy,
      BuildContext context) async {
    AddressEditResponse objEditAddressResponse = AddressEditResponse();
    String editAddressUrl = Environment.baseUrl + Environment.addressEditUrl;
    print("Edit Address url:${editAddressUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> editAddressParams = {
        "id": id,
        "type": type,
        "flat_house_no": flatHouseNo,
        "area_sector": areaSector,
        "nearby": nearBy
      };
      // final encoding = Encoding.getByName('utf-8');

      print("editAddressParams :$editAddressParams ");

      final response = await http.post(Uri.parse(editAddressUrl),
          body: editAddressParams, headers: headers);

      print("edit address body:${response.body}");

      int statusCode = response.statusCode;
      print("edit address statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objEditAddressResponse = addressEditResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objEditAddressResponse;
  }

  //Address Delete
  Future<AddressDeleteResponse> addressDeleteApi(
      String id, BuildContext context) async {
    AddressDeleteResponse objDeleteAddressResponse = AddressDeleteResponse();
    String deleteAddressUrl =
        Environment.baseUrl + Environment.addressDeleteUrl;
    print("Delete Address url:${deleteAddressUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> deleteAddressParams = {
        "id": id,
      };
      // final encoding = Encoding.getByName('utf-8');

      print("deleteAddressParams :$deleteAddressParams ");

      final response = await http.post(Uri.parse(deleteAddressUrl),
          body: deleteAddressParams, headers: headers);

      print("Delete address body:${response.body}");

      int statusCode = response.statusCode;
      print("Delete address statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objDeleteAddressResponse = addressDeleteResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objDeleteAddressResponse;
  }

  // Vehicle List
  Future<VehicleListResponse> vehicleListApi(BuildContext context) async {
    VehicleListResponse objVehicleListResponse = VehicleListResponse(
        // data: VehicleListItem(totalUserVehicle: 0, userVehicles: []));
        data: VehicleListData(totalUserVehicle: 0, userVehicles: []),
        message: '',
        status: 0);

    String vehicleListUrl = Environment.baseUrl + Environment.vehicleListUrl;
    print("Vehicle list url:${vehicleListUrl}");

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      final response = await http.get(
        Uri.parse(vehicleListUrl),
        headers: headers,
      );

      print("Vehicle list body:${response.body}");

      int statusCode = response.statusCode;
      print("Vehicle list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await jsonDecode(response.body);
        objVehicleListResponse = VehicleListResponse.fromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objVehicleListResponse;
  }

  //Vehicle Add
  Future<VehicleAddResponse> vehicleAddApi(
      String vehicleTypeId,
      String carBrandId,
      String carModelId,
      String registrationNo,
      BuildContext context) async {
    VehicleAddResponse objAddVehicleResponse = VehicleAddResponse(
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
    String addVehicleUrl = Environment.baseUrl + Environment.vehicleSaveUrl;
    print("Add Vehicle url:${addVehicleUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> addVehicleParams = {
        "vehicle_type_id": vehicleTypeId,
        "car_brand_id": carBrandId,
        "car_model_id": carModelId,
        "registration_no": registrationNo
      };
      // final encoding = Encoding.getByName('utf-8');

      print("addVehicleParams :$addVehicleParams ");

      final response = await http.post(Uri.parse(addVehicleUrl),
          body: addVehicleParams, headers: headers
          //encoding: encoding,
          );

      print("add vehicle body:${response.body}");

      int statusCode = response.statusCode;
      print("Add address statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objAddVehicleResponse = vehicleAddResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objAddVehicleResponse;
  }

  // Vehicle Edit
  Future<VehicleEditResponse> vehicleEditApi(
      String id,
      String userId,
      String vehicleTypeId,
      String carBrandId,
      String carModelId,
      String registrationNo,
      BuildContext context) async {
    VehicleEditResponse objEditVehicleResponse = VehicleEditResponse(
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
    String editVehicleUrl = Environment.baseUrl + Environment.vehicleEditUrl;
    print("Edit Vehicle url:${editVehicleUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> editVehicleParams = {
        "id": id,
        "user_id": userId,
        "vehicle_type_id": vehicleTypeId.toString(),
        "car_brand_id": carBrandId,
        "car_model_id": carModelId,
        "registration_no": registrationNo
      };
      // final encoding = Encoding.getByName('utf-8');

      print("editVehicleParams :$editVehicleParams ");

      final response = await http.post(Uri.parse(editVehicleUrl),
          body: editVehicleParams, headers: headers);

      print("edit Vehicle body:${response.body}");

      int statusCode = response.statusCode;
      print("edit Vehicle statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objEditVehicleResponse = vehicleEditResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objEditVehicleResponse;
  }

  //Vehicle Delete
  Future<VehicleDeleteResponse> vehicleDeleteApi(
      String id, BuildContext context) async {
    VehicleDeleteResponse objDeleteVehicleResponse = VehicleDeleteResponse(
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
    String deleteVehicleUrl =
        Environment.baseUrl + Environment.vehicleDeleteUrl;
    print("Delete Vehicle url:${deleteVehicleUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> deleteVehicleParams = {
        "id": id,
      };
      // final encoding = Encoding.getByName('utf-8');

      print("deleteVehicleParams :$deleteVehicleParams ");

      final response = await http.post(Uri.parse(deleteVehicleUrl),
          body: deleteVehicleParams, headers: headers);

      print("Delete vehicle body:${response.body}");

      int statusCode = response.statusCode;
      print("Delete vehicle statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objDeleteVehicleResponse = vehicleDeleteResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objDeleteVehicleResponse;
  }

  // Subscription List
  Future<SubscriptionListResponse> subscriptionListApi(
      String carModelId, BuildContext context) async {
    SubscriptionListResponse objSubscriptionListResponse =
        SubscriptionListResponse(message: "", status: 0, data: []);

    String subsListUrl = Environment.baseUrl + Environment.subscriptionListUrl;
    print("Subscription list url:${subsListUrl}");

    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json',
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };

      Map<String, String> subsListParams = {"model_id": carModelId};
      // final encoding = Encoding.getByName('utf-8');

      print("subsListParams :$subsListParams ");
      final response = await http.post(
        Uri.parse(subsListUrl),
        body: subsListParams,
        headers: headers,
      );

      print("Subscription list body:${response.body}");

      int statusCode = response.statusCode;
      print("Subscription list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objSubscriptionListResponse = subscriptionListResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objSubscriptionListResponse;
  }

  //Basic Subscription List
  Future<BasicSubscriptionResponse> baiscSubscriptionApi(
      BuildContext context) async {
    BasicSubscriptionResponse objBasicSubscriptionListResponse =
        BasicSubscriptionResponse(message: "", status: 0, data: []);

    String baiscsubsListUrl =
        Environment.baseUrl + Environment.basicSubscriptionList;
    print("baisc Subscription list url:${baiscsubsListUrl}");

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };

      final response = await http.get(
        Uri.parse(baiscsubsListUrl),
        headers: headers,
      );

      print("basic Subscription list body:${response.body}");

      int statusCode = response.statusCode;
      print("baisc Subscription list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objBasicSubscriptionListResponse =
            basicSubscriptionResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objBasicSubscriptionListResponse;
  }

  //Subscription Details
  Future<SubscriptionDetailsResponse> subscriptionDetailsApi(
      String id, BuildContext context) async {
    SubscriptionDetailsResponse objSubsDetailsResponse =
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
    String subscriptionDetailUrl =
        Environment.baseUrl + Environment.subscriptionDetailUrl;
    print("subscription url:${subscriptionDetailUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> subscriptionParams = {
        "id": id,
      };
      // final encoding = Encoding.getByName('utf-8');

      print("subscriptionParams :$subscriptionParams ");

      final response = await http.post(Uri.parse(subscriptionDetailUrl),
          body: subscriptionParams, headers: headers);

      print("subscription body:${response.body}");

      int statusCode = response.statusCode;
      print("subscription statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objSubsDetailsResponse =
            subscriptionDetailsResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objSubsDetailsResponse;
  }

  // VehicleType List
  Future<VehicleTypeResponse> vehicleTypeListApi(
      String modelId, BuildContext context) async {
    VehicleTypeResponse objVehicleTypeResponse =
        VehicleTypeResponse(message: "", status: 0, data: []);

    String vehicleTypeUrl =
        Environment.baseUrl + Environment.vehicleTypeListUrl;
    print("vehicleType list url:${vehicleTypeUrl}");

    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json',
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> vehicleTypeParams = {"car_model_id": modelId};
      // final encoding = Encoding.getByName('utf-8');

      print("vehicleTypeParams :$vehicleTypeParams ");

      final response = await http.post(
        Uri.parse(vehicleTypeUrl),
        body: vehicleTypeParams,
        headers: headers,
      );

      print("vehicleType list body:${response.body}");

      int statusCode = response.statusCode;
      print("vehicleType list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objVehicleTypeResponse = vehicleTypeResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objVehicleTypeResponse;
  }

  // Car Brand List
  Future<CarBrandResponse> carBrandListApi(BuildContext context) async {
    CarBrandResponse objCarBrandResponse =
        CarBrandResponse(message: "", status: 0, data: []);

    String carBrandUrl = Environment.baseUrl + Environment.carBrandUrl;
    print("carBrandlist url:${carBrandUrl}");

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      final response = await http.get(
        Uri.parse(carBrandUrl),
        headers: headers,
      );

      print("carBrand list body:${response.body}");

      int statusCode = response.statusCode;
      print("carBrand list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objCarBrandResponse = carBrandResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objCarBrandResponse;
  }

  // Car Model List
  Future<CarModelResponse> carModelListApi(
      String carBrandId, BuildContext context) async {
    CarModelResponse objCarModelResponse =
        CarModelResponse(message: "", status: 0, data: []);

    String carModelUrl = Environment.baseUrl + Environment.carModelUrl;
    print("car Model list url:${carModelUrl}");

    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json',
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };

      Map<String, dynamic> carModelParams = {"car_brand_id": carBrandId};

      var body = carModelParams;
      // final encoding = Encoding.getByName('utf-8');

      print(" carModelParams :$body ");
      final response = await http.post(
        Uri.parse(carModelUrl),
        body: body,
        headers: headers,
      );

      print("carModel list body:${response.body}");

      int statusCode = response.statusCode;
      print("carModel list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objCarModelResponse = carModelResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objCarModelResponse;
  }

  // Car Service List
  Future<ServicesResponse> carServiceListApi(BuildContext context) async {
    ServicesResponse objServicesResponse =
        ServicesResponse(message: "", status: 0, data: []);

    String carServicesUrl =
        Environment.baseUrl + Environment.carBasicServiceUrl;
    print("car Services list url:${carServicesUrl}");

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      final response = await http.get(
        Uri.parse(carServicesUrl),
        headers: headers,
      );

      print("car Services list body:${response.body}");

      int statusCode = response.statusCode;
      print("car Services list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objServicesResponse = servicesResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objServicesResponse;
  }

  //Car service Details
  Future<ServiceDetailsResponse> carServiceDetailsApi(
      String id, BuildContext context) async {
    ServiceDetailsResponse objServiceDetailResponse = ServiceDetailsResponse(
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
    String serviceDetailUrl =
        Environment.baseUrl + Environment.carServiceDetailUrl;
    print("service detail url:${serviceDetailUrl}");

    try {
      Map<String, String> headers = {
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, String> serviceDetailParams = {
        "id": id.toString(),
      };
      // final encoding = Encoding.getByName('utf-8');

      print("serviceDetailParams :$serviceDetailParams ");

      final response = await http.post(Uri.parse(serviceDetailUrl),
          body: serviceDetailParams, headers: headers);

      print("service detail body:${response.body}");

      int statusCode = response.statusCode;
      print("service detail statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        objServiceDetailResponse =
            serviceDetailsResponseFromJson(response.body);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objServiceDetailResponse;
  }

  // Profile View
  Future<ProfileViewResponse> profileViewApi(BuildContext context) async {
    ProfileViewResponse objProfileViewResponse = ProfileViewResponse(
        data: ProfileViewData(
          id: 0,
          userType: '',
          status: '',
          email: '',
          countryCode: '',
          mobile: 0,
          latitude: '',
          longitude: '',
          address: ' 0',
          accessToken: '',
          pushNotification: 0,
          notifyMonthlyPayment: 0,
          profileImageUrl: '',
          name: '',
          accountDetails: 0,
        ),
        message: '',
        status: 0);

    String profileViewUrl = Environment.baseUrl + Environment.profileViewUrl;
    print("Profile View url:${profileViewUrl}");

    try {
      final headers = {
        // 'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };

      print("Accesstoken:${Environment.accessToken}");
      final response = await http.get(
        Uri.parse(profileViewUrl),
        headers: headers,
      );

      print("Profile View body:${response.body}");

      int statusCode = response.statusCode;
      print("Profile View statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await jsonDecode(response.body);
        print("profileview_data:$data");
        objProfileViewResponse = ProfileViewResponse.fromJson(data);

        print("profileview_json:${objProfileViewResponse.data}");
        return objProfileViewResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objProfileViewResponse;
  }

  //Profile Update
  Future<ProfileUpdateResponse> profileUpdateApi(
      String name, String email, String mobile, BuildContext context) async {
    ProfileUpdateResponse objProfileUpdateResponse = ProfileUpdateResponse(
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
    String profileUpdateUrl =
        Environment.baseUrl + Environment.profileUpdateUrl;
    print("profile update url:${profileUpdateUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> profileUpdateParams = {
        "name": name,
        "email": email,
        "mobile": mobile
      };

      var body = profileUpdateParams;
      // final encoding = Encoding.getByName('utf-8');

      print("profileUpdateParams :$body ");

      final response = await http.post(Uri.parse(profileUpdateUrl),
          body: body, headers: headers);

      print("profile update body:${response.body}");

      int statusCode = response.statusCode;
      print("profile update statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objProfileUpdateResponse =
            ProfileUpdateResponse.fromJson(jsonDecode(response.body));

        print("objProfileUpdateResponse:${objProfileUpdateResponse.data}");
        return objProfileUpdateResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objProfileUpdateResponse;
  }

  //About Us
  Future<AboutUsResponse> aboutUsApi(String slug, BuildContext context) async {
    AboutUsResponse objAboutUsResponse = AboutUsResponse(
      message: '',
      status: 0,
      data: AboutUsdata(slug: '', tittle: '', description: ''),
    );
    String aboutUsUrl = Environment.baseUrl + Environment.aboutUsUrl;
    print("about Us url:${aboutUsUrl}");

    try {
      final headers = {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        //  'Charset': 'utf-8',
        // 'Authorization': 'Bearer ${Environment.accessToken}'
      };

      Map<String, String> aboutUsParams = {
        "slug": slug,
      };
      // final encoding = Encoding.getByName('utf-8');

      print("aboutUsParams :$aboutUsParams ");

      final response = await http.post(Uri.parse(aboutUsUrl),
          body: aboutUsParams, headers: headers);

      print("about Us body:${response.body}");

      int statusCode = response.statusCode;
      print("about us statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // objAboutUsResponse = aboutUsResponseFromJson(response.body);
        objAboutUsResponse =
            AboutUsResponse.fromJson(jsonDecode(response.body));
        return objAboutUsResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objAboutUsResponse;
  }

  //Contact Us

  Future<ContactUsResponse> contactUsApi(
      String serviceName, String message, BuildContext context) async {
    ContactUsResponse objContactUsResponse = ContactUsResponse();
    String contactUsUrl = Environment.baseUrl + Environment.contactUsUrl;
    print("contact us url:${contactUsUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> contactUsParams = {
        "service_name": serviceName,
        "message": message
      };

      var body = contactUsParams;
      // final encoding = Encoding.getByName('utf-8');

      print("contactUsParams :$body ");

      final response = await http.post(Uri.parse(contactUsUrl),
          body: body, headers: headers);

      print("contact us body:${response.body}");

      int statusCode = response.statusCode;
      print("contact us statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objContactUsResponse =
            ContactUsResponse.fromJson(jsonDecode(response.body));

        print("objContactUsResponse:${objContactUsResponse.data}");
        return objContactUsResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objContactUsResponse;
  }

  //Subscription Add

  Future<UserSubscriptionAddResponse> subscriptionAddApi(
      String userVehicleId,
      String userAddressId,
      String subscriptionId,
      String amount,
      BuildContext context) async {
    UserSubscriptionAddResponse objSubsAddResponse =
        UserSubscriptionAddResponse();
    String subsAddUrl = Environment.baseUrl + Environment.subscriptionAdd;
    print("subscription Add url:${subsAddUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> subsAddParams = {
        "user_vehicle_id": userVehicleId,
        "user_address_id": userAddressId,
        "subscription_id": subscriptionId,
        "amount": amount,
        "transaction_status": "Success",
        "payment_status": "Paid"
      };

      var body = subsAddParams;
      // final encoding = Encoding.getByName('utf-8');

      print("subsAddParams :$body ");

      final response =
          await http.post(Uri.parse(subsAddUrl), body: body, headers: headers);

      print("subs Add body:${response.body}");

      int statusCode = response.statusCode;
      print("subs add  statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");

        objSubsAddResponse =
            UserSubscriptionAddResponse.fromJson(jsonDecode(response.body));

        print("objSubsAddResponse:${objSubsAddResponse.data}");

        return objSubsAddResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objSubsAddResponse;
  }

  //User Subscription List

  Future<UserSubscriptionListResponse> userSubsListApi(
      BuildContext context) async {
    UserSubscriptionListResponse objUserSubsListResponse =
        UserSubscriptionListResponse(data: [], message: '', status: 0);

    String userSubsListUrl =
        Environment.baseUrl + Environment.mySubscriptionList;
    print("userSubsListUrl  url:${userSubsListUrl}");

    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json',
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      //  Map<String, dynamic> mySubListParams = {"month": month};

      // var body = mySubListParams;
      // // final encoding = Encoding.getByName('utf-8');
      //
      // print("mySubListParams :$body ");
      final response = await http.post(
        Uri.parse(userSubsListUrl),
        //  body: body,
        headers: headers,
      );

      print("userSubsList body:${response.body}");

      int statusCode = response.statusCode;
      print("user subs  list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objUserSubsListResponse = userSubscriptionListResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objUserSubsListResponse;
  }

  //Reports List

  Future<ReportsListResponse> reportsListApi(
      String month, BuildContext context) async {
    ReportsListResponse objReportsListResponse = ReportsListResponse(data: []);
    String reportsListUrl = Environment.baseUrl + Environment.reportsListUrl;
    print("reportsListUrl:${reportsListUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> reportsListParams = {"month": month};

      var body = reportsListParams;
      // final encoding = Encoding.getByName('utf-8');

      print("reportsListParams :$body ");

      final response = await http.post(Uri.parse(reportsListUrl),
          body: body, headers: headers);

      print("reports list body:${response.body}");

      int statusCode = response.statusCode;
      print("reports list  statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objReportsListResponse =
            ReportsListResponse.fromJson(jsonDecode(response.body));

        print("objReportsListResponse:${objReportsListResponse.data}");
        return objReportsListResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objReportsListResponse;
  }

  //Special Request List

  Future<SpecialRequestListResponse> specialRequestListApi(
      String month, BuildContext context) async {
    SpecialRequestListResponse objSpecialListResponse =
        SpecialRequestListResponse(data: [], message: '', status: 0);
    String specialRequestListUrl =
        Environment.baseUrl + Environment.specialRequestListUrl;
    print("specialRequestListUrl:${specialRequestListUrl}");

    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json',
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> mySpecialReqListParams = {"month": month};

      var body = mySpecialReqListParams;
      // final encoding = Encoding.getByName('utf-8');

      print("mySpecialReqListParams :$body ");

      final response = await http.post(Uri.parse(specialRequestListUrl),
          body: body, headers: headers);

      print("special request list body:${response.body}");

      int statusCode = response.statusCode;
      print("special Request list  statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        // final List body = json.decode(response.body);
        // return body.map((e) => SpecialRequestListResponse.fromJson(e)).toList();

        objSpecialListResponse =
            SpecialRequestListResponse.fromJson(json.decode(response.body));

        print("objSpecialListResponse :${objSpecialListResponse.data}");
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objSpecialListResponse;
  }

  //Special Request Add

  Future<SpecialRequestAddResponse> specialRequestAddApi(
      String userVehicleId,
      String userAddressId,
      String message,
      String requestDate,
      String amount,
      String serviceId,
      BuildContext context) async {
    SpecialRequestAddResponse objSpecialAddResponse =
        SpecialRequestAddResponse();
    String specialRequestAddUrl =
        Environment.baseUrl + Environment.specialRequestAddUrl;
    print("specialRequestAddUrl:${specialRequestAddUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> specialReqAddParams = {
        "user_vehicle_id": userVehicleId,
        "user_address_id": userAddressId,
        "message": message,
        "request_date": requestDate,
        "amount": amount.toString(),
        "service_id": serviceId.toString(),
        "transaction_status": "Success",
        "payment_status": "Paid"
      };

      var body = specialReqAddParams;
      // final encoding = Encoding.getByName('utf-8');

      print("specialReqAddParams :$body ");

      final response = await http.post(Uri.parse(specialRequestAddUrl),
          body: body, headers: headers);

      print("special request add body:${response.body}");

      int statusCode = response.statusCode;
      print("special Request add  statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objSpecialAddResponse =
            SpecialRequestAddResponse.fromJson(jsonDecode(response.body));

        print("objSpecialAddResponse :${objSpecialAddResponse.data}");
        return objSpecialAddResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objSpecialAddResponse;
  }

  //Special Request Delete

  Future<SpecialRequestDeleteResponse> specialRequestDeleteApi(
      String id, BuildContext context) async {
    SpecialRequestDeleteResponse objSpecialDeleteResponse =
        SpecialRequestDeleteResponse();
    String specialRequestDeleteUrl =
        Environment.baseUrl + Environment.specialRequestDeleteUrl;
    print("specialRequestDeleteUrl:${specialRequestDeleteUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> specialReqDeleteParams = {"id": id};

      var body = specialReqDeleteParams;
      // final encoding = Encoding.getByName('utf-8');

      print("specialReqDeleteParams :$body ");

      final response = await http.post(Uri.parse(specialRequestDeleteUrl),
          body: body, headers: headers);

      print("special request Delete body:${response.body}");

      int statusCode = response.statusCode;
      print("special Request Delete  statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objSpecialDeleteResponse =
            SpecialRequestDeleteResponse.fromJson(jsonDecode(response.body));

        print("objSpecialDeleteResponse :${objSpecialDeleteResponse.data}");
        return objSpecialDeleteResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objSpecialDeleteResponse;
  }

  //Dashboard

  Future<DashboardResponse> dashboardApi(BuildContext context) async {
    DashboardResponse objDashboardResponse = DashboardResponse(
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
          ),
        ));
    String dashboardUrl = Environment.baseUrl + Environment.dashboardUrl;
    print("Dashboard Url:${dashboardUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      // Map<String, dynamic> dashboardParams = {
      //   "booking_id": bookingId,
      //   "icon": icon,
      //   "rating": rating,
      //   "feedback": feedback
      // };

      //var body = dashboardParams;
      // final encoding = Encoding.getByName('utf-8');

      // print("dashboardParams :$body ");

      final response =
          await http.post(Uri.parse(dashboardUrl), headers: headers);

      print("dashboard body:${response.body}");

      int statusCode = response.statusCode;
      print("dashboard statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objDashboardResponse =
            DashboardResponse.fromJson(jsonDecode(response.body));

        print("objDashboardResponse:${objDashboardResponse.data}");
        return objDashboardResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objDashboardResponse;
  }

  //Read Notification
  Future<ReadNotificationResponse> readNotificationApi(
      String id, BuildContext context) async {
    ReadNotificationResponse objReadNotificationResponse =
        ReadNotificationResponse();
    String readNotificationUrl =
        Environment.baseUrl + Environment.readNotificationUrl;
    print("Read Notification url:${readNotificationUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> readNotificationParams = {"id": id};

      var body = readNotificationParams;
      // final encoding = Encoding.getByName('utf-8');

      print("readNotificationParams :$body ");

      final response = await http.post(Uri.parse(readNotificationUrl),
          body: body, headers: headers);

      print("read Notification body:${response.body}");

      int statusCode = response.statusCode;
      print("Read Notification statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objReadNotificationResponse =
            ReadNotificationResponse.fromJson(jsonDecode(response.body));

        print(
            "objReadNotificationResponse:${objReadNotificationResponse.data}");
        return objReadNotificationResponse;
      } else if (statusCode == 500) {}
    } catch (e) {
      throw Exception(e);
    }
    return objReadNotificationResponse;
  }

  //Delete Notification
  Future<DeleteNotificationResponse> deleteNotificationApi(
      String receiverId, BuildContext context) async {
    DeleteNotificationResponse objDeleteNotificationResponse =
        DeleteNotificationResponse();
    String deleteNotificationUrl =
        Environment.baseUrl + Environment.deleteNotificationUrl;
    print("Delete Notification url:${deleteNotificationUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> deleteNotificationParams = {"id": receiverId};

      var body = deleteNotificationParams;
      // final encoding = Encoding.getByName('utf-8');

      print("DeleteNotificationParams :$body ");

      final response = await http.post(Uri.parse(deleteNotificationUrl),
          body: body, headers: headers);

      print("Delete Notification body:${response.body}");

      int statusCode = response.statusCode;
      print("Delete Notification statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objDeleteNotificationResponse =
            DeleteNotificationResponse.fromJson(jsonDecode(response.body));

        print(
            "objDeleteNotificationResponse:${objDeleteNotificationResponse.data}");
        return objDeleteNotificationResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pushNamed('/login');
      } else if (statusCode == 422) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pushNamed('/dashboard');
      }
    } catch (e) {
      throw Exception(e);
    }
    return objDeleteNotificationResponse;
  }

  //List Notification
  Future<UnreadNotificationResponse> listNotificationApi(
      String status, BuildContext context) async {
    UnreadNotificationResponse objUnreadNotificationResponse =
        UnreadNotificationResponse(data: [], message: '', status: 0);
    String listNotificationUrl =
        Environment.baseUrl + Environment.listNotificationUrl;
    print("list Notification url:${listNotificationUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> listNotificationParams = {"status": status};

      var body = listNotificationParams;
      // final encoding = Encoding.getByName('utf-8');

      print("ListNotificationParams :$body ");

      final response = await http.post(Uri.parse(listNotificationUrl),
          body: body, headers: headers);

      print("List Notification body:${response.body}");

      int statusCode = response.statusCode;
      print("List Notification statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objUnreadNotificationResponse =
            UnreadNotificationResponse.fromJson(jsonDecode(response.body));

        print(
            "objUnreadNotificationResponse:${objUnreadNotificationResponse.data}");
        return objUnreadNotificationResponse;
      } else if (statusCode == 500) {}
    } catch (e) {
      throw Exception(e);
    }
    return objUnreadNotificationResponse;
  }

  //Notification Status
  Future<NotificationStatusResponse> notificationStatusApi(
      String pushNotification, BuildContext context) async {
    NotificationStatusResponse objNotificationStatusResponse =
        NotificationStatusResponse(data: NotificationData());
    String notificationStatusUrl =
        Environment.baseUrl + Environment.notificationStatusUrl;
    print("Notification Status url:${notificationStatusUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> notificationStatusParams = {
        "push_notification": pushNotification,
        "notify_monthly_payment": "0"
      };

      var body = notificationStatusParams;
      // final encoding = Encoding.getByName('utf-8');

      print("notification Status Params :$body ");

      final response = await http.post(Uri.parse(notificationStatusUrl),
          body: body, headers: headers);

      print("Notification Status body:${response.body}");

      int statusCode = response.statusCode;
      print("Notification Status statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objNotificationStatusResponse =
            NotificationStatusResponse.fromJson(jsonDecode(response.body));

        Environment.notificationStatus =
            objNotificationStatusResponse.data.pushNotification.toString();

        print(
            "objNotificationStatusResponse:${objNotificationStatusResponse.data}");
        return objNotificationStatusResponse;
      } else if (statusCode == 500) {}
    } catch (e) {
      throw Exception(e);
    }
    return objNotificationStatusResponse;
  }

  //RateWash
  Future<RateWashResponse> rateWashApi(String bookingId, String icon,
      String rating, String feedback, BuildContext context) async {
    RateWashResponse objRateWashResponse = RateWashResponse(
        data: RateWashDataItems(icon: '', rating: '', feedback: '', media: []));
    String rateWashUrl = Environment.baseUrl + Environment.rateWashUrl;
    print("RateWash url:${rateWashUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> rateWashParams = {
        "booking_id": bookingId,
        "icon": icon,
        "rating": rating,
        "feedback": feedback
      };

      var body = rateWashParams;
      // final encoding = Encoding.getByName('utf-8');

      print("rateWashParams :$body ");

      final response =
          await http.post(Uri.parse(rateWashUrl), body: body, headers: headers);

      print("Notification Status body:${response.body}");

      int statusCode = response.statusCode;
      print("Notification Status statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objRateWashResponse =
            RateWashResponse.fromJson(jsonDecode(response.body));

        return objRateWashResponse;
      } else if (statusCode == 500) {}
    } catch (e) {
      throw Exception(e);
    }
    return objRateWashResponse;
  }

  //User Service  List

  Future<SpecialRequestListResponse> userServiceListApi(
      String month, BuildContext context) async {
    SpecialRequestListResponse objUserServiceListResponse =
        SpecialRequestListResponse(data: [], message: '', status: 0);
    String userServiceListUrl =
        Environment.baseUrl + Environment.userServiceListUrl;
    print("userServiceListUrl:${userServiceListUrl}");

    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json',
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> myServiceListParams = {"month": month};

      var body = myServiceListParams;
      // final encoding = Encoding.getByName('utf-8');

      print("myServiceListParams :$body ");

      final response = await http.post(Uri.parse(userServiceListUrl),
          body: body, headers: headers);

      print("user Service list body:${response.body}");

      int statusCode = response.statusCode;
      print("user Service list  statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        // final List body = json.decode(response.body);
        // return body.map((e) => SpecialRequestListResponse.fromJson(e)).toList();

        objUserServiceListResponse =
            SpecialRequestListResponse.fromJson(json.decode(response.body));

        print("objUserServiceListResponse :${objUserServiceListResponse.data}");
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objUserServiceListResponse;
  }

  //User Service Add

  Future<SpecialRequestAddResponse> userServiceAddApi(
      String userVehicleId,
      String userAddressId,
      String amount,
      String serviceId,
      BuildContext context) async {
    SpecialRequestAddResponse objUserServiceAddResponse =
        SpecialRequestAddResponse();
    String userServiceAddUrl =
        Environment.baseUrl + Environment.userServiceAddUrl;
    print("userServiceAddUrl:${userServiceAddUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> userServiceAddParams = {
        "user_vehicle_id": userVehicleId,
        "user_address_id": userAddressId,
        "amount": amount.toString(),
        "service_id": serviceId.toString(),
        "transaction_status": "Success",
        "payment_status": "Paid"
      };

      var body = userServiceAddParams;
      // final encoding = Encoding.getByName('utf-8');

      print("userServiceAddParams :$body ");

      final response = await http.post(Uri.parse(userServiceAddUrl),
          body: body, headers: headers);

      print("user service add body:${response.body}");

      int statusCode = response.statusCode;
      print("user service add  statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objUserServiceAddResponse =
            SpecialRequestAddResponse.fromJson(jsonDecode(response.body));

        print("objUserServiceAddResponse :${objUserServiceAddResponse.data}");
        return objUserServiceAddResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objUserServiceAddResponse;
  }

  //Selected service list

  Future<ServiceDetailListResponse> servicePriceApi(
      String carModelId, BuildContext context) async {
    ServiceDetailListResponse objServicePriceResponse =
        ServiceDetailListResponse(data: [], message: '', status: 200);
    String servicePriceUrl =
        Environment.baseUrl + Environment.carServicePriceUrl;
    print("service price url:${servicePriceUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> servicePriceParams = {"model_id": carModelId};

      var body = servicePriceParams;
      // final encoding = Encoding.getByName('utf-8');

      print("servicePriceParams :$body ");

      final response = await http.post(Uri.parse(servicePriceUrl),
          body: body, headers: headers);

      print("service price body:${response.body}");

      int statusCode = response.statusCode;
      print("service price statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objServicePriceResponse =
            ServiceDetailListResponse.fromJson(jsonDecode(response.body));

        print("objServicePriceResponse:${objServicePriceResponse.data}");
        return objServicePriceResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objServicePriceResponse;
  }

  //Renew Subscription

  Future<RenewSubsResponse> renewSubsApi(
      String userVehicleId,
      String userAddressId,
      String subsId,
      String fromDate,
      String amount,
      BuildContext context) async {
    RenewSubsResponse objRenewResponse =
        RenewSubsResponse(data: RenewSubsData());
    String renewUrl = Environment.baseUrl + Environment.renewSubscriptionList;
    print("renew url:${renewUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> renewParams = {
        "user_vehicle_id": userVehicleId,
        "user_address_id": userAddressId,
        "subscription_id": subsId,
        "from_date": fromDate,
        "amount": amount,
        "transaction_status": "Success",
        "payment_status": "Paid"
      };

      var body = renewParams;
      // final encoding = Encoding.getByName('utf-8');

      print("renewParams :$body ");

      final response =
          await http.post(Uri.parse(renewUrl), body: body, headers: headers);

      print("renew body:${response.body}");

      int statusCode = response.statusCode;
      print("renewstatusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objRenewResponse =
            RenewSubsResponse.fromJson(jsonDecode(response.body));

        print("objrenewResponse:${objRenewResponse.data}");
        return objRenewResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objRenewResponse;
  }

  //Check User Vehicle

  Future<CheckUserVehicleResponse> checkUserVehicleApi(
      String id, BuildContext context) async {
    CheckUserVehicleResponse objCheckUserVehicleResponse =
        CheckUserVehicleResponse(data: CheckUserVehicleData());
    String checkUserVehicleUrl =
        Environment.baseUrl + Environment.checkUserVehicleUrl;
    print("checkUserVehicle url:${checkUserVehicleUrl}");

    try {
      final headers = {
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      Map<String, dynamic> checkUserVehicleParams = {"id": id};

      var body = checkUserVehicleParams;
      // final encoding = Encoding.getByName('utf-8');

      print("checkUserVehicleParams :$body ");

      final response = await http.post(Uri.parse(checkUserVehicleUrl),
          body: body, headers: headers);

      print("renew body:${response.body}");

      int statusCode = response.statusCode;
      print("renewstatusCode: ${response.statusCode}");

      if (statusCode == 200) {
        // var data = await jsonDecode(response.body);
        // print("profileupdate_data:$data");
        objCheckUserVehicleResponse =
            CheckUserVehicleResponse.fromJson(jsonDecode(response.body));

        print(
            "objCheckUserVehicleResponse:${objCheckUserVehicleResponse.data}");
        return objCheckUserVehicleResponse;
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objCheckUserVehicleResponse;
  }

  //User Upcoming Subscription List

  Future<UpcomingSubscriptionResponse> userUpcomingSubsListApi(
      BuildContext context) async {
    UpcomingSubscriptionResponse objUserUpcomingSubsListResponse =
        UpcomingSubscriptionResponse(data: [], message: '', status: 0);

    String userUpcomingSubsListUrl =
        Environment.baseUrl + Environment.myUpcomingSubscriptionList;
    print("userSubsListUrl  url:${userUpcomingSubsListUrl}");

    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json',
        // 'Charset': 'utf-8',
        'Authorization': 'Bearer ${Environment.accessToken}'
      };
      //  Map<String, dynamic> mySubListParams = {"month": month};

      // var body = mySubListParams;
      // // final encoding = Encoding.getByName('utf-8');
      //
      // print("mySubListParams :$body ");
      final response = await http.get(
        Uri.parse(userUpcomingSubsListUrl),
        //  body: body,
        headers: headers,
      );

      print("userUpcomingSubsList body:${response.body}");

      int statusCode = response.statusCode;
      print("user subs Upcoming list statusCode: ${response.statusCode}");

      if (statusCode == 200) {
        var data = await json.decode(json.encode(response.body));
        objUserUpcomingSubsListResponse =
            upcomingSubscriptionResponseFromJson(data);
      } else if (statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong.Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(
              mobile: '',
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return objUserUpcomingSubsListResponse;
  }
}
