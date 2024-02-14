import 'dart:convert';

UpcomingSubscriptionResponse upcomingSubscriptionResponseFromJson(String str) =>
    UpcomingSubscriptionResponse.fromJson(json.decode(str));

String upcomingSubscriptionResponseToJson(UpcomingSubscriptionResponse data) =>
    json.encode(data.toJson());

class UpcomingSubscriptionResponse {
  UpcomingSubscriptionResponse({
    required this.message,
    required this.status,
    required this.data,
  });
  late final String message;
  late final int status;
  late final List<Data> data;

  UpcomingSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.type,
    required this.userId,
    required this.userVehicleId,
    required this.userAddressId,
    required this.subscriptionId,
    required this.fromDate,
    required this.toDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.userVehicle,
    required this.userAddress,
    required this.subscription,
  });
  late final int id;
  late final String type;
  late final int userId;
  late final int userVehicleId;
  late final int userAddressId;
  late final int subscriptionId;
  late final String fromDate;
  late final String toDate;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final User user;
  late final UserVehicle userVehicle;
  late final UserAddress userAddress;
  late final Subscription subscription;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    type = json['type'] ?? "";
    userId = json['user_id'] ?? 0;
    userVehicleId = json['user_vehicle_id'] ?? 0;
    userAddressId = json['user_address_id'] ?? 0;
    subscriptionId = json['subscription_id'] ?? 0;
    fromDate = json['from_date'] ?? "";
    toDate = json['to_date'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    user = User.fromJson(json['user'] ?? {});
    userVehicle = UserVehicle.fromJson(json['user_vehicle'] ?? {});
    userAddress = UserAddress.fromJson(json['user_address'] ?? {});
    subscription = Subscription.fromJson(json['subscription'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['user_id'] = userId;
    _data['user_vehicle_id'] = userVehicleId;
    _data['user_address_id'] = userAddressId;
    _data['subscription_id'] = subscriptionId;
    _data['from_date'] = fromDate;
    _data['to_date'] = toDate;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['user'] = user.toJson();
    _data['user_vehicle'] = userVehicle.toJson();
    _data['user_address'] = userAddress.toJson();
    _data['subscription'] = subscription.toJson();
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
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
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
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
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
    id = json['id'] ?? 0;
    modelType = json['model_type'] ?? "";
    modelId = json['model_id'] ?? 0;
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
    price = json['price'] ?? "";
    duration = json['duration'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? '';
    image = json['image'] ?? '';
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
