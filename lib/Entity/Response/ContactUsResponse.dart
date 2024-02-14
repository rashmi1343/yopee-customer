// To parse this JSON data, do
//
//     final contactUsResponse = contactUsResponseFromJson(jsonString);

import 'dart:convert';

ContactUsResponse contactUsResponseFromJson(String str) =>
    ContactUsResponse.fromJson(json.decode(str));

String contactUsResponseToJson(ContactUsResponse data) =>
    json.encode(data.toJson());

class ContactUsResponse {
  String? message;
  int? status;
  ContactUsData? data;

  ContactUsResponse({
    this.message,
    this.status,
    this.data,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      ContactUsResponse(
        message: json["message"],
        status: json["status"],
        data:
            json["data"] == null ? null : ContactUsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class ContactUsData {
  int? userId;
  String? serviceName;
  String? message;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  ContactUsData({
    this.userId,
    this.serviceName,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory ContactUsData.fromJson(Map<String, dynamic> json) => ContactUsData(
        userId: json["user_id"],
        serviceName: json["service_name"],
        message: json["message"],
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
        "service_name": serviceName,
        "message": message,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
