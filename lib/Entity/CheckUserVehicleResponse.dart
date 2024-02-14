// To parse this JSON data, do
//
//     final checkUserVehicleResponse = checkUserVehicleResponseFromJson(jsonString);

import 'dart:convert';

CheckUserVehicleResponse checkUserVehicleResponseFromJson(String str) =>
    CheckUserVehicleResponse.fromJson(json.decode(str));

String checkUserVehicleResponseToJson(CheckUserVehicleResponse data) =>
    json.encode(data.toJson());

class CheckUserVehicleResponse {
  String? message;
  int? status;
  dynamic data;

  CheckUserVehicleResponse({
    this.message,
    this.status,
    required this.data,
  });

  factory CheckUserVehicleResponse.fromJson(Map<String, dynamic> json) =>
      CheckUserVehicleResponse(
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

class CheckUserVehicleData {
  int? id;
  String? type;
  int? userId;
  int? userVehicleId;
  int? userAddressId;
  dynamic serviceId;
  int? subscriptionId;
  dynamic message;
  int? assignedBy;
  DateTime? assignedAt;
  dynamic actionBy;
  dynamic actionAt;
  dynamic actionReason;
  dynamic actionMessage;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic requestTime;
  int? rating;
  String? comment;
  String? status;
  String? expiredStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? actionImageUrl;
  List<dynamic>? media;

  CheckUserVehicleData({
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
    this.rating,
    this.comment,
    this.status,
    this.expiredStatus,
    this.createdAt,
    this.updatedAt,
    this.actionImageUrl,
    this.media,
  });

  factory CheckUserVehicleData.fromJson(Map<String, dynamic> json) =>
      CheckUserVehicleData(
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
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        requestTime: json["request_time"],
        rating: json["rating"],
        comment: json["comment"],
        status: json["status"],
        expiredStatus: json["expired_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        actionImageUrl: json["action_image_url"],
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
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
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "request_time": requestTime,
        "rating": rating,
        "comment": comment,
        "status": status,
        "expired_status": expiredStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "action_image_url": actionImageUrl,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
      };
}
