// // To parse this JSON data, do
// //
// //     final dashboardResponse = dashboardResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// DashboardResponse dashboardResponseFromJson(String str) =>
//     DashboardResponse.fromJson(json.decode(str));
//
// String dashboardResponseToJson(DashboardResponse data) =>
//     json.encode(data.toJson());
//
// class DashboardResponse {
//   String? message;
//   int? status;
//   DashboardData data;
//
//   DashboardResponse({
//     this.message,
//     this.status,
//     required this.data,
//   });
//
//   factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
//       DashboardResponse(
//         message: json["message"],
//         status: json["status"],
//         data: DashboardData.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data?.toJson(),
//       };
// }
//
// class DashboardData {
//   Banners banners;
//   Banners services;
//   Rating rating;
//
//   DashboardData({
//     required this.banners,
//     required this.services,
//     required this.rating,
//   });
//
//   factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
//         banners: Banners.fromJson(json["banners"]),
//         services: Banners.fromJson(json["services"]),
//         rating: Rating.fromJson(json["rating"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "banners": banners.toJson(),
//         "services": services.toJson(),
//         "rating": rating.toJson(),
//       };
// }
//
// class Banners {
//   int? currentPage;
//   List<BannersDatum>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   dynamic nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;
//
//   Banners({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   factory Banners.fromJson(Map<String, dynamic> json) => Banners(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<BannersDatum>.from(
//                 json["data"]!.map((x) => BannersDatum.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: json["links"] == null
//             ? []
//             : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": links == null
//             ? []
//             : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }
//
// class BannersDatum {
//   int? id;
//   Type? type;
//   String? name;
//   String? shortDescription;
//   int? discountPrice;
//   int? price;
//   Status? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? image;
//   String? icon;
//   List<Media>? media;
//
//   BannersDatum({
//     this.id,
//     this.type,
//     this.name,
//     this.shortDescription,
//     this.discountPrice,
//     this.price,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.image,
//     this.icon,
//     this.media,
//   });
//
//   factory BannersDatum.fromJson(Map<String, dynamic> json) => BannersDatum(
//         id: json["id"],
//         type: typeValues.map[json["type"]]!,
//         name: json["name"],
//         shortDescription: json["short_description"],
//         discountPrice: json["discount_price"],
//         price: json["price"],
//         status: statusValues.map[json["status"]]!,
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         image: json["image"],
//         icon: json["icon"],
//         media: json["media"] == null
//             ? []
//             : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": typeValues.reverse[type],
//         "name": name,
//         "short_description": shortDescription,
//         "discount_price": discountPrice,
//         "price": price,
//         "status": statusValues.reverse[status],
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "image": image,
//         "icon": icon,
//         "media": media == null
//             ? []
//             : List<dynamic>.from(media!.map((x) => x.toJson())),
//       };
// }
//
// class Media {
//   int? id;
//   ModelType? modelType;
//   int? modelId;
//   CollectionName? collectionName;
//   String? name;
//   String? fileName;
//   MimeType? mimeType;
//   Disk? disk;
//   int? size;
//   List<String>? manipulations;
//   List<String>? customProperties;
//   List<String>? responsiveImages;
//   int? orderColumn;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Media({
//     this.id,
//     this.modelType,
//     this.modelId,
//     this.collectionName,
//     this.name,
//     this.fileName,
//     this.mimeType,
//     this.disk,
//     this.size,
//     this.manipulations,
//     this.customProperties,
//     this.responsiveImages,
//     this.orderColumn,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Media.fromJson(Map<String, dynamic> json) => Media(
//         id: json["id"],
//         modelType: modelTypeValues.map[json["model_type"]]!,
//         modelId: json["model_id"],
//         collectionName: collectionNameValues.map[json["collection_name"]]!,
//         name: json["name"],
//         fileName: json["file_name"],
//         mimeType: mimeTypeValues.map[json["mime_type"]]!,
//         disk: diskValues.map[json["disk"]]!,
//         size: json["size"],
//         manipulations: json["manipulations"] == null
//             ? []
//             : List<String>.from(json["manipulations"]!.map((x) => x)),
//         customProperties: json["custom_properties"] == null
//             ? []
//             : List<String>.from(json["custom_properties"]!.map((x) => x)),
//         responsiveImages: json["responsive_images"] == null
//             ? []
//             : List<String>.from(json["responsive_images"]!.map((x) => x)),
//         orderColumn: json["order_column"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "model_type": modelTypeValues.reverse[modelType],
//         "model_id": modelId,
//         "collection_name": collectionNameValues.reverse[collectionName],
//         "name": name,
//         "file_name": fileName,
//         "mime_type": mimeTypeValues.reverse[mimeType],
//         "disk": diskValues.reverse[disk],
//         "size": size,
//         "manipulations": manipulations == null
//             ? []
//             : List<dynamic>.from(manipulations!.map((x) => x)),
//         "custom_properties": customProperties == null
//             ? []
//             : List<dynamic>.from(customProperties!.map((x) => x)),
//         "responsive_images": responsiveImages == null
//             ? []
//             : List<dynamic>.from(responsiveImages!.map((x) => x)),
//         "order_column": orderColumn,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// enum CollectionName { ICON, IMAGE }
//
// final collectionNameValues =
//     EnumValues({"icon": CollectionName.ICON, "image": CollectionName.IMAGE});
//
// enum Disk { PUBLIC }
//
// final diskValues = EnumValues({"public": Disk.PUBLIC});
//
// enum MimeType { IMAGE_PNG }
//
// final mimeTypeValues = EnumValues({"image/png": MimeType.IMAGE_PNG});
//
// enum ModelType { APP_MODELS_MASTER_SERVICE_TYPE }
//
// final modelTypeValues = EnumValues({
//   "App\\Models\\Master\\ServiceType": ModelType.APP_MODELS_MASTER_SERVICE_TYPE
// });
//
// enum Status { ACTIVE }
//
// final statusValues = EnumValues({"active": Status.ACTIVE});
//
// enum Type { SERVICE }
//
// final typeValues = EnumValues({"service": Type.SERVICE});
//
// class Link {
//   String? url;
//   String? label;
//   bool? active;
//
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//       };
// }
//
// class Rating {
//   int? currentPage;
//   List<RatingData> data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;
//
//   Rating({
//     this.currentPage,
//     required this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<RatingData>.from(
//                 json["data"]!.map((x) => RatingData.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: json["links"] == null
//             ? []
//             : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": links == null
//             ? []
//             : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }
//
// class RatingData {
//   int? id;
//   int? userId;
//   int? bookingId;
//   String? icon;
//   int? rating;
//   String? feedback;
//   String? actionBy;
//   String? actionAt;
//   String? actionReason;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? document;
//   User user;
//   List<String?>? media;
//
//   RatingData({
//     this.id,
//     this.userId,
//     this.bookingId,
//     this.icon,
//     this.rating,
//     this.feedback,
//     this.actionBy,
//     this.actionAt,
//     this.actionReason,
//     this.createdAt,
//     this.updatedAt,
//     this.document,
//     required this.user,
//     this.media,
//   });
//
//   factory RatingData.fromJson(Map<String, dynamic> json) => RatingData(
//         id: json["id"],
//         userId: json["user_id"],
//         bookingId: json["booking_id"],
//         icon: json["icon"],
//         rating: json["rating"] ?? 0,
//         feedback: json["feedback"],
//         actionBy: json["action_by"],
//         actionAt: json["action_at"],
//         actionReason: json["action_reason"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         document: json["document"],
//         user: User.fromJson(json["user"]),
//         media: json["media"] == null
//             ? []
//             : List<String?>.from(json["media"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "booking_id": bookingId,
//         "icon": icon,
//         "rating": rating,
//         "feedback": feedback,
//         "action_by": actionBy,
//         "action_at": actionAt,
//         "action_reason": actionReason,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "document": document,
//         "user": user?.toJson(),
//         "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
//       };
// }
//
// class User {
//   int? id;
//   String? userType;
//   Status? status;
//   String? email;
//   String? countryCode;
//   int? mobile;
//   String? latitude;
//   String? longitude;
//   String? address;
//   String? accessToken;
//   int? pushNotification;
//   int? notifyMonthlyPayment;
//   String? profileImageUrl;
//   String? documentImageUrl;
//   String? name;
//
//   User({
//     this.id,
//     this.userType,
//     this.status,
//     this.email,
//     this.countryCode,
//     this.mobile,
//     this.latitude,
//     this.longitude,
//     this.address,
//     this.accessToken,
//     this.pushNotification,
//     this.notifyMonthlyPayment,
//     this.profileImageUrl,
//     this.documentImageUrl,
//     this.name,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         userType: json["user_type"],
//         status: statusValues.map[json["status"]]!,
//         email: json["email"],
//         countryCode: json["country_code"],
//         mobile: json["mobile"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         address: json["address"],
//         accessToken: json["access_token"],
//         pushNotification: json["push_notification"],
//         notifyMonthlyPayment: json["notify_monthly_payment"],
//         profileImageUrl: json["profile_image_url"],
//         documentImageUrl: json["document_image_url"],
//         name: json["name"] ?? "",
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_type": userType,
//         "status": statusValues.reverse[status],
//         "email": email,
//         "country_code": countryCode,
//         "mobile": mobile,
//         "latitude": latitude,
//         "longitude": longitude,
//         "address": address,
//         "access_token": accessToken,
//         "push_notification": pushNotification,
//         "notify_monthly_payment": notifyMonthlyPayment,
//         "profile_image_url": profileImageUrl,
//         "document_image_url": documentImageUrl,
//         "name": name,
//       };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
// To parse this JSON data, do
//
//     final dashboardResponse = dashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

