// To parse this JSON data, do
//
//     final subscriptionDetailsResponse = subscriptionDetailsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SubscriptionDetailsResponse subscriptionDetailsResponseFromJson(String str) =>
    SubscriptionDetailsResponse.fromJson(json.decode(str));

String subscriptionDetailsResponseToJson(SubscriptionDetailsResponse data) =>
    json.encode(data.toJson());

class SubscriptionDetailsResponse {
  String message;
  int status;
  SubDetailsData data;

  SubscriptionDetailsResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory SubscriptionDetailsResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetailsResponse(
        message: json["message"],
        status: json["status"],
        data: SubDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class SubDetailsData {
  int id;
  String name;
  int price;
  String duration;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  List<SubscriptionDetail> subscriptionDetails;
  List<Media> media;

  SubDetailsData({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.subscriptionDetails,
    required this.media,
  });

  factory SubDetailsData.fromJson(Map<String, dynamic> json) => SubDetailsData(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        duration: json["duration"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
        subscriptionDetails: List<SubscriptionDetail>.from(
            json["subscription_details"]
                .map((x) => SubscriptionDetail.fromJson(x))),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "duration": duration,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image,
        "subscription_details":
            List<dynamic>.from(subscriptionDetails.map((x) => x.toJson())),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}

class Media {
  int id;
  String modelType;
  int modelId;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  int size;
  List<dynamic> manipulations;
  List<dynamic> customProperties;
  List<dynamic> responsiveImages;
  int orderColumn;
  DateTime createdAt;
  DateTime updatedAt;

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
        manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
        customProperties:
            List<dynamic>.from(json["custom_properties"].map((x) => x)),
        responsiveImages:
            List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
        "custom_properties": List<dynamic>.from(customProperties.map((x) => x)),
        "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SubscriptionDetail {
  int id;
  int subscriptionId;
  String name;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  SubscriptionDetail({
    required this.id,
    required this.subscriptionId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionDetail.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetail(
        id: json["id"],
        subscriptionId: json["subscription_id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscription_id": subscriptionId,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
