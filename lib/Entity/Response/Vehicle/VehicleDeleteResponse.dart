// To parse this JSON data, do
//
//     final vehicleDeleteResponse = vehicleDeleteResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VehicleDeleteResponse vehicleDeleteResponseFromJson(String str) =>
    VehicleDeleteResponse.fromJson(json.decode(str));

String vehicleDeleteResponseToJson(VehicleDeleteResponse data) =>
    json.encode(data.toJson());

class VehicleDeleteResponse {
  String message;
  int status;
  dynamic data;

  VehicleDeleteResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory VehicleDeleteResponse.fromJson(Map<String, dynamic> json) =>
      VehicleDeleteResponse(
        message: json["message"],
        status: json["status"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data,
      };
}

class VehicleDeleteData {
  int id;
  int userId;
  int vehicleTypeId;
  int carBrandId;
  int carModelId;
  String registrationNo;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleDeleteData({
    required this.id,
    required this.userId,
    required this.vehicleTypeId,
    required this.carBrandId,
    required this.carModelId,
    required this.registrationNo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleDeleteData.fromJson(Map<String, dynamic> json) =>
      VehicleDeleteData(
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