class DashboardResponse {
  DashboardResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final int? status;
  final DashboardData data;

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      message: json["message"] ?? "",
      status: json["status"] ?? "",
      data: DashboardData.fromJson(json["data"] ?? {}),
    );
  }
}

class DashboardData {
  DashboardData({
    required this.banners,
    required this.services,
    required this.rating,
    required this.userProfile,
  });

  final Banners banners;
  final Banners services;
  final Rating rating;
  final DashboardUser userProfile;

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      banners: Banners.fromJson(json["banners"] ?? {}),
      services: Banners.fromJson(json["services"] ?? {}),
      rating: Rating.fromJson(json["rating"] ?? {}),
      userProfile: DashboardUser.fromJson(json["user_profile"] ?? {}),
    );
  }
}

class Banners {
  Banners({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<BannersDatum> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String prevPageUrl;
  final int? to;
  final int? total;

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      currentPage: json["current_page"] ?? 0,
      data: json["data"] == null
          ? []
          : List<BannersDatum>.from(
              json["data"]!.map((x) => BannersDatum.fromJson(x))),
      firstPageUrl: json["first_page_url"] ?? "",
      from: json["from"] ?? "",
      lastPage: json["last_page"] ?? 0,
      lastPageUrl: json["last_page_url"] ?? 0,
      links: json["links"] == null
          ? []
          : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"] ?? "",
      path: json["path"] ?? "",
      perPage: json["per_page"] ?? 0,
      prevPageUrl: json["prev_page_url"] ?? "",
      to: json["to"] ?? 0,
      total: json["total"] ?? 0,
    );
  }
}

