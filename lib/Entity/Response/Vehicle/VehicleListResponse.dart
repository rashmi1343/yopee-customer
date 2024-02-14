// To parse this JSON data, do
//
//     final vehicleListResponse = vehicleListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VehicleListResponse vehicleListResponseFromJson(String str) =>
    VehicleListResponse.fromJson(json.decode(str));

class VehicleListResponse {
  VehicleListResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final int? status;
  final VehicleListData data;

  factory VehicleListResponse.fromJson(Map<String, dynamic> json) {
    return VehicleListResponse(
      message: json["message"],
      status: json["status"],
      data: VehicleListData.fromJson(json["data"]),
    );
  }
}

class VehicleListData {
  VehicleListData({
    required this.totalUserVehicle,
    required this.userVehicles,
  });

  final int totalUserVehicle;
  final List<UserVehicle> userVehicles;

  factory VehicleListData.fromJson(Map<String, dynamic> json) {
    return VehicleListData(
      totalUserVehicle: json["totalUserVehicle"],
      userVehicles: json["userVehicles"] == null
          ? []
          : List<UserVehicle>.from(
              json["userVehicles"]!.map((x) => UserVehicle.fromJson(x))),
    );
  }
}

class UserVehicle {
  UserVehicle({
    required this.id,
    required this.userId,
    required this.vehicleTypeId,
    required this.carBrandId,
    required this.carModelId,
    required this.registrationNo,
    required this.createdAt,
    required this.updatedAt,
    required this.brand,
    required this.model,
    required this.vehicle,
    required this.service,
    required this.booking,
  });

  final int? id;
  final int? userId;
  final int? vehicleTypeId;
  final int? carBrandId;
  final int? carModelId;
  final String? registrationNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Brand brand;
  final Brand model;
  final Brand vehicle;
  final List<Service> service;
  final List<Booking> booking;
  bool selectedVehicle = false;

  factory UserVehicle.fromJson(Map<String, dynamic> json) {
    return UserVehicle(
      id: json["id"],
      userId: json["user_id"],
      vehicleTypeId: json["vehicle_type_id"],
      carBrandId: json["car_brand_id"],
      carModelId: json["car_model_id"],
      registrationNo: json["registration_no"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      brand: Brand.fromJson(json["brand"]),
      model: Brand.fromJson(json["model"]),
      vehicle: Brand.fromJson(json["vehicle"]),
      service: json["service"] == null
          ? []
          : List<Service>.from(
              json["service"]!.map((x) => Service.fromJson(x))),
      booking: json["booking"] == null
          ? []
          : List<Booking>.from(
              json["booking"]!.map((x) => Booking.fromJson(x))),
    );
  }
}

class Booking {
  Booking({
    required this.id,
    required this.type,
    required this.userId,
    required this.userVehicleId,
    required this.userAddressId,
    required this.serviceId,
    required this.subscriptionId,
    required this.message,
    required this.assignedBy,
    required this.assignedAt,
    required this.actionBy,
    required this.actionAt,
    required this.actionReason,
    required this.actionMessage,
    required this.fromDate,
    required this.toDate,
    required this.requestTime,
    required this.rating,
    required this.comment,
    required this.status,
    required this.expiredStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.actionImageUrl,
    required this.media,
  });

  final int? id;
  final String? type;
  final int? userId;
  final int? userVehicleId;
  final int? userAddressId;
  final dynamic serviceId;
  final int? subscriptionId;
  final String? message;
  final int? assignedBy;
  final DateTime? assignedAt;
  final int? actionBy;
  final DateTime? actionAt;
  final dynamic actionReason;
  final dynamic actionMessage;
  final DateTime? fromDate;
  final DateTime? toDate;
  final dynamic requestTime;
  final int? rating;
  final String? comment;
  final String? status;
  final String? expiredStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? actionImageUrl;
  final List<Media> media;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json["id"],
      type: json["type"],
      userId: json["user_id"],
      userVehicleId: json["user_vehicle_id"],
      userAddressId: json["user_address_id"],
      serviceId: json["service_id"],
      subscriptionId: json["subscription_id"],
      message: json["message"],
      assignedBy: json["assigned_by"],
      assignedAt: DateTime.tryParse(json["assigned_at"] ?? ""),
      actionBy: json["action_by"],
      actionAt: DateTime.tryParse(json["action_at"] ?? ""),
      actionReason: json["action_reason"],
      actionMessage: json["action_message"],
      fromDate: DateTime.tryParse(json["from_date"] ?? ""),
      toDate: DateTime.tryParse(json["to_date"] ?? ""),
      requestTime: json["request_time"],
      rating: json["rating"],
      comment: json["comment"],
      status: json["status"],
      expiredStatus: json["expired_status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      actionImageUrl: json["action_image_url"],
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );
  }
}

class Media {
  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final int? id;
  final String? modelType;
  final int? modelId;
  final String? collectionName;
  final String? name;
  final String? fileName;
  final String? mimeType;
  final String? disk;
  final int? size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final List<dynamic> responsiveImages;
  final int? orderColumn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      modelType: json["model_type"],
      modelId: json["model_id"],
      collectionName: json["collection_name"],
      name: json["name"],
      fileName: json["file_name"],
      mimeType: json["mime_type"],
      disk: json["disk"],
      size: json["size"],
      manipulations: json["manipulations"] == null
          ? []
          : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
      customProperties: json["custom_properties"] == null
          ? []
          : List<dynamic>.from(json["custom_properties"]!.map((x) => x)),
      responsiveImages: json["responsive_images"] == null
          ? []
          : List<dynamic>.from(json["responsive_images"]!.map((x) => x)),
      orderColumn: json["order_column"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
    );
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.media,
    required this.carBrandId,
    required this.carModelId,
  });

  final int? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  final List<Media> media;
  final int? carBrandId;
  final int? carModelId;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      image: json["image"],
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      carBrandId: json["car_brand_id"],
      carModelId: json["car_model_id"],
    );
  }
}

class Service {
  Service({
    required this.id,
    required this.type,
    required this.name,
    required this.carBrandId,
    required this.carModelId,
    required this.carVehicleId,
    required this.shortDescription,
    required this.discountPrice,
    required this.price,
    required this.timeDuration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.icon,
    required this.getServiceDetails,
    required this.media,
  });

  final int? id;
  final String? type;
  final String? name;
  final int? carBrandId;
  final int? carModelId;
  final int? carVehicleId;
  final String? shortDescription;
  final int? discountPrice;
  final int? price;
  final String? timeDuration;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  final String? icon;
  final List<GetServiceDetail> getServiceDetails;
  final List<Media> media;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      carBrandId: json["car_brand_id"],
      carModelId: json["car_model_id"],
      carVehicleId: json["car_vehicle_id"],
      shortDescription: json["short_description"],
      discountPrice: json["discount_price"],
      price: json["price"],
      timeDuration: json["time_duration"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      image: json["image"],
      icon: json["icon"],
      getServiceDetails: json["get_service_details"] == null
          ? []
          : List<GetServiceDetail>.from(json["get_service_details"]!
              .map((x) => GetServiceDetail.fromJson(x))),
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );
  }
}

class GetServiceDetail {
  GetServiceDetail({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? serviceId;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetServiceDetail.fromJson(Map<String, dynamic> json) {
    return GetServiceDetail(
      id: json["id"],
      serviceId: json["service_id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
