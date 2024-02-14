// To parse this JSON data, do
//
//     final vehicleEditResponse = vehicleEditResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VehicleEditResponse vehicleEditResponseFromJson(String str) =>
    VehicleEditResponse.fromJson(json.decode(str));

String vehicleEditResponseToJson(VehicleEditResponse data) =>
    json.encode(data.toJson());

class VehicleEditResponse {
  String message;
  int status;
  VehicleEditData data;

  VehicleEditResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory VehicleEditResponse.fromJson(Map<String, dynamic> json) =>
      VehicleEditResponse(
        message: json["message"],
        status: json["status"],
        data: VehicleEditData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class VehicleEditData {
  int id;
  int userId;
  String vehicleTypeId;
  String carBrandId;
  String carModelId;
  String registrationNo;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleEditData({
    required this.id,
    required this.userId,
    required this.vehicleTypeId,
    required this.carBrandId,
    required this.carModelId,
    required this.registrationNo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleEditData.fromJson(Map<String, dynamic> json) =>
      VehicleEditData(
        id: json["id"],
        userId: json["user_id"],
        vehicleTypeId: json["vehicle_type_id"],
        carBrandId: json["car_brand_id"],
        carModelId: json["car_model_id"],
        registrationNo: json["registration_no"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vehicle_type_id": vehicleTypeId,
        "car_brand_id": carBrandId,
        "car_model_id": carModelId,
        "registration_no": registrationNo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
