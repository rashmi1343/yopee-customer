// To parse this JSON data, do
//
//     final subscriptionListResponse = subscriptionListResponseFromJson(jsonString);

import 'dart:convert';

SubscriptionListResponse subscriptionListResponseFromJson(String str) =>
    SubscriptionListResponse.fromJson(json.decode(str));

String subscriptionListResponseToJson(SubscriptionListResponse data) =>
    json.encode(data.toJson());

// class SubscriptionListResponse {
//   String? message;
//   int? status;
//   List<SubsListData>? data;
//
//   SubscriptionListResponse({
//     this.message,
//     this.status,
//     this.data,
//   });
//
//   factory SubscriptionListResponse.fromJson(Map<String, dynamic> json) =>
//       SubscriptionListResponse(
//         message: json["message"],
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<SubsListData>.from(
//                 json["data"]!.map((x) => SubsListData.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class SubsListData {
//   int? id;
//   String? name;
//   int? price;
//   String? duration;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? image;
//   List<SubscriptionDetail>? subscriptionDetails;
//   List<Media>? media;
//   bool isPackageSelected = false;
//
//   SubsListData({
//     this.id,
//     this.name,
//     this.price,
//     this.duration,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.image,
//     this.subscriptionDetails,
//     this.media,
//   });
//
//   factory SubsListData.fromJson(Map<String, dynamic> json) => SubsListData(
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
//         subscriptionDetails: json["subscription_details"] == null
//             ? []
//             : List<SubscriptionDetail>.from(json["subscription_details"]!
//                 .map((x) => SubscriptionDetail.fromJson(x))),
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
//         "subscription_details": subscriptionDetails == null
//             ? []
//             : List<dynamic>.from(subscriptionDetails!.map((x) => x.toJson())),
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
// class SubscriptionDetail {
//   int? id;
//   int? subscriptionId;
//   String? name;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   SubscriptionDetail({
//     this.id,
//     this.subscriptionId,
//     this.name,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory SubscriptionDetail.fromJson(Map<String, dynamic> json) =>
//       SubscriptionDetail(
//         id: json["id"],
//         subscriptionId: json["subscription_id"],
//         name: json["name"],
//         status: json["status"],
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
//         "subscription_id": subscriptionId,
//         "name": name,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
class SubscriptionListResponse {
  SubscriptionListResponse({
    required this.message,
    required this.status,
    required this.data,
  });
  late final String message;
  late final int status;
  late final List<SubsListData> data;

  SubscriptionListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data =
        List.from(json['data']).map((e) => SubsListData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SubsListData {
  SubsListData({
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
    required this.getModel,
    required this.getBrand,
    required this.getVehicleType,
    required this.subscriptionDetails,
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
  late final GetModel getModel;
  late final GetBrand getBrand;
  late final GetVehicleType getVehicleType;
  late final List<SubscriptionDetails> subscriptionDetails;
  late final List<Media> media;

  SubsListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carBrandId = json['car_brand_id'];
    carModelId = json['car_model_id'];
    carVehicleId = json['car_vehicle_id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    getModel = GetModel.fromJson(json['get_model']);
    getBrand = GetBrand.fromJson(json['get_brand']);
    getVehicleType = GetVehicleType.fromJson(json['get_vehicle_type']);
    subscriptionDetails = List.from(json['subscription_details'])
        .map((e) => SubscriptionDetails.fromJson(e))
        .toList();
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
    _data['get_model'] = getModel.toJson();
    _data['get_brand'] = getBrand.toJson();
    _data['get_vehicle_type'] = getVehicleType.toJson();
    _data['subscription_details'] =
        subscriptionDetails.map((e) => e.toJson()).toList();
    _data['media'] = media.map((e) => e.toJson()).toList();
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

class SubscriptionDetails {
  SubscriptionDetails({
    required this.id,
    required this.subscriptionId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int subscriptionId;
  late final String name;
  late final String status;
  late final String createdAt;
  late final String updatedAt;

  SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionId = json['subscription_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['subscription_id'] = subscriptionId;
    _data['name'] = name;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
