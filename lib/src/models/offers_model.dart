class OfferModel {
  OfferModel({
        this.status,
        this.data,
  });

  final String? status;
  final List<OfferData>? data;

  factory OfferModel.fromJson(Map<String, dynamic> json){
    return OfferModel(
      status: json["status"],
      data: json["data"] == null ? [] : List<OfferData>.from(json["data"]!.map((x) => OfferData.fromJson(x))),
    );
  }

}

class OfferData {
  OfferData({
        this.id,
        this.name,
        this.description,
        this.price,
        this.vehicleId,
        this.image,
        this.status,
        this.createdAt,
        this.updateAt,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final int? vehicleId;
  final String? image;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updateAt;

  factory OfferData.fromJson(Map<String, dynamic> json){
    return OfferData(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      vehicleId: json["vehicle_id"],
      image: json["image"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updateAt: DateTime.tryParse(json["update_at"] ?? ""),
    );
  }

}
