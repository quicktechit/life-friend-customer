class CategoryModel {
  final String? status;
  final Data? data;

  const CategoryModel({
    this.status,
    this.data,
  });

  static String? _toStr(dynamic v) => v?.toString();

  CategoryModel.fromJson(Map<String, dynamic> json)
      : status = _toStr(json['status']),
        data = json['data'] != null
            ? Data.fromJson(json['data'])
            : null;

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.toJson(),
  };
}

class Data {
  final int? id;

  final String? name;
  final String? nameBn;
  final String? slug;
  final String? image;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  final List<Sizecategories>? sizecategories;

  const Data({
    this.id,
    this.name,
    this.nameBn,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.sizecategories,
  });

  static String? _toStr(dynamic v) => v?.toString();

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = _toStr(json['name']),
        nameBn = _toStr(json['name_bn']),
        slug = _toStr(json['slug']),
        image = _toStr(json['image']),
        status = _toStr(json['status']),
        createdAt = _toStr(json['created_at']),
        updatedAt = _toStr(json['updated_at']),
        sizecategories = (json['sizecategories'] as List?)
            ?.map((e) => Sizecategories.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_bn': nameBn,
    'slug': slug,
    'image': image,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'sizecategories':
    sizecategories?.map((e) => e.toJson()).toList(),
  };
}

class Sizecategories {
  final int? id;

  final String? categoryId;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  final List<Vehicles>? vehicles;

  const Sizecategories({
    this.id,
    this.categoryId,
    this.name,
    this.nameBn,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vehicles,
  });

  static String? _toStr(dynamic v) => v?.toString();

  Sizecategories.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        categoryId = _toStr(json['category_id']),
        name = _toStr(json['name']),
        nameBn = _toStr(json['name_bn']),
        slug = _toStr(json['slug']),
        status = _toStr(json['status']),
        createdAt = _toStr(json['created_at']),
        updatedAt = _toStr(json['updated_at']),
        vehicles = (json['vehicles'] as List?)
            ?.map((e) => Vehicles.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'name': name,
    'name_bn': nameBn,
    'slug': slug,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'vehicles': vehicles?.map((e) => e.toJson()).toList(),
  };
}

class Vehicles {
  final int? id;

  final String? vehicleCategory;
  final String? sizecategoryId;
  final String? truckType;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? image;
  final String? description;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const Vehicles({
    this.id,
    this.vehicleCategory,
    this.sizecategoryId,
    this.truckType,
    this.name,
    this.nameBn,
    this.slug,
    this.capacity,
    this.image,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  static String? _toStr(dynamic v) => v?.toString();

  Vehicles.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        vehicleCategory = _toStr(json['vehicle_category']),
        sizecategoryId = _toStr(json['sizecategory_id']),
        truckType = _toStr(json['truck_type']),
        name = _toStr(json['name']),
        nameBn = _toStr(json['name_bn']),
        slug = _toStr(json['slug']),
        capacity = _toStr(json['capacity']),
        image = _toStr(json['image']),
        description = _toStr(json['description']),
        status = _toStr(json['status']),
        createdAt = _toStr(json['created_at']),
        updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'vehicle_category': vehicleCategory,
    'sizecategory_id': sizecategoryId,
    'truck_type': truckType,
    'name': name,
    'name_bn': nameBn,
    'slug': slug,
    'capacity': capacity,
    'image': image,
    'description': description,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
