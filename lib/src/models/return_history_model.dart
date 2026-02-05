class ReturnHistory {
  ReturnHistory({
    this.status,
    this.data,
  });

  final String? status;
  final List<ReturnData>? data;

  factory ReturnHistory.fromJson(Map<String, dynamic> json) {
    return ReturnHistory(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<ReturnData>.from(
              json["data"]!.map((x) => ReturnData.fromJson(x))),
    );
  }
}

class ReturnData {
  ReturnData({
    this.id,
    this.tripId,
    this.bidId,
    this.vehicleId,
    this.pickupLocation,
    this.dropoffLocation,
    this.partnerId,
    this.customerId,
    this.timedate,
    this.amount,
    this.otp,
    this.trackingId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isBiding,
    this.isConfirm,
    this.getpartner,
    this.getvehicle,
  });

  final int? id;
  final int? tripId;
  final int? bidId;
  final int? vehicleId;
  final String? pickupLocation;
  final String? dropoffLocation;
  final int? partnerId;
  final int? customerId;
  final String? timedate;
  final String? amount;
  final int? otp;
  final String? trackingId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? isBiding;
  final int? isConfirm;
  final Getpartner? getpartner;
  final Getvehicle? getvehicle;

  factory ReturnData.fromJson(Map<String, dynamic> json) {
    return ReturnData(
      id: json["id"],
      tripId: json["trip_id"],
      bidId: json["bid_id"],
      vehicleId: json["vehicle_id"],
      pickupLocation: json["pickup_location"],
      dropoffLocation: json["dropoff_location"],
      partnerId: json["partner_id"],
      customerId: json["customer_id"],
      timedate: json["timedate"],
      amount: json["amount"],
      otp: json["otp"],
      trackingId: json["tracking_id"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      isBiding: json["is_biding"],
      isConfirm: json["is_confirm"],
      getpartner: json["getpartner"] == null
          ? null
          : Getpartner.fromJson(json["getpartner"]),
      getvehicle: json["getvehicle"] == null
          ? null
          : Getvehicle.fromJson(json["getvehicle"]),
    );
  }
}

class Getpartner {
  Getpartner({
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
    this.deviceToken,
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
  final dynamic deviceToken;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Getpartner.fromJson(Map<String, dynamic> json) {
    return Getpartner(
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
      deviceToken: json["device_token"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
