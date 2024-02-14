// To parse this JSON data, do
//
//     final vehicleAddResponse = vehicleAddResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VehicleAddResponse vehicleAddResponseFromJson(String str) =>
    VehicleAddResponse.fromJson(json.decode(str));

String vehicleAddResponseToJson(VehicleAddResponse data) =>
    json.encode(data.toJson());

class VehicleAddResponse {
  String message;
  int status;
  VehicleAddData data;

  VehicleAddResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory VehicleAddResponse.fromJson(Map<String, dynamic> json) =>
      VehicleAddResponse(
        message: json["message"],
        status: json["status"],
        data: VehicleAddData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class VehicleAddData {
  int userId;
  String vehicleTypeId;
  String carBrandId;
  String carModelId;
  String registrationNo;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  VehicleAddData({
    required this.userId,
    required this.vehicleTypeId,
    required this.carBrandId,
    required this.carModelId,
    required this.registrationNo,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory VehicleAddData.fromJson(Map<String, dynamic> json) => VehicleAddData(
        userId: json["user_id"],
        vehicleTypeId: json["vehicle_type_id"],
        carBrandId: json["car_brand_id"],
        carModelId: json["car_model_id"],
        registrationNo: json["registration_no"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "vehicle_type_id": vehicleTypeId,
        "car_brand_id": carBrandId,
        "car_model_id": carModelId,
        "registration_no": registrationNo,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
