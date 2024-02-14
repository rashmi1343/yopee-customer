class Environment {
  static String apiKey = "AIzaSyAKA3Mth2Hr4qjfNu19O7j5pT76upGAFZ4";

  // Replace your apiKey & apiSecret;
  static String razorPayApiKey = 'rzp_test_QBM5qXj9Ohqaw8';
  static String razorPayApiSecret = 'nMBuv9UZoWeRLlAirGXw6s20';

  static String accessToken = "";
  static String loginMobileNumber = "";
  static String profileName = "";
  static String profileEmail = "";
  static int selectedIndex = 0;
  static String notificationStatus = "0";
  static int? accountDetails = 0;
  static const String baseUrl =
      "https://binarymetrix-staging.com/yopee/public/api/";

  static const String loginUrl = "customer/login";
  static const String signupUrl = "customer/signup";
  static const String logoutUrl = "otp/logout";
  static const String otpVerifyUrl = "customer/verify";
  static const String resendOtpUrl = "customer/resendOtp";

  // For Address
  static const String addressListUrl = "address";
  static const String addressDeleteUrl = "address/delete";
  static const String addressAddUrl = "address/create";
  static const String addressEditUrl = "address/edit";

  //For Vehicle
  static const String vehicleListUrl = "vehicle/vehicle_lists";
  static const String vehicleEditUrl = "vehicle/edit";
  static const String vehicleSaveUrl = "vehicle/create";
  static const String vehicleDeleteUrl = "vehicle/delete";

  // For Subscription
  static const String subscriptionListUrl = "subscription/subscription_lists";
  static const String subscriptionDetailUrl =
      "subscriptiondetails/subscription_details";
  static const String subscriptionAdd = "usersubscription/create";
  static const String mySubscriptionList = "usersubscription/list";
  static const String myUpcomingSubscriptionList = "upcomingsubscription/list";
  static const String basicSubscriptionList = "subscription/basic-subscription";
  static const String renewSubscriptionList = "upcomingsubscription/create";

  //For Vehicle Type
  static const String vehicleTypeListUrl = "setting/vehicle-types";
  static const String checkUserVehicleUrl = "vehicle/check_user_vehicle";

  //For Car Brand
  static const String carBrandUrl = "setting/car-brands";

  //For Car Model
  static const String carModelUrl = "setting/car-models";

  //For Car Service
  static const String carBasicServiceUrl = "service/basic-service";
  static const String carServiceDetailUrl = "service/details";
  static const String carServiceUrl = "service/list";
  static const String carServicePriceUrl = "service/list";

  //For Profile
  static const String profileViewUrl = "user/profile";
  static const String profileUpdateUrl = "user/update-profile";

  //For About us
  static const String aboutUsUrl = "setting/cms";

  //For uploading photo
  static const String uploadPhotoUrl = "user/update-photo";

  //For contact us
  static const String contactUsUrl = "contactus/create";

  //For reports list
  static const String reportsListUrl = "user/user-report-list";

  //For Dashboard
  static const String dashboardUrl = "user/dashboard";

  //For Special Request
  static const String specialRequestListUrl = "user/special-request-list";
  static const String specialRequestAddUrl = "user/special-request-add";
  static const String specialRequestDeleteUrl = "user/special-request-delete";

  //For notification
  static const String readNotificationUrl = "notifications/read";
  static const String deleteNotificationUrl = "notifications/delete";
  static const String listNotificationUrl = "notifications";
  static const String notificationStatusUrl = "user/notification-button";

  //For Rate wash user/user-rate-wash
  static const String rateWashUrl = "user/user-rate-wash";

  //For service add and transaction listing
  static const String userServiceListUrl = "user/service-list";
  static const String userServiceAddUrl = "user/service-add";
}
