// To parse this JSON data, do
//
//     final renewSubsResponse = renewSubsResponseFromJson(jsonString);

import 'dart:convert';

RenewSubsResponse renewSubsResponseFromJson(String str) =>
    RenewSubsResponse.fromJson(json.decode(str));

String renewSubsResponseToJson(RenewSubsResponse data) =>
    json.encode(data.toJson());

class RenewSubsResponse {
  String? message;
  int? status;
  RenewSubsData data;

  RenewSubsResponse({
    this.message,
    this.status,
    required this.data,
  });

  factory RenewSubsResponse.fromJson(Map<String, dynamic> json) =>
      RenewSubsResponse(
        message: json["message"],
        status: json["status"],
        data: RenewSubsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class RenewSubsData {
  int? userId;
  String? userVehicleId;
  String? userAddressId;
  String? subscriptionId;
  String? assignedBy;
  DateTime? assignedAt;
  DateTime? fromDate;
  DateTime? toDate;
  String? type;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  RenewSubsData({
    this.userId,
    this.userVehicleId,
    this.userAddressId,
    this.subscriptionId,
    this.assignedBy,
    this.assignedAt,
    this.fromDate,
    this.toDate,
    this.type,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory RenewSubsData.fromJson(Map<String, dynamic> json) => RenewSubsData(
        userId: json["user_id"],
        userVehicleId: json["user_vehicle_id"],
        userAddressId: json["user_address_id"],
        subscriptionId: json["subscription_id"],
        assignedBy: json["assigned_by"],
        assignedAt: json["assigned_at"] == null
            ? null
            : DateTime.parse(json["assigned_at"]),
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        type: json["type"],
        status: json["status"],
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
        "subscription_id": subscriptionId,
        "assigned_by": assignedBy,
        "assigned_at": assignedAt?.toIso8601String(),
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "type": type,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
