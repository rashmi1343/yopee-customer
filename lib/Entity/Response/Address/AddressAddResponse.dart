// To parse this JSON data, do
//
//     final addressAddResponse = addressAddResponseFromJson(jsonString);

import 'dart:convert';

AddressAddResponse addressAddResponseFromJson(String str) =>
    AddressAddResponse.fromJson(json.decode(str));

String addressAddResponseToJson(AddressAddResponse data) =>
    json.encode(data.toJson());

class AddressAddResponse {
  String? message;
  int? status;
  AddressAddData? data;

  AddressAddResponse({
    this.message,
    this.status,
    this.data,
  });

  factory AddressAddResponse.fromJson(Map<String, dynamic> json) =>
      AddressAddResponse(
        message: json["message"],
        status: json["status"],
        data:
            json["data"] == null ? null : AddressAddData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class AddressAddData {
  int? userId;
  String? type;
  String? flatHouseNo;
  String? areaSector;
  String? nearby;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  AddressAddData({
    this.userId,
    this.type,
    this.flatHouseNo,
    this.areaSector,
    this.nearby,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory AddressAddData.fromJson(Map<String, dynamic> json) => AddressAddData(
        userId: json["user_id"],
        type: json["type"],
        flatHouseNo: json["flat_house_no"],
        areaSector: json["area_sector"],
        nearby: json["nearby"],
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
        "type": type,
        "flat_house_no": flatHouseNo,
        "area_sector": areaSector,
        "nearby": nearby,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
