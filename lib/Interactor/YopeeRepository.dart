import 'package:flutter/cupertino.dart';
import 'package:yopee_customer/Entity/Response/Address/AddressListResponse.dart';
import 'package:yopee_customer/Entity/Response/Profile/ProfileViewResponse.dart';
import 'package:yopee_customer/Entity/Response/Services/ServicesResponse.dart';
import 'package:yopee_customer/Entity/Response/SpecialRequest/SpecialRequestListResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/SubscriptionDetailsResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/UserSubscriptionAddResponse.dart';
import 'package:yopee_customer/Entity/Response/Subscription/UserSubscriptionListResponse.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/CarBrandResponse.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/CarModelResponse.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleTypeResponse.dart';
import 'package:yopee_customer/Entity/UpcomingSubscriptionResponse.dart';
import 'package:yopee_customer/Interactor/ApiClient.dart';

import '../Entity/CheckUserVehicleResponse.dart';
import '../Entity/Response/AboutUsResponse.dart';
import '../Entity/Response/Address/AddressAddResponse.dart';
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
import '../Entity/Response/Otp/otpResponse.dart';
import '../Entity/Response/Profile/ProfileUpdateResponse.dart';
import '../Entity/Response/RateWashResponse.dart';
import '../Entity/Response/ReportsListResponse.dart';
import '../Entity/Response/Services/ServiceDetailListResponse.dart';
import '../Entity/Response/Services/ServiceDetailsResponse.dart';
import '../Entity/Response/SpecialRequest/SpecialRequestAddResponse.dart';
import '../Entity/Response/SpecialRequest/SpecialRequestDeleteResponse.dart';
import '../Entity/Response/Subscription/BasicSubscriptionResponse.dart';
import '../Entity/Response/Subscription/RenewSubsResponse.dart';
import '../Entity/Response/Subscription/SubscriptionListResponse.dart';
import '../Entity/Response/Vehicle/VehicleAddResponse.dart';
import '../Entity/Response/Vehicle/VehicleDeleteResponse.dart';
import '../Entity/Response/Vehicle/VehicleEditResponse.dart';
import '../Entity/Response/Vehicle/VehicleListResponse.dart';

class YopeeRepository {
  final YopeeApiClient yopeeApiClient = YopeeApiClient();
//login
  Future<LoginResponse> loginRepo(String mobile) async {
    try {
      final loginResponse = await yopeeApiClient.loginApi(mobile);
      return loginResponse;
    } catch (e) {
      print("login error:$e");
      rethrow;
    }
  }

  //logout
  Future<LogoutResponse> logoutRepo(String mobile) async {
    try {
      final logoutResponse = await yopeeApiClient.logoutApi(mobile);
      return logoutResponse;
    } catch (e) {
      print("logout error:$e");
      rethrow;
    }
  }

  //Otp Verify
  Future<OtpResponse> otpRepo(String userID, String otpNumber) async {
    try {
      final otpResponse = await yopeeApiClient.otpVerifyApi(userID, otpNumber);
      return otpResponse;
    } catch (e) {
      print("otp error:$e");
      rethrow;
    }
  }

  //Address List
  Future<AddressListResponse> addressListRepo(BuildContext context) async {
    try {
      final addressListResponse = await yopeeApiClient.addressListApi(context);
      return addressListResponse;
    } catch (e) {
      print("address list error:$e");
      rethrow;
    }
  }

  //Address Add
  Future<AddressAddResponse> addressAddRepo(String type, String flatHouseNo,
      String areaSector, String nearBy, BuildContext context) async {
    try {
      final addressAddResponse = await yopeeApiClient.addressAddApi(
          type, flatHouseNo, areaSector, nearBy, context);
      return addressAddResponse;
    } catch (e) {
      print("address add error:$e");
      rethrow;
    }
  }

  //Address Edit
  Future<AddressEditResponse> addressEditRepo(
      String id,
      String type,
      String flatHouseNo,
      String areaSector,
      String nearBy,
      BuildContext context) async {
    try {
      final addressEditResponse = await yopeeApiClient.addressEditApi(
          id, type, flatHouseNo, areaSector, nearBy, context);
      return addressEditResponse;
    } catch (e) {
      print("address edit error:$e");
      rethrow;
    }
  }

