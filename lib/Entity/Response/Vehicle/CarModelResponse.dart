// To parse this JSON data, do
//
//     final carModelResponse = carModelResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CarModelResponse carModelResponseFromJson(String str) =>
    CarModelResponse.fromJson(json.decode(str));

String carModelResponseToJson(CarModelResponse data) =>
    json.encode(data.toJson());

class CarModelResponse {
  String message;
  int status;
  List<CarModelData> data;

  CarModelResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory CarModelResponse.fromJson(Map<String, dynamic> json) =>
      CarModelResponse(
        message: json["message"],
        status: json["status"],
        data: List<CarModelData>.from(
            json["data"].map((x) => CarModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CarModelData {
  int id;
  String name;
  String image;
  List<dynamic> media;

  CarModelData({
    required this.id,
    required this.name,
    required this.image,
    required this.media,
  });

  factory CarModelData.fromJson(Map<String, dynamic> json) => CarModelData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        media: List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}
