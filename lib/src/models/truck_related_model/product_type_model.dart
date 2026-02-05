class ProductCategory {
  final String? status;
  final String? message;
  final List<Datas>? data;

  ProductCategory({
    this.status,
    this.message,
    this.data,
  });

  ProductCategory.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Datas.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Datas {
  final int? id;
  final String? name;
  final String? nameBn;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Datas({
    this.id,
    this.name,
    this.nameBn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Datas.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_bn' : nameBn,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}