class BannersDatum {
  BannersDatum({
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
  final int price;
  final String timeDuration;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  final String? icon;
  final List<Media> media;

  factory BannersDatum.fromJson(Map<String, dynamic> json) {
    return BannersDatum(
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
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );
  }
}

class Media {
  final int id;
  final String modelType;
  final int modelId;
  final String collectionName;
  final String name;
  final String fileName;
  final String mimeType;
  final String disk;
  final int size;
  final List<dynamic>? manipulations;
  final List<dynamic>? customProperties;
  final List<dynamic>? responsiveImages;
  final int orderColumn;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  });

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
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }
}

class Rating {
  Rating({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<RatingDatum> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final String nextPageUrl;
  final String? path;
  final int? perPage;
  final String prevPageUrl;
  final int? to;
  final int? total;

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      currentPage: json["current_page"] ?? 0,
      data: json["data"] == null
          ? []
          : List<RatingDatum>.from(
              json["data"]!.map((x) => RatingDatum.fromJson(x))),
      firstPageUrl: json["first_page_url"] ?? "",
      from: json["from"] ?? "",
      lastPage: json["last_page"] ?? 0,
      lastPageUrl: json["last_page_url"] ?? "",
      links: json["links"] == null
          ? []
          : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"] ?? "",
      path: json["path"] ?? "",
      perPage: json["per_page"] ?? 0,
      prevPageUrl: json["prev_page_url"] ?? "",
      to: json["to"] ?? 0,
      total: json["total"] ?? 0,
    );
  }
}

