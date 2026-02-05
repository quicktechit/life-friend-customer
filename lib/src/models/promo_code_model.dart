class PromoCodeModel {
  PromoCodeModel({
    this.status,
    this.data,
  });

  final String? status;
  final List<PromoCodeData>? data;

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<PromoCodeData>.from(
              json["data"]!.map((x) => PromoCodeData.fromJson(x))),
    );
  }
}

class PromoCodeData {
  PromoCodeData({
    this.id,
    this.name,
    this.customerId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? customerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PromoCodeData.fromJson(Map<String, dynamic> json) {
    return PromoCodeData(
      id: json["id"],
      name: json["name"],
      customerId: json["customer_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