  //Address Delete
  Future<AddressDeleteResponse> addressDeleteRepo(
      String id, BuildContext context) async {
    try {
      final addressDeleteResponse =
          await yopeeApiClient.addressDeleteApi(id, context);
      return addressDeleteResponse;
    } catch (e) {
      print("address delete error:$e");
      rethrow;
    }
  }

  //Vehicle List
  Future<VehicleListResponse> vehicleListRepo(BuildContext context) async {
    try {
      final vehicleListResponse = await yopeeApiClient.vehicleListApi(context);
      return vehicleListResponse;
    } catch (e) {
      print("vehicle list error:$e");
      rethrow;
    }
  }

  //Vehicle Add
  Future<VehicleAddResponse> vehicleAddRepo(
      String vehicleTypeId,
      String carBrandId,
      String carModelId,
      String registrationNo,
      BuildContext context) async {
    try {
      final vehicleAddResponse = await yopeeApiClient.vehicleAddApi(
          vehicleTypeId, carBrandId, carModelId, registrationNo, context);
      return vehicleAddResponse;
    } catch (e) {
      print("vehicle add error:$e");
      rethrow;
    }
  }

  //Vehicle Edit
  Future<VehicleEditResponse> vehicleEditRepo(
      String id,
      String userId,
      String vehicleTypeId,
      String carBrandId,
      String carModelId,
      String registrationNo,
      BuildContext context) async {
    try {
      final vehicleEditResponse = await yopeeApiClient.vehicleEditApi(
          id,
          userId,
          vehicleTypeId,
          carBrandId,
          carModelId,
          registrationNo,
          context);
      return vehicleEditResponse;
    } catch (e) {
      print("vehicle edit error:$e");
      rethrow;
    }
  }

  //Vehicle Delete
  Future<VehicleDeleteResponse> vehicleDeleteRepo(
      String id, BuildContext context) async {
    try {
      final vehicleDeleteResponse =
          await yopeeApiClient.vehicleDeleteApi(id, context);
      return vehicleDeleteResponse;
    } catch (e) {
      print("vehicle delete error:$e");
      rethrow;
    }
  }

  //Subscription List
  Future<SubscriptionListResponse> subscriptionListRepo(
      String carModelId, BuildContext context) async {
    try {
      final subsListResponse =
          await yopeeApiClient.subscriptionListApi(carModelId, context);
      return subsListResponse;
    } catch (e) {
      print("Subscription list error:$e");
      rethrow;
    }
  }

  //Basic Subscription List
  Future<BasicSubscriptionResponse> baiscsubscriptionListRepo(
      BuildContext context) async {
    try {
      final basicsubsListResponse =
          await yopeeApiClient.baiscSubscriptionApi(context);
      return basicsubsListResponse;
    } catch (e) {
      print("Basic Subscription list error:$e");
      rethrow;
    }
  }

  //Subscription Details
  Future<SubscriptionDetailsResponse> subsDetailsRepo(
      String id, BuildContext context) async {
    try {
      final subsDetailResponse =
          await yopeeApiClient.subscriptionDetailsApi(id, context);
      return subsDetailResponse;
    } catch (e) {
      print("Subscription Details error:$e");
      rethrow;
    }
  }

  //Vehicle Type List
  Future<VehicleTypeResponse> vehicleTypeListRepo(
      String modelId, BuildContext context) async {
    try {
      final vehicleTypeListResponse =
          await yopeeApiClient.vehicleTypeListApi(modelId, context);
      return vehicleTypeListResponse;
    } catch (e) {
      print("Vehicle Type list error:$e");
      rethrow;
    }
  }

  //Service Price List
  Future<ServiceDetailListResponse> servicePriceListRepo(
      String carModelId, BuildContext context) async {
    try {
      final servicePriceListResponse =
          await yopeeApiClient.servicePriceApi(carModelId, context);
      return servicePriceListResponse;
    } catch (e) {
      print("service  Price list error:$e");
      rethrow;
    }
  }

  //Car Brand List
  Future<CarBrandResponse> carBrandListRepo(BuildContext context) async {
    try {
      final carBrandListResponse =
          await yopeeApiClient.carBrandListApi(context);
      return carBrandListResponse;
    } catch (e) {
      print("Car Brand list error:$e");
      rethrow;
    }
  }

  //Car Model List
  Future<CarModelResponse> carModelListRepo(
      String carBrandId, BuildContext context) async {
    try {
      final carModelListResponse =
          await yopeeApiClient.carModelListApi(carBrandId, context);
      return carModelListResponse;
    } catch (e) {
      print("Car Model list error:$e");
      rethrow;
    }
  }

