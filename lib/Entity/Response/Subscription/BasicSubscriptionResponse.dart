import 'dart:convert';

BasicSubscriptionResponse basicSubscriptionResponseFromJson(String str) =>
    BasicSubscriptionResponse.fromJson(json.decode(str));

String basicSubscriptionResponseToJson(BasicSubscriptionResponse data) =>
    json.encode(data.toJson());

class BasicSubscriptionResponse {
  BasicSubscriptionResponse({
    required this.message,
    required this.status,
    required this.data,
  });
  late final String message;
  late final int status;
  late final List<Data> data;

  BasicSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    status = json['status'] ?? "";
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.price,
    required this.timeDuration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.subscriptionDetails,
    required this.media,
  });
  late final int id;

  late final String name;
  late final int price;
  late final String timeDuration;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String image;

  late final List<SubscriptionDetails> subscriptionDetails;
  late final List<Media> media;
  bool isPackageSelected = false;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;

    name = json['name'] ?? "";
    price = json['price'] ?? 0;
    timeDuration = json['time_duration'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    image = json['image'] ?? "";

    subscriptionDetails = List.from(json['subscription_details'])
        .map((e) => SubscriptionDetails.fromJson(e))
        .toList();
    media = List.from(json['media']).map((e) => Media.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;

    _data['name'] = name;
    _data['price'] = price;
    _data['time_duration'] = timeDuration;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;

    _data['subscription_details'] =
        subscriptionDetails.map((e) => e.toJson()).toList();
    _data['media'] = media.map((e) => e.toJson()).toList();
    return _data;
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
  late final int id;
  late final String modelType;
  late final int modelId;
  late final String collectionName;
  late final String name;
  late final String fileName;
  late final String mimeType;
  late final String disk;
  late final int size;
  late final List<dynamic> manipulations;
  late final List<dynamic> customProperties;
  late final List<dynamic> responsiveImages;
  late final int orderColumn;
  late final String createdAt;
  late final String updatedAt;
  late final dynamic deletedAt;

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    modelType = json['model_type'] ?? "";
    modelId = json['model_id'] ?? 0;
    collectionName = json['collection_name'] ?? "";
    name = json['name'] ?? "";
    fileName = json['file_name'] ?? "";
    mimeType = json['mime_type'] ?? "";
    disk = json['disk'] ?? "";
    size = json['size'] ?? "";
    manipulations =
        List.castFrom<dynamic, dynamic>(json['manipulations'] ?? {});
    customProperties =
        List.castFrom<dynamic, dynamic>(json['custom_properties'] ?? {});
    responsiveImages =
        List.castFrom<dynamic, dynamic>(json['responsive_images'] ?? {});
    orderColumn = json['order_column'] ?? 0;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    deletedAt = json['deleted_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['model_type'] = modelType;
    _data['model_id'] = modelId;
    _data['collection_name'] = collectionName;
    _data['name'] = name;
    _data['file_name'] = fileName;
    _data['mime_type'] = mimeType;
    _data['disk'] = disk;
    _data['size'] = size;
    _data['manipulations'] = manipulations;
    _data['custom_properties'] = customProperties;
    _data['responsive_images'] = responsiveImages;
    _data['order_column'] = orderColumn;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }
}

class SubscriptionDetails {
  SubscriptionDetails({
    required this.id,
    required this.subscriptionId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int subscriptionId;
  late final String name;
  late final String status;
  late final String createdAt;
  late final String updatedAt;

  SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    subscriptionId = json['subscription_id'] ?? 0;
    name = json['name'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['subscription_id'] = subscriptionId;
    _data['name'] = name;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
