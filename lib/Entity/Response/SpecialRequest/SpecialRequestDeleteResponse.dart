// To parse this JSON data, do
//
//     final specialRequestDeleteResponse = specialRequestDeleteResponseFromJson(jsonString);

import 'dart:convert';

SpecialRequestDeleteResponse specialRequestDeleteResponseFromJson(String str) =>
    SpecialRequestDeleteResponse.fromJson(json.decode(str));

String specialRequestDeleteResponseToJson(SpecialRequestDeleteResponse data) =>
    json.encode(data.toJson());

class SpecialRequestDeleteResponse {
  String? message;
  int? status;
  SpclRequestDeleteData? data;

  SpecialRequestDeleteResponse({
    this.message,
    this.status,
    this.data,
  });

  factory SpecialRequestDeleteResponse.fromJson(Map<String, dynamic> json) =>
      SpecialRequestDeleteResponse(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? null
            : SpclRequestDeleteData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class SpclRequestDeleteData {
  int? id;
  String? type;
  int? userId;
  int? userVehicleId;
  int? userAddressId;
  dynamic serviceId;
  int? subscriptionId;
  String? message;
  int? assignedBy;
  DateTime? assignedAt;
  dynamic actionBy;
  dynamic actionAt;
  dynamic actionReason;
  dynamic actionMessage;
  DateTime? fromDate;
  dynamic toDate;
  dynamic requestTime;
  String? comment;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  SpclRequestDeleteData({
    this.id,
    this.type,
    this.userId,
    this.userVehicleId,
    this.userAddressId,
    this.serviceId,
    this.subscriptionId,
    this.message,
    this.assignedBy,
    this.assignedAt,
    this.actionBy,
    this.actionAt,
    this.actionReason,
    this.actionMessage,
    this.fromDate,
    this.toDate,
    this.requestTime,
    this.comment,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SpclRequestDeleteData.fromJson(Map<String, dynamic> json) =>
      SpclRequestDeleteData(
        id: json["id"],
        type: json["type"],
        userId: json["user_id"],
        userVehicleId: json["user_vehicle_id"],
        userAddressId: json["user_address_id"],
        serviceId: json["service_id"],
        subscriptionId: json["subscription_id"],
        message: json["message"],
        assignedBy: json["assigned_by"],
        assignedAt: json["assigned_at"] == null
            ? null
            : DateTime.parse(json["assigned_at"]),
        actionBy: json["action_by"],
        actionAt: json["action_at"],
        actionReason: json["action_reason"],
        actionMessage: json["action_message"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate: json["to_date"],
        requestTime: json["request_time"],
        comment: json["comment"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "user_id": userId,
        "user_vehicle_id": userVehicleId,
        "user_address_id": userAddressId,
        "service_id": serviceId,
        "subscription_id": subscriptionId,
        "message": message,
        "assigned_by": assignedBy,
        "assigned_at": assignedAt?.toIso8601String(),
        "action_by": actionBy,
        "action_at": actionAt,
        "action_reason": actionReason,
        "action_message": actionMessage,
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date": toDate,
        "request_time": requestTime,
        "comment": comment,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
