class CarCategoryListModel {
  CarCategoryListModel({
      this.status,
      this.data,
  });

  final String? status;
  final List<CarData>? data;

  factory CarCategoryListModel.fromJson(Map<String, dynamic> json){
    return CarCategoryListModel(
      status: json["status"],
      data: json["data"] == null ? [] : List< CarData>.from(json["data"]!.map((x) =>  CarData.fromJson(x))),
    );
  }

}

class  CarData {
   CarData({
      this.id,
      this.vehicleCategory,
      this.name,
      this.nameBn,
      this.slug,
      this.capacity,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
  });

  final int? id;
  final String? vehicleCategory;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? image;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory  CarData.fromJson(Map<String, dynamic> json){
    return  CarData(
      id: json["id"],
      vehicleCategory: json["vehicle_category"].toString(),
      name: json["name"],
      nameBn: json["name_bn"],
      slug: json["slug"],
      capacity: json["capacity"],
      image: json["image"],
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
