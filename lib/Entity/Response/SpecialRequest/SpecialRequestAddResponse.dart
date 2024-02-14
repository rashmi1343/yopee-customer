// To parse this JSON data, do
//
//     final specialRequestAddResponse = specialRequestAddResponseFromJson(jsonString);

import 'dart:convert';

SpecialRequestAddResponse specialRequestAddResponseFromJson(String str) =>
    SpecialRequestAddResponse.fromJson(json.decode(str));

String specialRequestAddResponseToJson(SpecialRequestAddResponse data) =>
    json.encode(data.toJson());

class SpecialRequestAddResponse {
  String? message;
  int? status;
  SpecialRequestAddData? data;

  SpecialRequestAddResponse({
    this.message,
    this.status,
    this.data,
  });

  factory SpecialRequestAddResponse.fromJson(Map<String, dynamic> json) =>
      SpecialRequestAddResponse(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? null
            : SpecialRequestAddData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class SpecialRequestAddData {
  int? userId;
  String? userVehicleId;
  String? userAddressId;
  String? serviceId;
  dynamic requestTime;
  String? type;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  SpecialRequestAddData({
    this.userId,
    this.userVehicleId,
    this.userAddressId,
    this.serviceId,
    this.requestTime,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory SpecialRequestAddData.fromJson(Map<String, dynamic> json) =>
      SpecialRequestAddData(
        userId: json["user_id"],
        userVehicleId: json["user_vehicle_id"],
        userAddressId: json["user_address_id"],
        serviceId: json["service_id"],
        requestTime: json["request_time"],
        type: json["type"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_vehicle_id": userVehicleId,
        "user_address_id": userAddressId,
        "service_id": serviceId,
        "request_time": requestTime,
        "type": type,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
