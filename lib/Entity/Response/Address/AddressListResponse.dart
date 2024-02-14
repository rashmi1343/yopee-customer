// To parse this JSON data, do
//
//     final addressListResponse = addressListResponseFromJson(jsonString);

import 'dart:convert';

AddressListResponse addressListResponseFromJson(String str) =>
    AddressListResponse.fromJson(json.decode(str));

String addressListResponseToJson(AddressListResponse data) =>
    json.encode(data.toJson());

class AddressListResponse {
  String? message;
  int? status;
  List<AddressListData> data;

  AddressListResponse({
    this.message,
    this.status,
    required this.data,
  });

  factory AddressListResponse.fromJson(Map<String, dynamic> json) =>
      AddressListResponse(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AddressListData>.from(
                json["data"]!.map((x) => AddressListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AddressListData {
  int? id;
  int? userId;
  String? type;
  String? flatHouseNo;
  String? areaSector;
  String? nearby;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isAddressSelected = false;

  AddressListData({
    this.id,
    this.userId,
    this.type,
    this.flatHouseNo,
    this.areaSector,
    this.nearby,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressListData.fromJson(Map<String, dynamic> json) =>
      AddressListData(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        type: json["type"] ?? "",
        flatHouseNo: json["flat_house_no"] ?? "",
        areaSector: json["area_sector"] ?? "",
        nearby: json["nearby"] ?? "",
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
