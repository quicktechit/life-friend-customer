class CustomerReturnBidModel {
  CustomerReturnBidModel({
      this.status,
      this.data,
  });

  final String? status;
  final CustomerReturnBid? data;

  factory CustomerReturnBidModel.fromJson(Map<String, dynamic> json){
    return CustomerReturnBidModel(
      status: json["status"],
      data: json["data"] == null ? null : CustomerReturnBid.fromJson(json["data"]),
    );
  }

}

class CustomerReturnBid {
  CustomerReturnBid({
      this.partnerTripId,
      this.pickupLocation,
      this.dropoffLocation,
      this.returnTripId,
      this.map,
      this.dropoffMap,
      this.price,
      this.customerId,
      this.partnerId,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id,
  });

  final String? partnerTripId;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String? returnTripId;
  final String? map;
  final String? dropoffMap;
  final String? price;
  final int? customerId;
  final int? partnerId;
  final int? status;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory CustomerReturnBid.fromJson(Map<String, dynamic> json){
    return CustomerReturnBid(
      partnerTripId: json["partner_trip_id"],
      pickupLocation: json["pickup_location"],
      dropoffLocation: json["dropoff_location"],
      returnTripId: json["return_trip_id"],
      map: json["map"],
      dropoffMap: json["dropoff_map"],
      price: json["price"],
      customerId: json["customer_id"],
      partnerId: json["partner_id"],
      status: json["status"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

}
