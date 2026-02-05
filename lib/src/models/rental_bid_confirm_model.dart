class RentalBidConfirmModel {
  RentalBidConfirmModel({
    this.status,
    this.data,
  });

  final String? status;
  final RentalBidConfirm? data;

  factory RentalBidConfirmModel.fromJson(Map<String, dynamic> json) {
    return RentalBidConfirmModel(
      status: json["status"],
      data:
          json["data"] == null ? null : RentalBidConfirm.fromJson(json["data"]),
    );
  }
}

class RentalBidConfirm {
  RentalBidConfirm({
    this.tripConfirm,
    this.vehicle,
    this.partner,
    this.tripRequest,
  });

  final TripConfirm? tripConfirm;
  final Vehicle? vehicle;
  final Partner? partner;
  final TripRequest? tripRequest;

  factory RentalBidConfirm.fromJson(Map<String, dynamic> json) {
    return RentalBidConfirm(
      tripConfirm: json["trip_confirm"] == null
          ? null
          : TripConfirm.fromJson(json["trip_confirm"]),
      vehicle:
          json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
      partner:
          json["partner"] == null ? null : Partner.fromJson(json["partner"]),
      tripRequest: json["trip_request"] == null
          ? null
          : TripRequest.fromJson(json["trip_request"]),
    );
  }
}

class Partner {
  Partner({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.docType,
    this.docNumber,
    this.docFront,
    this.docBack,
    this.division,
    this.address,
    this.gender,
    this.referCode,
    this.myreferKey,
    this.verify,
    this.forgotCode,
    this.credit,
    this.debit,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? image;
  final String? docType;
  final String? docNumber;
  final String? docFront;
  final String? docBack;
  final String? division;
  final String? address;
  final String? gender;
  final dynamic referCode;
  final String? myreferKey;
  final String? verify;
  final String? forgotCode;
  final int? credit;
  final int? debit;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      image: json["image"],
      docType: json["doc_type"],
      docNumber: json["doc_number"],
      docFront: json["doc_front"],
      docBack: json["doc_back"],
      division: json["division"],
      address: json["address"],
      gender: json["gender"],
      referCode: json["refer_code"],
      myreferKey: json["myrefer_key"],
      verify: json["verify"],
      forgotCode: json["forgot_code"],
      credit: json["credit"],
      debit: json["debit"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class TripConfirm {
  TripConfirm({
    this.bidId,
    this.tripId,
    this.vehicleId,
    this.assignedVehicleId,
    this.customerId,
    this.partnerId,
    this.amount,
    this.otp,
    this.trackingId,
    this.status,
    this.tripStarted,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  final String? bidId;
  final int? tripId;
  final int? vehicleId;
  final int? assignedVehicleId;
  final int? customerId;
  final int? partnerId;
  final String? amount;
  final int? otp;
  final String? trackingId;
  final int? status;
  final int? tripStarted;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory TripConfirm.fromJson(Map<String, dynamic> json) {
    return TripConfirm(
      bidId: json["bid_id"],
      tripId: json["trip_id"],
      vehicleId: json["vehicle_id"],
      assignedVehicleId: json["assigned_vehicle_id"],
      customerId: json["customer_id"],
      partnerId: json["partner_id"],
      amount: json["amount"],
      otp: json["otp"],
      trackingId: json["tracking_id"],
      status: json["status"],
      tripStarted: json["trip_started"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }
}

class TripRequest {
  TripRequest({
    this.id,
    this.customerId,
    this.vehicleId,
    this.pickupLocation,
    this.viaLocation,
    this.dropoffLocation,
    this.addressId,
    this.map,
    this.dropoffMap,
    this.districtId,
    this.portId,
    this.datetime,
    this.roundTrip,
    this.promoKey,
    this.roundDatetime,
    this.note,
    this.trackingId,
    this.status,
    this.biding,
    this.bidingExpiredAt,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? customerId;
  final int? vehicleId;
  final String? pickupLocation;
  final dynamic viaLocation;
  final String? dropoffLocation;
  final dynamic addressId;
  final String? map;
  final String? dropoffMap;
  final dynamic districtId;
  final dynamic portId;
  final String? datetime;
  final int? roundTrip;
  final dynamic promoKey;
  final String? roundDatetime;
  final dynamic note;
  final String? trackingId;
  final int? status;
  final int? biding;
  final DateTime? bidingExpiredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TripRequest.fromJson(Map<String, dynamic> json) {
    return TripRequest(
      id: json["id"],
      customerId: json["customer_id"],
      vehicleId: json["vehicle_id"],
      pickupLocation: json["pickup_location"],
      viaLocation: json["via_location"],
      dropoffLocation: json["dropoff_location"],
      addressId: json["address_id"],
      map: json["map"],
      dropoffMap: json["dropoff_map"],
      districtId: json["district_id"],
      portId: json["port_id"],
      datetime: json["datetime"],
      roundTrip: json["round_trip"],
      promoKey: json["promo_key"],
      roundDatetime: json["round_datetime"],
      note: json["note"],
      trackingId: json["tracking_id"],
      status: json["status"],
      biding: json["biding"],
      bidingExpiredAt: DateTime.tryParse(json["biding_expired_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class Vehicle {
  Vehicle({
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

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
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
