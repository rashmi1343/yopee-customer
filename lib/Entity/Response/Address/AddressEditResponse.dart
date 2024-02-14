// To parse this JSON data, do
//
//     final addressEditResponse = addressEditResponseFromJson(jsonString);

import 'dart:convert';

AddressEditResponse addressEditResponseFromJson(String str) =>
    AddressEditResponse.fromJson(json.decode(str));

String addressEditResponseToJson(AddressEditResponse data) =>
    json.encode(data.toJson());

class AddressEditResponse {
  String? message;
  int? status;
  AddressEditData? data;

  AddressEditResponse({
    this.message,
    this.status,
    this.data,
  });

  factory AddressEditResponse.fromJson(Map<String, dynamic> json) =>
      AddressEditResponse(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? null
            : AddressEditData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class AddressEditData {
  int? id;
  int? userId;
  String? type;
  String? flatHouseNo;
  String? areaSector;
  String? nearby;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddressEditData({
    this.id,
    this.userId,
    this.type,
    this.flatHouseNo,
    this.areaSector,
    this.nearby,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressEditData.fromJson(Map<String, dynamic> json) =>
      AddressEditData(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        flatHouseNo: json["flat_house_no"],
        areaSector: json["area_sector"],
        nearby: json["nearby"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "flat_house_no": flatHouseNo,
        "area_sector": areaSector,
        "nearby": nearby,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