  //Car Service List
  Future<ServicesResponse> carServiceListRepo(BuildContext context) async {
    try {
      final carServiceListResponse =
          await yopeeApiClient.carServiceListApi(context);
      return carServiceListResponse;
    } catch (e) {
      print("Car Service list error:$e");
      rethrow;
    }
  }

  //Car service Details
  Future<ServiceDetailsResponse> serviceDetailsRepo(
      String id, BuildContext context) async {
    try {
      final serviceDetailResponse =
          await yopeeApiClient.carServiceDetailsApi(id, context);
      return serviceDetailResponse;
    } catch (e) {
      print("Service Details error:$e");
      rethrow;
    }
  }

  //Profile View
  Future<ProfileViewResponse> profileViewRepo(BuildContext context) async {
    try {
      final profileViewResponse = await yopeeApiClient.profileViewApi(context);
      return profileViewResponse;
    } catch (e) {
      print("profileView error:$e");
      rethrow;
    }
  }

  //Profile Update
  Future<ProfileUpdateResponse> profileUpdateRepo(
      String name, String email, String mobile, BuildContext context) async {
    try {
      final profileUpdateResponse =
          await yopeeApiClient.profileUpdateApi(name, email, mobile, context);
      return profileUpdateResponse;
    } catch (e) {
      print("profile update error:$e");
      rethrow;
    }
  }

  //About Us
  Future<AboutUsResponse> aboutUsRepo(String slug, BuildContext context) async {
    try {
      final aboutUsResponse = await yopeeApiClient.aboutUsApi(slug, context);
      return aboutUsResponse;
    } catch (e) {
      print("about Us error:$e");
      rethrow;
    }
  }

  //Contact us
  Future<ContactUsResponse> contactUsRepo(
      String serviceName, String message, BuildContext context) async {
    try {
      final contactUsResponse =
          await yopeeApiClient.contactUsApi(serviceName, message, context);
      return contactUsResponse;
    } catch (e) {
      print("contact us error:$e");
      rethrow;
    }
  }

  //Subscription Add
  Future<UserSubscriptionAddResponse> subsAddRepo(
      String userVehicleId,
      String userAddressId,
      String subscriptionId,
      String amount,
      BuildContext context) async {
    try {
      final subsAddResponse = await yopeeApiClient.subscriptionAddApi(
          userVehicleId, userAddressId, subscriptionId, amount, context);
      return subsAddResponse;
    } catch (e) {
      print("subs Add error:$e");
      rethrow;
    }
  }

  //User Subscription List
  Future<UserSubscriptionListResponse> userSubsListRepo(
      BuildContext context) async {
    try {
      final userSubsListResponse =
          await yopeeApiClient.userSubsListApi(context);
      return userSubsListResponse;
    } catch (e) {
      print("User Subscription  list error:$e");
      rethrow;
    }
  }

  //Reports List
  Future<ReportsListResponse> reportsListRepo(
      String month, BuildContext context) async {
    try {
      final reportsListResponse =
          await yopeeApiClient.reportsListApi(month, context);
      return reportsListResponse;
    } catch (e) {
      print("Reports  list error:$e");
      rethrow;
    }
  }

  //Special Request List
  Future<SpecialRequestListResponse> specialReqListRepo(
      String month, BuildContext context) async {
    try {
      final specialReqListResponse =
          await yopeeApiClient.specialRequestListApi(month, context);
      return specialReqListResponse;
    } catch (e) {
      print("Special request  list error:$e");
      rethrow;
    }
  }

  //Special Request Add
  Future<SpecialRequestAddResponse> specialReqAddRepo(
      String userVehicleId,
      String userAddressId,
      String message,
      String requestDate,
      String amount,
      String serviceId,
      BuildContext context) async {
    try {
      final specialReqAddResponse = await yopeeApiClient.specialRequestAddApi(
          userVehicleId,
          userAddressId,
          message,
          requestDate,
          amount,
          serviceId,
          context);
      return specialReqAddResponse;
    } catch (e) {
      print("Special request  add error:$e");
      rethrow;
    }
  }

