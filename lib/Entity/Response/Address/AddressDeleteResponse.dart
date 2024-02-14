// To parse this JSON data, do
//
//     final addressDeleteResponse = addressDeleteResponseFromJson(jsonString);

import 'dart:convert';

AddressDeleteResponse addressDeleteResponseFromJson(String str) =>
    AddressDeleteResponse.fromJson(json.decode(str));

String addressDeleteResponseToJson(AddressDeleteResponse data) =>
    json.encode(data.toJson());

class AddressDeleteResponse {
  String? message;
  int? status;
  AddressDeleteData? data;

  AddressDeleteResponse({
    this.message,
    this.status,
    this.data,
  });

  factory AddressDeleteResponse.fromJson(Map<String, dynamic> json) =>
      AddressDeleteResponse(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? null
            : AddressDeleteData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class AddressDeleteData {
  int? id;
  int? userId;
  String? type;
  String? flatHouseNo;
  String? areaSector;
  String? nearby;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddressDeleteData({
    this.id,
    this.userId,
    this.type,
    this.flatHouseNo,
    this.areaSector,
    this.nearby,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressDeleteData.fromJson(Map<String, dynamic> json) =>
      AddressDeleteData(
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
