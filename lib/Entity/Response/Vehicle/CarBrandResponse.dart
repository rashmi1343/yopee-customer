// To parse this JSON data, do
//
//     final carBrandResponse = carBrandResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CarBrandResponse carBrandResponseFromJson(String str) =>
    CarBrandResponse.fromJson(json.decode(str));

String carBrandResponseToJson(CarBrandResponse data) =>
    json.encode(data.toJson());

class CarBrandResponse {
  String message;
  int status;
  List<CarBrandData> data;

  CarBrandResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory CarBrandResponse.fromJson(Map<String, dynamic> json) =>
      CarBrandResponse(
        message: json["message"],
        status: json["status"],
        data: List<CarBrandData>.from(
            json["data"].map((x) => CarBrandData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CarBrandData {
  int id;
  String name;
  String image;
  List<dynamic> media;

  CarBrandData({
    required this.id,
    required this.name,
    required this.image,
    required this.media,
  });

  factory CarBrandData.fromJson(Map<String, dynamic> json) => CarBrandData(
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