  //Special Request Delete
  Future<SpecialRequestDeleteResponse> specialReqDeleteRepo(
      String id, BuildContext context) async {
    try {
      final specialReqDeleteResponse =
          await yopeeApiClient.specialRequestDeleteApi(id, context);
      return specialReqDeleteResponse;
    } catch (e) {
      print("Special request  Delete error:$e");
      rethrow;
    }
  }

  //Dashboard
  Future<DashboardResponse> dashboardRepo(BuildContext context) async {
    try {
      final dashboardResponse = await yopeeApiClient.dashboardApi(context);
      return dashboardResponse;
    } catch (e) {
      print("Dashboard error:$e");
      rethrow;
    }
  }

  //Read Notification
  Future<ReadNotificationResponse> readNotificationRepo(
      String id, BuildContext context) async {
    try {
      final readNotificationResponse =
          await yopeeApiClient.readNotificationApi(id, context);
      return readNotificationResponse;
    } catch (e) {
      print("read Notification error:$e");
      rethrow;
    }
  }

  //Delete Notification
  Future<DeleteNotificationResponse> deleteNotificationRepo(
      String receiverId, BuildContext context) async {
    try {
      final deleteNotificationResponse =
          await yopeeApiClient.deleteNotificationApi(receiverId, context);
      return deleteNotificationResponse;
    } catch (e) {
      print("Delete Notification error:$e");
      rethrow;
    }
  }

  //List Notification
  Future<UnreadNotificationResponse> listNotificationRepo(
      String status, BuildContext context) async {
    try {
      final listNotificationResponse =
          await yopeeApiClient.listNotificationApi(status, context);
      return listNotificationResponse;
    } catch (e) {
      print("List Notification error:$e");
      rethrow;
    }
  }

  // Notification Status
  Future<NotificationStatusResponse> notificationStatusRepo(
      String pushNotification, BuildContext context) async {
    try {
      final notificationStatusResponse =
          await yopeeApiClient.notificationStatusApi(pushNotification, context);
      return notificationStatusResponse;
    } catch (e) {
      print("Notification Status error:$e");
      rethrow;
    }
  }

  // Rate Wash
  Future<RateWashResponse> rateWashRepo(String bookingId, String icon,
      String rating, String feedback, BuildContext context) async {
    try {
      final rateWashResponse = await yopeeApiClient.rateWashApi(
          bookingId, icon, rating, feedback, context);
      return rateWashResponse;
    } catch (e) {
      print("rate wash error:$e");
      rethrow;
    }
  }

  //User Service List
  Future<SpecialRequestListResponse> userServiceListRepo(
      String month, BuildContext context) async {
    try {
      final userServiceListResponse =
          await yopeeApiClient.userServiceListApi(month, context);
      return userServiceListResponse;
    } catch (e) {
      print("User Service list error:$e");
      rethrow;
    }
  }

  //User Service Add
  Future<SpecialRequestAddResponse> userServiceAddRepo(
      String userVehicleId,
      String userAddressId,
      String amount,
      String serviceId,
      BuildContext context) async {
    try {
      final userServiceAddResponse = await yopeeApiClient.userServiceAddApi(
          userVehicleId, userAddressId, serviceId, amount, context);
      return userServiceAddResponse;
    } catch (e) {
      print("User Service  add error:$e");
      rethrow;
    }
  }

  //Renew Subs
  Future<RenewSubsResponse> renewSubsRepo(
      String userVehicleId,
      String userAddressId,
      String subsId,
      String fromDate,
      String amount,
      BuildContext context) async {
    try {
      final renewResponse = await yopeeApiClient.renewSubsApi(
          userVehicleId, userAddressId, subsId, fromDate, amount, context);
      return renewResponse;
    } catch (e) {
      print("renew error:$e");
      rethrow;
    }
  }

  //Check User Vehicle
  Future<CheckUserVehicleResponse> checkUserVehicleRepo(
      String id, BuildContext context) async {
    try {
      final checkUserVehicleResponse =
          await yopeeApiClient.checkUserVehicleApi(id, context);
      return checkUserVehicleResponse;
    } catch (e) {
      print("checkUserVehicle error:$e");
      rethrow;
    }
  }

  //Upcoming User Subscription
  Future<UpcomingSubscriptionResponse> upcomingSubsRepo(
      BuildContext context) async {
    try {
      final upcomingSubsResponse =
          await yopeeApiClient.userUpcomingSubsListApi(context);
      return upcomingSubsResponse;
    } catch (e) {
      print("upcomingSubs error:$e");
      rethrow;
    }
  }
}
