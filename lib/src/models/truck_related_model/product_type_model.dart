class ProductCategory {
  final String? status;
  final String? message;
  final List<Datas>? data;

  const ProductCategory({this.status, this.message, this.data});

  static String? _toStr(dynamic v) => v?.toString();

  ProductCategory.fromJson(Map<String, dynamic> json)
    : status = _toStr(json['status']),
      message = _toStr(json['message']),
      data = (json['data'] as List?)?.map((e) => Datas.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class Datas {
  final int? id;

  final String? name;
  final String? nameBn;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const Datas({
    this.id,
    this.name,
    this.nameBn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  static String? _toStr(dynamic v) => v?.toString();

  Datas.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = _toStr(json['name']),
      nameBn = _toStr(json['name_bn']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_bn': nameBn,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
