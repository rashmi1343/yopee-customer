// // To parse this JSON data, do
// //
// //     final serviceDetailsResponse = serviceDetailsResponseFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// ServiceDetailsResponse serviceDetailsResponseFromJson(String str) =>
//     ServiceDetailsResponse.fromJson(json.decode(str));
//
// String serviceDetailsResponseToJson(ServiceDetailsResponse data) =>
//     json.encode(data.toJson());
//
// class ServiceDetailsResponse {
//   String message;
//   int status;
//   ServiceDetailData data;
//
//   ServiceDetailsResponse({
//     required this.message,
//     required this.status,
//     required this.data,
//   });
//
//   factory ServiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
//       ServiceDetailsResponse(
//         message: json["message"],
//         status: json["status"],
//         data: ServiceDetailData.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data.toJson(),
//       };
// }
//
// class ServiceDetailData {
//   int id;
//   String type;
//   String name;
//   String shortDescription;
//   int discountPrice;
//   int price;
//   String status;
//   DateTime createdAt;
//   dynamic updatedAt;
//   String image;
//   String icon;
//   List<Media> media;
//
//   ServiceDetailData({
//     required this.id,
//     required this.type,
//     required this.name,
//     required this.shortDescription,
//     required this.discountPrice,
//     required this.price,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.image,
//     required this.icon,
//     required this.media,
//   });
//
//   factory ServiceDetailData.fromJson(Map<String, dynamic> json) =>
//       ServiceDetailData(
//         id: json["id"],
//         type: json["type"],
//         name: json["name"],
//         shortDescription: json["short_description"],
//         discountPrice: json["discount_price"],
//         price: json["price"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"],
//         image: json["image"],
//         icon: json["icon"],
//         media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": type,
//         "name": name,
//         "short_description": shortDescription,
//         "discount_price": discountPrice,
//         "price": price,
//         "status": status,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt,
//         "image": image,
//         "icon": icon,
//         "media": List<dynamic>.from(media.map((x) => x.toJson())),
//       };
// }
//
// class Media {
//   int id;
//   String modelType;
//   int modelId;
//   String collectionName;
//   String name;
//   String fileName;
//   String mimeType;
//   String disk;
//   int size;
//   List<dynamic> manipulations;
//   List<dynamic> customProperties;
//   List<dynamic> responsiveImages;
//   int orderColumn;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   Media({
//     required this.id,
//     required this.modelType,
//     required this.modelId,
//     required this.collectionName,
//     required this.name,
//     required this.fileName,
//     required this.mimeType,
//     required this.disk,
//     required this.size,
//     required this.manipulations,
//     required this.customProperties,
//     required this.responsiveImages,
//     required this.orderColumn,
//     required this.createdAt,
//     required this.updatedAt,
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
//         manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
//         customProperties:
//             List<dynamic>.from(json["custom_properties"].map((x) => x)),
//         responsiveImages:
//             List<dynamic>.from(json["responsive_images"].map((x) => x)),
//         orderColumn: json["order_column"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
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
//         "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
//         "custom_properties": List<dynamic>.from(customProperties.map((x) => x)),
//         "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
//         "order_column": orderColumn,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
// To parse this JSON data, do
//
//     final serviceDetailsResponse = serviceDetailsResponseFromJson(jsonString);

import 'dart:convert';

ServiceDetailsResponse serviceDetailsResponseFromJson(String str) =>
    ServiceDetailsResponse.fromJson(json.decode(str));

String serviceDetailsResponseToJson(ServiceDetailsResponse data) =>
    json.encode(data.toJson());

class ServiceDetailsResponse {
  String? message;
  int? status;
  ServiceDetailData data;

  ServiceDetailsResponse({
    this.message,
    this.status,
    required this.data,
  });

  factory ServiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsResponse(
        message: json["message"],
        status: json["status"],
        data: ServiceDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class ServiceDetailData {
  int? id;
  String? type;
  String? name;
  dynamic carModelId;
  String shortDescription;
  int? discountPrice;
  int? price;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String image;
  String? icon;
  List<GetService> getService;
  List<Media>? media;

  ServiceDetailData({
    this.id,
    this.type,
    this.name,
    this.carModelId,
    required this.shortDescription,
    this.discountPrice,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    required this.image,
    this.icon,
    required this.getService,
    this.media,
  });

  factory ServiceDetailData.fromJson(Map<String, dynamic> json) =>
      ServiceDetailData(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        carModelId: json["car_model_id"],
        shortDescription: json["short_description"],
        discountPrice: json["discount_price"],
        price: json["price"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        image: json["image"],
        icon: json["icon"],
        getService: json["get_service"] == null
            ? []
            : List<GetService>.from(
                json["get_service"]!.map((x) => GetService.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "car_model_id": carModelId,
        "short_description": shortDescription,
        "discount_price": discountPrice,
        "price": price,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image": image,
        "icon": icon,
        "get_service": getService == null
            ? []
            : List<dynamic>.from(getService!.map((x) => x.toJson())),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class GetService {
  int? id;
  int? serviceId;
  String name;
  String? status;
  dynamic createdAt;
  DateTime? updatedAt;

  GetService({
    this.id,
    this.serviceId,
    required this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory GetService.fromJson(Map<String, dynamic> json) => GetService(
        id: json["id"],
        serviceId: json["service_id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "name": name,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  int? size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? responsiveImages;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Media({
    this.id,
    this.modelType,
    this.modelId,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: json["model_type"],
        modelId: json["model_id"],
        collectionName: json["collection_name"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        disk: json["disk"],
        size: json["size"],
        manipulations: json["manipulations"] == null
            ? []
            : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
        customProperties: json["custom_properties"] == null
            ? []
            : List<dynamic>.from(json["custom_properties"]!.map((x) => x)),
        responsiveImages: json["responsive_images"] == null
            ? []
            : List<dynamic>.from(json["responsive_images"]!.map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_type": modelType,
        "model_id": modelId,
        "collection_name": collectionName,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeType,
        "disk": disk,
        "size": size,
        "manipulations": manipulations == null
            ? []
            : List<dynamic>.from(manipulations!.map((x) => x)),
        "custom_properties": customProperties == null
            ? []
            : List<dynamic>.from(customProperties!.map((x) => x)),
        "responsive_images": responsiveImages == null
            ? []
            : List<dynamic>.from(responsiveImages!.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
