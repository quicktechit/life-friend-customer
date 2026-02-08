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

  final String? distance;
  final String? fixedPrice;
  final String? createdAt;
  final String? updatedAt;

  const Data({
    this.id,
    this.distance,
    this.fixedPrice,
    this.createdAt,
    this.updatedAt,
  });

  static String? _toStr(dynamic v) => v?.toString();

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        distance = _toStr(json['distance']),
        fixedPrice = _toStr(json['fixed_price']),
        createdAt = _toStr(json['created_at']),
        updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'distance': distance,
    'fixed_price': fixedPrice,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
