// To parse this JSON data, do
//
//     final serviceDetailListResponse = serviceDetailListResponseFromJson(jsonString);

import 'dart:convert';

ServiceDetailListResponse serviceDetailListResponseFromJson(String str) =>
    ServiceDetailListResponse.fromJson(json.decode(str));

String serviceDetailListResponseToJson(ServiceDetailListResponse data) =>
    json.encode(data.toJson());

class ServiceDetailListResponse {
  ServiceDetailListResponse({
    required this.message,
    required this.status,
    required this.data,
  });
  late final String message;
  late final int status;
  late final List<ServiceDetailListData> data;

  ServiceDetailListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = List.from(json['data'])
        .map((e) => ServiceDetailListData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ServiceDetailListData {
  ServiceDetailListData({
    required this.id,
    required this.type,
    required this.name,
    required this.carBrandId,
    required this.carModelId,
    required this.carVehicleId,
    required this.shortDescription,
    required this.discountPrice,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.icon,
    required this.getModel,
    required this.getBrand,
    required this.getVehicleType,
    required this.getServiceDetails,
    required this.media,
  });
  late final int id;
  late final String type;
  late final String name;
  late final int carBrandId;
  late final int carModelId;
  late final int carVehicleId;
  late final String shortDescription;
  late final int discountPrice;
  late final int price;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String image;
  late final String icon;
  late final GetModel getModel;
  late final GetBrand getBrand;
  late final GetVehicleType getVehicleType;
  late final List<dynamic> getServiceDetails;
  late final List<dynamic> media;

  ServiceDetailListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    carBrandId = json['car_brand_id'];
    carModelId = json['car_model_id'];
    carVehicleId = json['car_vehicle_id'];
    shortDescription = json['short_description'];
    discountPrice = json['discount_price'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    icon = json['icon'];
    getModel = GetModel.fromJson(json['get_model']);
    getBrand = GetBrand.fromJson(json['get_brand']);
    getVehicleType = GetVehicleType.fromJson(json['get_vehicle_type']);
    getServiceDetails =
        List.castFrom<dynamic, dynamic>(json['get_service_details']);
    media = List.castFrom<dynamic, dynamic>(json['media']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['name'] = name;
    _data['car_brand_id'] = carBrandId;
    _data['car_model_id'] = carModelId;
    _data['car_vehicle_id'] = carVehicleId;
    _data['short_description'] = shortDescription;
    _data['discount_price'] = discountPrice;
    _data['price'] = price;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;
    _data['icon'] = icon;
    _data['get_model'] = getModel.toJson();
    _data['get_brand'] = getBrand.toJson();
    _data['get_vehicle_type'] = getVehicleType.toJson();
    _data['get_service_details'] = getServiceDetails;
    _data['media'] = media;
    return _data;
  }
}

class GetModel {
  GetModel({
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

  GetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    carBrandId = json['car_brand_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
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

class GetBrand {
  GetBrand({
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

  GetBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
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

class GetVehicleType {
  GetVehicleType({
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

  GetVehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carModelId = json['car_model_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
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
