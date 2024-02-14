// To parse this JSON data, do
//
//     final vehicleTypeResponse = vehicleTypeResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VehicleTypeResponse vehicleTypeResponseFromJson(String str) =>
    VehicleTypeResponse.fromJson(json.decode(str));

String vehicleTypeResponseToJson(VehicleTypeResponse data) =>
    json.encode(data.toJson());

class VehicleTypeResponse {
  String message;
  int status;
  List<VehicleTypeData> data;

  VehicleTypeResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory VehicleTypeResponse.fromJson(Map<String, dynamic> json) =>
      VehicleTypeResponse(
        message: json["message"],
        status: json["status"],
        data: List<VehicleTypeData>.from(
            json["data"].map((x) => VehicleTypeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VehicleTypeData {
  int id;
  String name;
  String image;
  List<Media> media;

  VehicleTypeData({
    required this.id,
    required this.name,
    required this.image,
    required this.media,
  });

  factory VehicleTypeData.fromJson(Map<String, dynamic> json) =>
      VehicleTypeData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
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
