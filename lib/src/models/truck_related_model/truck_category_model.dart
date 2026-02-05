class CategoryModel {
  final String? status;
  final Data? data;

  CategoryModel({
    this.status,
    this.data,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'data' : data?.toJson()
  };
}

class Data {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? image;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final List<Sizecategories>? sizecategories;

  Data({
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

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        slug = json['slug'] as String?,
        image = json['image'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        sizecategories = (json['sizecategories'] as List?)?.map((dynamic e) => Sizecategories.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_bn' : nameBn,
    'slug' : slug,
    'image' : image,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'sizecategories' : sizecategories?.map((e) => e.toJson()).toList()
  };
}

class Sizecategories {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? nameBn;
  final String? slug;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final List<Vehicles>? vehicles;

  Sizecategories({
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

  Sizecategories.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        categoryId = json['category_id'] as int?,
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        slug = json['slug'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        vehicles = (json['vehicles'] as List?)?.map((dynamic e) => Vehicles.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'category_id' : categoryId,
    'name' : name,
    'name_bn' : nameBn,
    'slug' : slug,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'vehicles' : vehicles?.map((e) => e.toJson()).toList()
  };
}

class Vehicles {
  final int? id;
  final int? vehicleCategory;
  final int? sizecategoryId;
  final String? truckType;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? image;
  final String? description;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Vehicles({
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

  Vehicles.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        vehicleCategory = json['vehicle_category'] as int?,
        sizecategoryId = json['sizecategory_id'] as int?,
        truckType = json['truck_type'] as String?,
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        slug = json['slug'] as String?,
        capacity = json['capacity'] as String?,
        image = json['image'] as String?,
        description = json['description'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'vehicle_category' : vehicleCategory,
    'sizecategory_id' : sizecategoryId,
    'truck_type' : truckType,
    'name' : name,
    'name_bn' : nameBn,
    'slug' : slug,
    'capacity' : capacity,
    'image' : image,
    'description' : description,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}