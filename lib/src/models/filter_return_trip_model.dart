class FilterReturnTripModel {
  FilterReturnTripModel({
    this.status,
    this.data,
  });

  final String? status;
  final List<FilterReturnTrip>? data;

  factory FilterReturnTripModel.fromJson(Map<String, dynamic> json) {
    return FilterReturnTripModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<FilterReturnTrip>.from(
              json["data"]!.map((x) => FilterReturnTrip.fromJson(x))),
    );
  }
}

class FilterReturnTrip {
  FilterReturnTrip({
    this.id,
    this.pickupDivision,
    this.dropoffDivision,
    this.location,
    this.destination,
    this.amount,
    this.timedate,
    this.partnerId,
    this.vehicleId,
    this.biding,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.getvehicle,
  });

  final int? id;
  final int? pickupDivision;
  final int? dropoffDivision;
  final String? location;
  final String? destination;
  final String? amount;
  final String? timedate;
  final int? partnerId;
  final int? vehicleId;
  final dynamic biding;
  final dynamic status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Getvehicle? getvehicle;

  factory FilterReturnTrip.fromJson(Map<String, dynamic> json) {
    return FilterReturnTrip(
      id: json["id"],
      pickupDivision: json["pickup_division"],
      dropoffDivision: json["dropoff_division"],
      location: json["location"],
      destination: json["destination"],
      amount: json["amount"],
      timedate: json["timedate"],
      partnerId: json["partner_id"],
      vehicleId: json["vehicle_id"],
      biding: json["biding"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      getvehicle: json["getvehicle"] == null
          ? null
          : Getvehicle.fromJson(json["getvehicle"]),
    );
  }
}

class Getvehicle {
  Getvehicle({
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
  final int? vehicleCategory;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? image;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Getvehicle.fromJson(Map<String, dynamic> json) {
    return Getvehicle(
      id: json["id"],
      vehicleCategory: json["vehicle_category"],
      name: json["name"],
      nameBn: json["name_bn"],
      slug: json["slug"],
      capacity: json["capacity"],
      image: json["image"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
