// To parse this JSON data, do
//
//     final rateWashResponse = rateWashResponseFromJson(jsonString);

import 'dart:convert';

RateWashResponse rateWashResponseFromJson(String str) =>
    RateWashResponse.fromJson(json.decode(str));

String rateWashResponseToJson(RateWashResponse data) =>
    json.encode(data.toJson());

class RateWashResponse {
  String? message;
  int? status;
  RateWashDataItems data;

  RateWashResponse({
    this.message,
    this.status,
    required this.data,
  });

  factory RateWashResponse.fromJson(Map<String, dynamic> json) =>
      RateWashResponse(
        message: json["message"],
        status: json["status"],
        data: RateWashDataItems.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class RateWashDataItems {
  int? userId;
  String? userType;
  String? bookingId;
  String icon;
  String rating;
  String feedback;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? document;
  List<String> media;

  RateWashDataItems({
    this.userId,
    this.userType,
    this.bookingId,
    required this.icon,
    required this.rating,
    required this.feedback,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.document,
    required this.media,
  });

  factory RateWashDataItems.fromJson(Map<String, dynamic> json) =>
      RateWashDataItems(
        userId: json["user_id"],
        userType: json["user_type"],
        bookingId: json["booking_id"],
        icon: json["icon"],
        rating: json["rating"],
        feedback: json["feedback"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        document: json["document"],
        media: json["media"] == null
            ? []
            : List<String>.from(json["media"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_type": userType,
        "booking_id": bookingId,
        "icon": icon,
        "rating": rating,
        "feedback": feedback,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "document": document,
        "media": List<dynamic>.from(media!.map((x) => x)),
      };
}
