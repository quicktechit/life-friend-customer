class RangeModel {
  final String? status;
  final String? message;
  final Data? data;

  RangeModel({
    this.status,
    this.message,
    this.data,
  });

  RangeModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final int? id;
  final int? distance;
  final int? fixedPrice;
  final dynamic createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.distance,
    this.fixedPrice,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        distance = json['distance'] as int?,
        fixedPrice = json['fixed_price'] as int?,
        createdAt = json['created_at'],
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'distance' : distance,
    'fixed_price' : fixedPrice,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}