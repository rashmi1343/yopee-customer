import 'package:yopee_customer/View/AddVehicle/AddNewVehicle.dart';
import 'package:yopee_customer/View/AddVehicle/AddVehicleScreen2.dart';
import 'package:yopee_customer/View/Home/Dashboard.dart';

import 'package:yopee_customer/View/Login/Login.dart';
import 'package:yopee_customer/View/Menu/AboutUs.dart';
import 'package:yopee_customer/View/Menu/CancellationPolicy.dart';
import 'package:yopee_customer/View/Menu/MoreMenu.dart';
import 'package:yopee_customer/View/Menu/PrivacyPolicy.dart';
import 'package:yopee_customer/View/Menu/Reports.dart';
import 'package:yopee_customer/View/Menu/SpecialRequestScreen.dart';
import 'package:yopee_customer/View/OTP/OtpVerification.dart';
import 'package:yopee_customer/View/Menu/Profile.dart';
import 'package:yopee_customer/View/Payment/PaymentScreen.dart';
import 'package:yopee_customer/View/Services/Service_address.dart';
import 'package:yopee_customer/View/Services/Service_detail.dart';
import 'package:yopee_customer/View/Splash/SplashScreen.dart';
import 'package:yopee_customer/View/Address/saved_address.dart';
import 'package:yopee_customer/View/Subscription/Subscription.dart';
import 'package:yopee_customer/View/Subscription/SubscriptionDetail.dart';

import '../View/AddVehicle/CarModelScreen.dart';
import '../View/Address/AddAddress.dart';
import '../View/Menu/MySubscription.dart';
import '../View/Menu/NewNotification.dart';
import '../View/Menu/Notification.dart';
import '../View/Payment/PayNowScreen.dart';
import '../View/RateWash.dart';
import '../View/Services/Services.dart';
import '../View/VehicleList.dart';
import 'Routes.dart';

class AppRoutes {
  static var routes = {
    Routes.splash: (context) => const SplashScreen(),
    Routes.login: (context) => Login(
          mobile: '',
        ),
    Routes.otp: (context) => OtpVerification(),
    Routes.dashboard: (context) => Dashboard(),
    Routes.rateWash: (context) => RateWash(
          bookingId: '',
        ),
    // Routes.savedAddress: (context) => SavedAddress(
    //       vehicleImagePath: '',
    //       vehicleBrandName: '',
    //       vehicleModelName: '',
    //       vehicleTypeName: '',
    //       vehicleRegNo: '',
    //       vehicleId: '',
    //       subscriptionId: '',
    //       subscriptionPrize: '',
    //     ),
    Routes.addAddress: (context) => AddAddress(
          indexId: '',
          type: '',
          flatHouseNo: '',
          areaSector: '',
          nearBy: '',
          id: '',
          vehicleImagePath: '',
          vehicleBrandName: '',
          vehicleModelName: '',
          vehicleTypeName: '',
          vehicleRegNo: '',
          vehicleId: '',
          subscriptionId: '',
          subscriptionPrize: 0,
        ),
    // Routes.services: (context) => Services(),
    // Routes.serviceDetails: (context) => ServiceDetail(
    //       id: '',
    //       indexId: '',
    //       name: '',
    //       price: '',
    //     ),
    // Routes.serviceAddress: (context) => ServiceAddress(
    //       vehicleImagePath: '',
    //       vehicleBrandName: '',
    //       vehicleModelName: '',
    //       vehicleTypeName: '',
    //       vehicleRegNo: '',
    //       vehicleId: '',
    //       serviceId: '',
    //       price: '',
    //     ),
    Routes.addVehicle: (context) => AddNewVehicle(
          id: '',
          userId: '',
          carBrandId: '',
          carModelId: '',
          vehicleTypeId: '',
          registrationNo: '',
          carBrandName: '',
          carModelName: '',
        ),
    Routes.addVehicle2: (context) => AddVehicleScreen2(),
    Routes.addVehicle3: (context) => CarModelScreen(
          carBrandName: '',
          carBrandId: '',
        ),
    // Routes.vehicleList: (context) => VehicleList(
    //       id: '',
    //       price: '',
    //       vehicleImagePath: '',
    //       vehicleBrandName: '',
    //       vehicleModelName: '',
    //       vehicleTypeName: '',
    //       vehicleRegNo: '',
    //       vehicleId: '',
    //       serviceId: '',
    //     ),
    Routes.menu: (context) => MoreMenu(),
    Routes.profile: (context) => Profile(),
    Routes.policy: (context) => CancellationPolicy(),
    Routes.notification: (context) => NotificationScreen(),
    Routes.newNotification: (context) => NewNotificationScreen(),
    Routes.aboutUs: (context) => AboutUs(),
    Routes.reports: (context) => Reports(),
    // Routes.payment: (context) => PaymentScreen(
    //       vehicleImagePath: '',
    //       vehicleBrandName: '',
    //       vehicleModelName: '',
    //       vehicleTypeName: '',
    //       vehicleRegNo: '',
    //       vehicleId: '',
    //       addressId: '',
    //       addrressType: '',
    //       flatHouseNo: '',
    //       area: '',
    //       nearBy: '',
    //       subscriptionId: '',
    //       subscriptionPrize: '',
    //     ),
    // Routes.subscription: (context) => Subscription(),
    Routes.privacyPolicy: (context) => PrivacyPolicy(),
    Routes.mySubscription: (context) => MySubscription(),
    Routes.specialRequest: (context) => SpecialRequestScreen(),
    // Routes.subscriptionDetail: (context) => SubscriptionDetailScreen(
    //       id: '',
    //     ),
    Routes.payment1: (context) => PayNowScreen(
          subscriptionPrize: '',
          vehicleId: '',
          addressId: '',
          subscriptionId: '',
        ),
  };
}
