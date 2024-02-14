// To parse this JSON data, do
//
//     final userSubscriptionAddResponse = userSubscriptionAddResponseFromJson(jsonString);

import 'dart:convert';

UserSubscriptionAddResponse userSubscriptionAddResponseFromJson(String str) =>
    UserSubscriptionAddResponse.fromJson(json.decode(str));

String userSubscriptionAddResponseToJson(UserSubscriptionAddResponse data) =>
    json.encode(data.toJson());

class UserSubscriptionAddResponse {
  String? message;
  int? status;
  dynamic data;

  UserSubscriptionAddResponse({
    this.message,
    this.status,
    this.data,
  });

  factory UserSubscriptionAddResponse.fromJson(Map<String, dynamic> json) =>
      UserSubscriptionAddResponse(
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

class UserSubsAddData {
  int? userId;
  String? userVehicleId;
  String? userAddressId;
  String? subscriptionId;
  DateTime? fromDate;
  DateTime? toDate;
  String? type;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  UserSubsAddData({
    this.userId,
    this.userVehicleId,
    this.userAddressId,
    this.subscriptionId,
    this.fromDate,
    this.toDate,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UserSubsAddData.fromJson(Map<String, dynamic> json) =>
      UserSubsAddData(
        userId: json["user_id"],
        userVehicleId: json["user_vehicle_id"],
        userAddressId: json["user_address_id"],
        subscriptionId: json["subscription_id"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
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
        "subscription_id": subscriptionId,
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "type": type,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
