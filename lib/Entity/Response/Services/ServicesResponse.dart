// To parse this JSON data, do
//
//     final servicesResponse = servicesResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServicesResponse servicesResponseFromJson(String str) =>
    ServicesResponse.fromJson(json.decode(str));

class ServicesResponse {
  ServicesResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final int? status;
  final List<ServiceData> data;

  factory ServicesResponse.fromJson(Map<String, dynamic> json) {
    return ServicesResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<ServiceData>.from(
              json["data"]!.map((x) => ServiceData.fromJson(x))),
    );
  }
}

class ServiceData {
  ServiceData({
    required this.id,
    required this.type,
    required this.name,
    required this.shortDescription,
    required this.discountPrice,
    required this.price,
    required this.timeDuration,
    required this.status,
    required this.image,
    required this.icon,
    required this.getServiceDetails,
    required this.media,
  });

  final int id;
  final String type;
  final String name;
  final String shortDescription;
  final int discountPrice;
  final int price;
  final String timeDuration;
  final String status;
  final String image;
  final String icon;
  final List<GetServiceDetail> getServiceDetails;
  final List<Media> media;

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      shortDescription: json["short_description"],
      discountPrice: json["discount_price"],
      price: json["price"],
      timeDuration: json["time_duration"],
      status: json["status"],
      image: json["image"],
      icon: json["icon"],
      getServiceDetails: json["get_service_details"] == null
          ? []
          : List<GetServiceDetail>.from(json["get_service_details"]!
              .map((x) => GetServiceDetail.fromJson(x))),
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );
  }
}

class GetServiceDetail {
  GetServiceDetail({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? serviceId;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetServiceDetail.fromJson(Map<String, dynamic> json) {
    return GetServiceDetail(
      id: json["id"],
      serviceId: json["service_id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
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
    required this.deletedAt,
  });

  final int? id;
  final String? modelType;
  final int? modelId;
  final String? collectionName;
  final String? name;
  final String? fileName;
  final String? mimeType;
  final String? disk;
  final int? size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final List<dynamic> responsiveImages;
  final int? orderColumn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
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
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
    );
  }
}