class RatingDatum {
  RatingDatum({
    required this.id,
    required this.userId,
    required this.userType,
    required this.bookingId,
    required this.icon,
    required this.rating,
    required this.feedback,
    required this.actionBy,
    required this.actionAt,
    required this.actionReason,
    required this.createdAt,
    required this.updatedAt,
    required this.documentImage,
    required this.user,
    required this.media,
  });

  final int? id;
  final int? userId;
  final String? userType;
  final int? bookingId;
  final String? icon;
  final int? rating;
  final String? feedback;
  final String actionBy;
  final String actionAt;
  final String actionReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? documentImage;
  final DashboardUser user;
  final List<Media> media;

  factory RatingDatum.fromJson(Map<String, dynamic> json) {
    return RatingDatum(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      userType: json["user_type"] ?? "",
      bookingId: json["booking_id"] ?? 0,
      icon: json["icon"] ?? "",
      rating: json["rating"] ?? 0,
      feedback: json["feedback"] ?? "",
      actionBy: json["action_by"] ?? "",
      actionAt: json["action_at"] ?? "",
      actionReason: json["action_reason"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      documentImage: json["document_image"] ?? "",
      user: DashboardUser.fromJson(json["user"] ?? {}),
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );
  }
}

class DashboardUser {
  DashboardUser({
    required this.id,
    required this.userType,
    required this.status,
    required this.email,
    required this.countryCode,
    required this.mobile,
    required this.userCategoryType,
    required this.userDocVerification,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.accessToken,
    required this.pushNotification,
    required this.notifyMonthlyPayment,
    required this.accountDetails,
    required this.name,
    required this.profileImageUrl,
    required this.documentImageUrl,
  });

  final int? id;
  final String? userType;
  final String? status;
  final String? email;
  final String? countryCode;
  final int? mobile;
  final String? userCategoryType;
  final String? userDocVerification;
  final String latitude;
  final String longitude;
  final String address;
  final String? accessToken;
  final int? pushNotification;
  final int? notifyMonthlyPayment;
  final int? accountDetails;
  final String? name;
  final String? profileImageUrl;
  final String? documentImageUrl;

  factory DashboardUser.fromJson(Map<String, dynamic> json) {
    return DashboardUser(
      id: json["id"],
      userType: json["user_type"],
      status: json["status"],
      email: json["email"],
      countryCode: json["country_code"],
      mobile: json["mobile"],
      userCategoryType: json["user_category_type"],
      userDocVerification: json["user_doc_verification"],
      latitude: json["latitude"] ?? "",
      longitude: json["longitude"] ?? "",
      address: json["address"] ?? "",
      accessToken: json["access_token"],
      pushNotification: json["push_notification"],
      notifyMonthlyPayment: json["notify_monthly_payment"],
      accountDetails: json["account_details"],
      name: json["name"],
      profileImageUrl: json["profile_image_url"],
      documentImageUrl: json["document_image_url"],
    );
  }
}
