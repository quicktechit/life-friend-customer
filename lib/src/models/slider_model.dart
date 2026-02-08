class SliderModel {
  SliderModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final List<SliderData> data;

  factory SliderModel.fromJson(Map<String, dynamic> json){
    return SliderModel(
      status: json["status"],
      data: json["data"] == null ? [] : List<SliderData>.from(json["data"]!.map((x) => SliderData.fromJson(x))),
    );
  }

}

class SliderData {
  SliderData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SliderData.fromJson(Map<String, dynamic> json){
    return SliderData(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
