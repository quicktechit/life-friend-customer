class SingleReturnTripDetailsModel {
  SingleReturnTripDetailsModel({
    this.status,
    this.data,
  });

  final String? status;
  final SingleReturnTrip? data;

  factory SingleReturnTripDetailsModel.fromJson(Map<String, dynamic> json) {
    return SingleReturnTripDetailsModel(
      status: json["status"],
      data:
          json["data"] == null ? null : SingleReturnTrip.fromJson(json["data"]),
    );
  }
}

class SingleReturnTrip {
  SingleReturnTrip({
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
    this.cancelledStatus,
    this.cancelledBy,
    this.createdAt,
    this.updatedAt,
    this.assignedVehicleId,
    this.assignedDriverId,
    this.isConfirmed,
    this.assignedCar,
    this.assignedDriver,
    this.getvehicle,
    this.getpartner,
    this.bidDetails,
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
  final dynamic cancelledStatus;
  final dynamic cancelledBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? assignedVehicleId;
  final int? assignedDriverId;
  final int? isConfirmed;
  final AssignedCar? assignedCar;
  final AssignedDriver? assignedDriver;
  final Getvehicle? getvehicle;
  final Getpartner? getpartner;
  final BidDetails? bidDetails;

  factory SingleReturnTrip.fromJson(Map<String, dynamic> json) {
    return SingleReturnTrip(
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
      cancelledStatus: json["cancelled_status"],
      cancelledBy: json["cancelled_by"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      assignedVehicleId: json["assigned_vehicle_id"],
      assignedDriverId: json["assigned_driver_id"],
      isConfirmed: json["is_confirmed"],
      assignedCar: json["assignedCar"] == null
          ? null
          : AssignedCar.fromJson(json["assignedCar"]),
      assignedDriver: json["assignedDriver"] == null
          ? null
          : AssignedDriver.fromJson(json["assignedDriver"]),
      getvehicle: json["getvehicle"] == null
          ? null
          : Getvehicle.fromJson(json["getvehicle"]),
      getpartner: json["getpartner"] == null
          ? null
          : Getpartner.fromJson(json["getpartner"]),
      bidDetails: json["bid_details"] == null
          ? null
          : BidDetails.fromJson(json["bid_details"]),
    );
  }
}

class AssignedCar {
  AssignedCar({
    this.id,
    this.partnerId,
    this.vehicleCategory,
    this.brand,
    this.metro,
    this.metroType,
    this.metroNo,
    this.model,
    this.modelYear,
    this.vehicleColor,
    this.aircondition,
    this.brandName,
    this.fuelType,
    this.vehicleFrontPic,
    this.vehicleBackPic,
    this.vehiclePlateNo,
    this.vehicleRegPic,
    this.vehicleRootPic,
    this.vehicleFitnessPic,
    this.vehicleTaxPic,
    this.vehicleInsurancePic,
    this.vehicleDrivingFront,
    this.vehicleDrivingBack,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.metroSubCategory,
  });

  final int? id;
  final int? partnerId;
  final int? vehicleCategory;
  final int? brand;
  final String? metro;
  final int? metroType;
  final String? metroNo;
  final String? model;
  final String? modelYear;
  final String? vehicleColor;
  final String? aircondition;
  final String? brandName;
  final String? fuelType;
  final String? vehicleFrontPic;
  final String? vehicleBackPic;
  final String? vehiclePlateNo;
  final String? vehicleRegPic;
  final String? vehicleRootPic;
  final String? vehicleFitnessPic;
  final String? vehicleTaxPic;
  final String? vehicleInsurancePic;
  final String? vehicleDrivingFront;
  final String? vehicleDrivingBack;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? metroSubCategory;

  factory AssignedCar.fromJson(Map<String, dynamic> json) {
    return AssignedCar(
      id: json["id"],
      partnerId: json["partner_id"],
      vehicleCategory: json["vehicle_category"],
      brand: json["brand"],
      metro: json["metro"],
      metroType: json["metro_type"],
      metroNo: json["metro_no"],
      model: json["model"],
      modelYear: json["model_year"],
      vehicleColor: json["vehicle_color"],
      aircondition: json["aircondition"],
      brandName: json["brand_name"],
      fuelType: json["fuel_type"],
      vehicleFrontPic: json["vehicle_front_pic"],
      vehicleBackPic: json["vehicle_back_pic"],
      vehiclePlateNo: json["vehicle_plate_no"],
      vehicleRegPic: json["vehicle_reg_pic"],
      vehicleRootPic: json["vehicle_root_pic"],
      vehicleFitnessPic: json["vehicle_fitness_pic"],
      vehicleTaxPic: json["vehicle_tax_pic"],
      vehicleInsurancePic: json["vehicle_insurance_pic"],
      vehicleDrivingFront: json["vehicle_driving_front"],
      vehicleDrivingBack: json["vehicle_driving_back"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      metroSubCategory: json["metro_sub_category"],
    );
  }
}

class AssignedDriver {
  AssignedDriver({
    this.id,
    this.partnerId,
    this.name,
    this.phone,
    this.contactNo,
    this.email,
    this.gender,
    this.address,
    this.drivingNo,
    this.drivingImage,
    this.nidFront,
    this.nidBack,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? partnerId;
  final String? name;
  final String? phone;
  final String? contactNo;
  final String? email;
  final String? gender;
  final String? address;
  final String? drivingNo;
  final String? drivingImage;
  final String? nidFront;
  final String? nidBack;
  final String? image;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AssignedDriver.fromJson(Map<String, dynamic> json) {
    return AssignedDriver(
      id: json["id"],
      partnerId: json["partner_id"],
      name: json["name"],
      phone: json["phone"],
      contactNo: json["contact_no"],
      email: json["email"],
      gender: json["gender"],
      address: json["address"],
      drivingNo: json["driving_no"],
      drivingImage: json["driving_image"],
      nidFront: json["nid_front"],
      nidBack: json["nid_back"],
      image: json["image"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class BidDetails {
  BidDetails({
    this.id,
    this.partnerTripId,
    this.pickupLocation,
    this.dropoffLocation,
    this.map,
    this.dropoffMap,
    this.price,
    this.customerId,
    this.returnTripId,
    this.partnerId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? partnerTripId;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String? map;
  final String? dropoffMap;
  final String? price;
  final int? customerId;
  final int? returnTripId;
  final int? partnerId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BidDetails.fromJson(Map<String, dynamic> json) {
    return BidDetails(
      id: json["id"],
      partnerTripId: json["partner_trip_id"],
      pickupLocation: json["pickup_location"],
      dropoffLocation: json["dropoff_location"],
      map: json["map"],
      dropoffMap: json["dropoff_map"],
      price: json["price"],
      customerId: json["customer_id"],
      returnTripId: json["return_trip_id"],
      partnerId: json["partner_id"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
