// To parse this JSON data, do
//
//     final userSubscriptionListResponse = userSubscriptionListResponseFromJson(jsonString);

import 'dart:convert';

UserSubscriptionListResponse userSubscriptionListResponseFromJson(String str) =>
    UserSubscriptionListResponse.fromJson(json.decode(str));

String userSubscriptionListResponseToJson(UserSubscriptionListResponse data) =>
    json.encode(data.toJson());

// class UserSubscriptionListResponse {
//   String? message;
//   int? status;
//   List<UserSubsData> data;
//
//   UserSubscriptionListResponse({
//     this.message,
//     this.status,
//     required this.data,
//   });
//
//   factory UserSubscriptionListResponse.fromJson(Map<String, dynamic> json) =>
//       UserSubscriptionListResponse(
//         message: json["message"],
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<UserSubsData>.from(
//                 json["data"]!.map((x) => UserSubsData.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class UserSubsData {
//   int id;
//   String? type;
//   int userId;
//   int userVehicleId;
//   int userAddressId;
//   dynamic serviceId;
//   int? subscriptionId;
//   dynamic message;
//   dynamic assignedBy;
//   dynamic assignedAt;
//   dynamic actionBy;
//   dynamic actionAt;
//   dynamic actionReason;
//   dynamic actionMessage;
//   String? fromDate;
//   String? toDate;
//   dynamic requestTime;
//   dynamic comment;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   User user;
//   UserVehicle userVehicle;
//   UserAddress userAddress;
//   Subscription subscription;
//   Transaction transaction;
//   dynamic service;
//   dynamic cleaner;
//
//   UserSubsData({
//     required this.id,
//     this.type,
//     required this.userId,
//     required this.userVehicleId,
//     required this.userAddressId,
//     this.serviceId,
//     this.subscriptionId,
//     this.message,
//     this.assignedBy,
//     this.assignedAt,
//     this.actionBy,
//     this.actionAt,
//     this.actionReason,
//     this.actionMessage,
//     this.fromDate,
//     this.toDate,
//     this.requestTime,
//     this.comment,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     required this.user,
//     required this.userVehicle,
//     required this.userAddress,
//     required this.subscription,
//     required this.transaction,
//     this.service,
//     this.cleaner,
//   });
//
//   factory UserSubsData.fromJson(Map<String, dynamic> json) => UserSubsData(
//         id: json["id"],
//         type: json["type"],
//         userId: json["user_id"],
//         userVehicleId: json["user_vehicle_id"],
//         userAddressId: json["user_address_id"],
//         serviceId: json["service_id"],
//         subscriptionId: json["subscription_id"],
//         message: json["message"],
//         assignedBy: json["assigned_by"],
//         assignedAt: json["assigned_at"],
//         actionBy: json["action_by"],
//         actionAt: json["action_at"],
//         actionReason: json["action_reason"],
//         actionMessage: json["action_message"],
//         fromDate: json["from_date"],
//         toDate: json["to_date"],
//         requestTime: json["request_time"],
//         comment: json["comment"],
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         user: User.fromJson(json["user"]),
//         userVehicle: UserVehicle.fromJson(json["user_vehicle"] ?? {}),
//         userAddress: UserAddress.fromJson(json["user_address"] ?? {}),
//         subscription: Subscription.fromJson(json["subscription"] ?? {}),
//         transaction: Transaction.fromJson(json["transaction"] ?? {}),
//         service: json["service"],
//         cleaner: json["cleaner"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": type,
//         "user_id": userId,
//         "user_vehicle_id": userVehicleId,
//         "user_address_id": userAddressId,
//         "service_id": serviceId,
//         "subscription_id": subscriptionId,
//         "message": message,
//         "assigned_by": assignedBy,
//         "assigned_at": assignedAt,
//         "action_by": actionBy,
//         "action_at": actionAt,
//         "action_reason": actionReason,
//         "action_message": actionMessage,
//         "from_date": fromDate,
//         "to_date": toDate,
//         "request_time": requestTime,
//         "comment": comment,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "user": user?.toJson(),
//         "user_vehicle": userVehicle?.toJson(),
//         "user_address": userAddress?.toJson(),
//         "subscription": subscription?.toJson(),
//         "transaction": transaction?.toJson(),
//         "service": service,
//         "cleaner": cleaner,
//       };
// }
//
// class Subscription {
//   int? id;
//   String? name;
//   int price;
//   String? duration;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? image;
//   List<Media>? media;
//
//   Subscription({
//     this.id,
//     this.name,
//     required this.price,
//     this.duration,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.image,
//     this.media,
//   });
//
//   factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//         duration: json["duration"],
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         image: json["image"],
//         media: json["media"] == null
//             ? []
//             : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "price": price,
//         "duration": duration,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "image": image,
//         "media": media == null
//             ? []
//             : List<dynamic>.from(media!.map((x) => x.toJson())),
//       };
// }
//
// class Media {
//   int? id;
//   String? modelType;
//   int? modelId;
//   String? collectionName;
//   String? name;
//   String? fileName;
//   String? mimeType;
//   String? disk;
//   int? size;
//   List<dynamic>? manipulations;
//   List<dynamic>? customProperties;
//   List<dynamic>? responsiveImages;
//   int? orderColumn;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Media({
//     this.id,
//     this.modelType,
//     this.modelId,
//     this.collectionName,
//     this.name,
//     this.fileName,
//     this.mimeType,
//     this.disk,
//     this.size,
//     this.manipulations,
//     this.customProperties,
//     this.responsiveImages,
//     this.orderColumn,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Media.fromJson(Map<String, dynamic> json) => Media(
//         id: json["id"],
//         modelType: json["model_type"],
//         modelId: json["model_id"],
//         collectionName: json["collection_name"],
//         name: json["name"],
//         fileName: json["file_name"],
//         mimeType: json["mime_type"],
//         disk: json["disk"],
//         size: json["size"],
//         manipulations: json["manipulations"] == null
//             ? []
//             : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
//         customProperties: json["custom_properties"] == null
//             ? []
//             : List<dynamic>.from(json["custom_properties"]!.map((x) => x)),
//         responsiveImages: json["responsive_images"] == null
//             ? []
//             : List<dynamic>.from(json["responsive_images"]!.map((x) => x)),
//         orderColumn: json["order_column"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "model_type": modelType,
//         "model_id": modelId,
//         "collection_name": collectionName,
//         "name": name,
//         "file_name": fileName,
//         "mime_type": mimeType,
//         "disk": disk,
//         "size": size,
//         "manipulations": manipulations == null
//             ? []
//             : List<dynamic>.from(manipulations!.map((x) => x)),
//         "custom_properties": customProperties == null
//             ? []
//             : List<dynamic>.from(customProperties!.map((x) => x)),
//         "responsive_images": responsiveImages == null
//             ? []
//             : List<dynamic>.from(responsiveImages!.map((x) => x)),
//         "order_column": orderColumn,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// class Transaction {
//   int? id;
//   int? bookingId;
//   int? userId;
//   int? userVehicleId;
//   int? userAddressId;
//   String? paymentType;
//   int? amount;
//   String? transactionStatus;
//   dynamic paymentDate;
//   String? paymentStatus;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Transaction({
//     this.id,
//     this.bookingId,
//     this.userId,
//     this.userVehicleId,
//     this.userAddressId,
//     this.paymentType,
//     this.amount,
//     this.transactionStatus,
//     this.paymentDate,
//     this.paymentStatus,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
//         id: json["id"],
//         bookingId: json["booking_id"],
//         userId: json["user_id"],
//         userVehicleId: json["user_vehicle_id"],
//         userAddressId: json["user_address_id"],
//         paymentType: json["payment_type"],
//         amount: json["amount"],
//         transactionStatus: json["transaction_status"],
//         paymentDate: json["payment_date"],
//         paymentStatus: json["payment_status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "booking_id": bookingId,
//         "user_id": userId,
//         "user_vehicle_id": userVehicleId,
//         "user_address_id": userAddressId,
//         "payment_type": paymentType,
//         "amount": amount,
//         "transaction_status": transactionStatus,
//         "payment_date": paymentDate,
//         "payment_status": paymentStatus,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// class User {
//   int? id;
//   String? userType;
//   String? status;
//   String? email;
//   String? countryCode;
//   int? mobile;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic address;
//   String? accessToken;
//   int? pushNotification;
//   int? notifyMonthlyPayment;
//   String? profileImageUrl;
//   String? documentImageUrl;
//   String? name;
//
//   User({
//     this.id,
//     this.userType,
//     this.status,
//     this.email,
//     this.countryCode,
//     this.mobile,
//     this.latitude,
//     this.longitude,
//     this.address,
//     this.accessToken,
//     this.pushNotification,
//     this.notifyMonthlyPayment,
//     this.profileImageUrl,
//     this.documentImageUrl,
//     this.name,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         userType: json["user_type"],
//         status: json["status"],
//         email: json["email"],
//         countryCode: json["country_code"],
//         mobile: json["mobile"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         address: json["address"],
//         accessToken: json["access_token"],
//         pushNotification: json["push_notification"],
//         notifyMonthlyPayment: json["notify_monthly_payment"],
//         profileImageUrl: json["profile_image_url"],
//         documentImageUrl: json["document_image_url"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_type": userType,
//         "status": status,
//         "email": email,
//         "country_code": countryCode,
//         "mobile": mobile,
//         "latitude": latitude,
//         "longitude": longitude,
//         "address": address,
//         "access_token": accessToken,
//         "push_notification": pushNotification,
//         "notify_monthly_payment": notifyMonthlyPayment,
//         "profile_image_url": profileImageUrl,
//         "document_image_url": documentImageUrl,
//         "name": name,
//       };
// }
//
// class UserAddress {
//   int? id;
//   int? userId;
//   String? type;
//   String? flatHouseNo;
//   String? areaSector;
//   String? nearby;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   UserAddress({
//     this.id,
//     this.userId,
//     this.type,
//     this.flatHouseNo,
//     this.areaSector,
//     this.nearby,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
//         id: json["id"],
//         userId: json["user_id"],
//         type: json["type"],
//         flatHouseNo: json["flat_house_no"],
//         areaSector: json["area_sector"],
//         nearby: json["nearby"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "type": type,
//         "flat_house_no": flatHouseNo,
//         "area_sector": areaSector,
//         "nearby": nearby,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// class UserVehicle {
//   int? id;
//   int? userId;
//   int? vehicleTypeId;
//   int? carBrandId;
//   int? carModelId;
//   String? registrationNo;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   Subscription brand;
//   Subscription model;
//   Subscription vehicle;
//
//   UserVehicle({
//     this.id,
//     this.userId,
//     this.vehicleTypeId,
//     this.carBrandId,
//     this.carModelId,
//     this.registrationNo,
//     this.createdAt,
//     this.updatedAt,
//     required this.brand,
//     required this.model,
//     required this.vehicle,
//   });
//
//   factory UserVehicle.fromJson(Map<String, dynamic> json) => UserVehicle(
//         id: json["id"],
//         userId: json["user_id"],
//         vehicleTypeId: json["vehicle_type_id"],
//         carBrandId: json["car_brand_id"],
//         carModelId: json["car_model_id"],
//         registrationNo: json["registration_no"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         brand: Subscription.fromJson(json["brand"] ?? {}),
//         model: Subscription.fromJson(json["model"] ?? {}),
//         vehicle: Subscription.fromJson(json["vehicle"] ?? {}),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "vehicle_type_id": vehicleTypeId,
//         "car_brand_id": carBrandId,
//         "car_model_id": carModelId,
//         "registration_no": registrationNo,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "brand": brand?.toJson(),
//         "model": model?.toJson(),
//         "vehicle": vehicle?.toJson(),
//       };
// }
class UserSubscriptionListResponse {
  UserSubscriptionListResponse({
    required this.message,
    required this.status,
    required this.data,
  });
  late final String message;
  late final int status;
  late final List<UserSubsData> data;

  UserSubscriptionListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    status = json['status' ?? ""];
    data =
        List.from(json['data']).map((e) => UserSubsData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UserSubsData {
  UserSubsData({
    required this.id,
    required this.type,
    required this.userId,
    required this.userVehicleId,
    required this.userAddressId,
    required this.serviceId,
    required this.subscriptionId,
    required this.message,
    required this.assignedBy,
    required this.assignedAt,
    required this.actionBy,
    required this.actionAt,
    required this.actionReason,
    required this.actionMessage,
    required this.fromDate,
    required this.toDate,
    required this.requestTime,
    required this.rating,
    required this.comment,
    required this.status,
    required this.expiredStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.actionImageUrl,
    required this.user,
    required this.userVehicle,
    required this.userAddress,
    required this.subscription,
    required this.transaction,
    required this.service,
    required this.cleaner,
    required this.media,
  });
  late final int id;
  late final String type;
  late final int userId;
  late final int userVehicleId;
  late final int userAddressId;
  late final Null serviceId;
  late final int subscriptionId;
  late final dynamic message;
  late final dynamic assignedBy;
  late final dynamic assignedAt;
  late final dynamic actionBy;
  late final dynamic actionAt;
  late final dynamic actionReason;
  late final dynamic actionMessage;
  late final String fromDate;
  late final String toDate;
  late final dynamic requestTime;
  late final int rating;
  late final dynamic comment;
  late final String status;
  late final String expiredStatus;
  late final String createdAt;
  late final String updatedAt;
  late final String actionImageUrl;
  late final User user;
  late final UserVehicle userVehicle;
  late final UserAddress userAddress;
  late final Subscription subscription;
  late final Transaction transaction;
  late final Null service;
  late final Null cleaner;
  late final List<dynamic> media;

  UserSubsData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    type = json['type'] ?? "";
    userId = json['user_id'] ?? 0;
    userVehicleId = json['user_vehicle_id'] ?? 0;
    userAddressId = json['user_address_id'] ?? 0;
    serviceId = null;
    subscriptionId = json['subscription_id'] ?? 0;
    message = json['message'] ?? "";
    assignedBy = json['assigned_by'] ?? "";
    assignedAt = json['assigned_at'] ?? "";
    actionBy = json['action_by'] ?? "";
    actionAt = json['action_at'] ?? "";
    actionReason = json['action_reason'] ?? "";
    actionMessage = json['action_message'] ?? "";
    fromDate = json['from_date'] ?? "";
    toDate = json['to_date'] ?? "";
    requestTime = json['request_time'] ?? "";
    rating = json['rating'] ?? "";
    comment = json['comment'] ?? "";
    status = json['status'] ?? "";
    expiredStatus = json['expired_status'] ?? "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    actionImageUrl = json['action_image_url'];
    user = User.fromJson(json['user'] ?? {});
    userVehicle = UserVehicle.fromJson(json['user_vehicle'] ?? {});
    userAddress = UserAddress.fromJson(json['user_address'] ?? {});
    subscription = Subscription.fromJson(json['subscription'] ?? {});
    transaction = Transaction.fromJson(json['transaction'] ?? {});
    service = null;
    cleaner = null;
    media = List.castFrom<dynamic, dynamic>(json['media'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['user_id'] = userId;
    _data['user_vehicle_id'] = userVehicleId;
    _data['user_address_id'] = userAddressId;
    _data['service_id'] = serviceId;
    _data['subscription_id'] = subscriptionId;
    _data['message'] = message;
    _data['assigned_by'] = assignedBy;
    _data['assigned_at'] = assignedAt;
    _data['action_by'] = actionBy;
    _data['action_at'] = actionAt;
    _data['action_reason'] = actionReason;
    _data['action_message'] = actionMessage;
    _data['from_date'] = fromDate;
    _data['to_date'] = toDate;
    _data['request_time'] = requestTime;
    _data['rating'] = rating;
    _data['comment'] = comment;
    _data['status'] = status;
    _data['expired_status'] = expiredStatus;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['action_image_url'] = actionImageUrl;
    _data['user'] = user.toJson();
    _data['user_vehicle'] = userVehicle.toJson();
    _data['user_address'] = userAddress.toJson();
    _data['subscription'] = subscription.toJson();
    _data['transaction'] = transaction.toJson();
    _data['service'] = service;
    _data['cleaner'] = cleaner;
    _data['media'] = media;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.userType,
    required this.status,
    required this.email,
    required this.countryCode,
    required this.mobile,
    required this.userCategoryType,
    this.latitude,
    this.longitude,
    this.address,
    required this.accessToken,
    required this.pushNotification,
    required this.notifyMonthlyPayment,
    required this.accountDetails,
    required this.name,
    required this.profileImageUrl,
    required this.documentImageUrl,
  });
  late final int id;
  late final String userType;
  late final String status;
  late final String email;
  late final String countryCode;
  late final int mobile;
  late final String userCategoryType;
  late final Null latitude;
  late final Null longitude;
  late final Null address;
  late final String accessToken;
  late final int pushNotification;
  late final int notifyMonthlyPayment;
  late final int accountDetails;
  late final String name;
  late final String profileImageUrl;
  late final String documentImageUrl;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userType = json['user_type'] ?? "";
    status = json['status'] ?? "";
    email = json['email'] ?? "";
    countryCode = json['country_code'] ?? "";
    mobile = json['mobile'] ?? 0;
    userCategoryType = json['user_category_type'] ?? "";
    latitude = null;
    longitude = null;
    address = null;
    accessToken = json['access_token'] ?? "";
    pushNotification = json['push_notification'] ?? 0;
    notifyMonthlyPayment = json['notify_monthly_payment'] ?? 0;
    accountDetails = json['account_details'] ?? 0;
    name = json['name'] ?? "";
    profileImageUrl = json['profile_image_url'] ?? "";
    documentImageUrl = json['document_image_url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_type'] = userType;
    _data['status'] = status;
    _data['email'] = email;
    _data['country_code'] = countryCode;
    _data['mobile'] = mobile;
    _data['user_category_type'] = userCategoryType;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['address'] = address;
    _data['access_token'] = accessToken;
    _data['push_notification'] = pushNotification;
    _data['notify_monthly_payment'] = notifyMonthlyPayment;
    _data['account_details'] = accountDetails;
    _data['name'] = name;
    _data['profile_image_url'] = profileImageUrl;
    _data['document_image_url'] = documentImageUrl;
    return _data;
  }
}

class UserVehicle {
  UserVehicle({
    required this.id,
    required this.userId,
    required this.vehicleTypeId,
    required this.carBrandId,
    required this.carModelId,
    required this.registrationNo,
    required this.createdAt,
    required this.updatedAt,
    required this.brand,
    required this.model,
    required this.vehicle,
  });
  late final int id;
  late final int userId;
  late final int vehicleTypeId;
  late final int carBrandId;
  late final int carModelId;
  late final String registrationNo;
  late final String createdAt;
  late final String updatedAt;
  late final Brand brand;
  late final Model model;
  late final Vehicle vehicle;

  UserVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    vehicleTypeId = json['vehicle_type_id'] ?? 0;
    carBrandId = json['car_brand_id'] ?? 0;
    carModelId = json['car_model_id'] ?? 0;
    registrationNo = json['registration_no'] ?? 0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brand = Brand.fromJson(json['brand'] ?? {});
    model = Model.fromJson(json['model'] ?? {});
    vehicle = Vehicle.fromJson(json['vehicle'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['vehicle_type_id'] = vehicleTypeId;
    _data['car_brand_id'] = carBrandId;
    _data['car_model_id'] = carModelId;
    _data['registration_no'] = registrationNo;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['brand'] = brand.toJson();
    _data['model'] = model.toJson();
    _data['vehicle'] = vehicle.toJson();
    return _data;
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.media,
  });
  late final int id;
  late final String name;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String image;
  late final List<Media> media;

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'] ?? "";
    media = List.from(json['media']).map((e) => Media.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;
    _data['media'] = media.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Media {
  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  late final int id;
  late final String modelType;
  late final int modelId;
  late final String collectionName;
  late final String name;
  late final String fileName;
  late final String mimeType;
  late final String disk;
  late final int size;
  late final List<dynamic> manipulations;
  late final List<dynamic> customProperties;
  late final List<dynamic> responsiveImages;
  late final int orderColumn;
  late final String createdAt;
  late final String updatedAt;
  late final Null deletedAt;

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    size = json['size'];
    manipulations = List.castFrom<dynamic, dynamic>(json['manipulations']);
    customProperties =
        List.castFrom<dynamic, dynamic>(json['custom_properties']);
    responsiveImages =
        List.castFrom<dynamic, dynamic>(json['responsive_images']);
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['model_type'] = modelType;
    _data['model_id'] = modelId;
    _data['collection_name'] = collectionName;
    _data['name'] = name;
    _data['file_name'] = fileName;
    _data['mime_type'] = mimeType;
    _data['disk'] = disk;
    _data['size'] = size;
    _data['manipulations'] = manipulations;
    _data['custom_properties'] = customProperties;
    _data['responsive_images'] = responsiveImages;
    _data['order_column'] = orderColumn;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }
}

class Model {
  Model({
    required this.id,
    required this.name,
    required this.carBrandId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.media,
  });
  late final int id;
  late final String name;
  late final int carBrandId;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String image;
  late final List<dynamic> media;

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    carBrandId = json['car_brand_id'] ?? 0;
    status = json['status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    image = json['image'] ?? "";
    media = List.castFrom<dynamic, dynamic>(json['media']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['car_brand_id'] = carBrandId;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;
    _data['media'] = media;
    return _data;
  }
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.carModelId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.media,
  });
  late final int id;
  late final int carModelId;
  late final String name;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String image;
  late final List<Media> media;

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    carModelId = json['car_model_id'] ?? 0;
    name = json['name'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    image = json['image'] ?? "";
    media = List.from(json['media']).map((e) => Media.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['car_model_id'] = carModelId;
    _data['name'] = name;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;
    _data['media'] = media.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UserAddress {
  UserAddress({
    required this.id,
    required this.userId,
    required this.type,
    required this.flatHouseNo,
    required this.areaSector,
    this.nearby,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final String type;
  late final String flatHouseNo;
  late final String areaSector;
  late final Null nearby;
  late final String createdAt;
  late final String updatedAt;

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    type = json['type'] ?? "";
    flatHouseNo = json['flat_house_no'] ?? "";
    areaSector = json['area_sector'] ?? "";
    nearby = null;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['type'] = type;
    _data['flat_house_no'] = flatHouseNo;
    _data['area_sector'] = areaSector;
    _data['nearby'] = nearby;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Subscription {
  Subscription({
    required this.id,
    required this.carBrandId,
    required this.carModelId,
    required this.carVehicleId,
    required this.name,
    required this.price,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.media,
  });
  late final int id;
  late final int carBrandId;
  late final int carModelId;
  late final int carVehicleId;
  late final String name;
  late final int price;
  late final String duration;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String image;
  late final List<Media> media;

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    carBrandId = json['car_brand_id'] ?? 0;
    carModelId = json['car_model_id'] ?? 0;
    carVehicleId = json['car_vehicle_id'] ?? 0;
    name = json['name'] ?? "";
    price = json['price'] ?? 0;
    duration = json['duration'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    image = json['image'] ?? "";
    media = List.from(json['media']).map((e) => Media.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['car_brand_id'] = carBrandId;
    _data['car_model_id'] = carModelId;
    _data['car_vehicle_id'] = carVehicleId;
    _data['name'] = name;
    _data['price'] = price;
    _data['duration'] = duration;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;
    _data['media'] = media.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Transaction {
  Transaction({
    required this.id,
    required this.bookingId,
    required this.userId,
    this.assignedBy,
    required this.userVehicleId,
    required this.userAddressId,
    required this.paymentType,
    required this.amount,
    required this.transactionStatus,
    required this.paymentDate,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int bookingId;
  late final int userId;
  late final Null assignedBy;
  late final int userVehicleId;
  late final int userAddressId;
  late final String paymentType;
  late final int amount;
  late final String transactionStatus;
  late final String paymentDate;
  late final String paymentStatus;
  late final String createdAt;
  late final String updatedAt;

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    bookingId = json['booking_id'] ?? 0;
    userId = json['user_id'] ?? 0;
    assignedBy = null;
    userVehicleId = json['user_vehicle_id'] ?? 0;
    userAddressId = json['user_address_id'] ?? 0;
    paymentType = json['payment_type'] ?? "";
    amount = json['amount'] ?? 0;
    transactionStatus = json['transaction_status'] ?? "";
    paymentDate = json['payment_date'] ?? "";
    paymentStatus = json['payment_status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['booking_id'] = bookingId;
    _data['user_id'] = userId;
    _data['assigned_by'] = assignedBy;
    _data['user_vehicle_id'] = userVehicleId;
    _data['user_address_id'] = userAddressId;
    _data['payment_type'] = paymentType;
    _data['amount'] = amount;
    _data['transaction_status'] = transactionStatus;
    _data['payment_date'] = paymentDate;
    _data['payment_status'] = paymentStatus;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
