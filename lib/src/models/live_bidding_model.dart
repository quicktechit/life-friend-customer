class LiveBiddingModel {
  LiveBiddingModel({
     this.status,
     this.tripList,
  });

  final String? status;
  final List<TripList>? tripList;

  factory LiveBiddingModel.fromJson(Map<String, dynamic> json){
    return LiveBiddingModel(
      status: json["status"],
      tripList: json["trip_list"] == null ? [] : List<TripList>.from(json["trip_list"]!.map((x) => TripList.fromJson(x))),
    );
  }

}

class TripList {
  TripList({
    required this.id,
    required this.reviewStatus,
    required this.customerId,
    required this.categoryId,
    required this.sizecategoryId,
    required this.truckType,
    required this.vehicleId,
    required this.assignedDriverId,
    required this.pickupLocation,
    required this.viaLocation,
    required this.dropoffLocation,
    required this.pickupDivision,
    required this.dropoffDivision,
    required this.addressId,
    required this.isHourly,
    required this.hours,
    required this.map,
    required this.dropoffMap,
    required this.districtId,
    required this.portId,
    required this.datetime,
    required this.roundTrip,
    required this.promoKey,
    required this.roundDatetime,
    required this.note,
    required this.trackingId,
    required this.isAirport,
    required this.productType,
    required this.productDetails,
    required this.isLabour,
    required this.distance,
    required this.amount,
    required this.extendedAmount,
    required this.status,
    required this.biding,
    required this.bidingExpiredAt,
    required this.isCancel,
    required this.cancelreasonId,
    required this.createdAt,
    required this.updatedAt,
    required this.dropoffLocations,
    required this.tripBids,
  });

  final int? id;
  final dynamic reviewStatus;
  final String? customerId;
  final String? categoryId;
  final dynamic sizecategoryId;
  final dynamic truckType;
  final String? vehicleId;
  final String? assignedDriverId;
  final String? pickupLocation;
  final dynamic viaLocation;
  final String? dropoffLocation;
  final dynamic pickupDivision;
  final dynamic dropoffDivision;
  final dynamic addressId;
  final String? isHourly;
  final String? hours;
  final String? map;
  final String? dropoffMap;
  final dynamic districtId;
  final dynamic portId;
  final String? datetime;
  final String? roundTrip;
  final dynamic promoKey;
  final dynamic roundDatetime;
  final dynamic note;
  final String? trackingId;
  final String? isAirport;
  final dynamic productType;
  final dynamic productDetails;
  final dynamic isLabour;
  final dynamic distance;
  final dynamic amount;
  final String? extendedAmount;
  final String? status;
  final String? biding;
  final DateTime? bidingExpiredAt;
  final String? isCancel;
  final dynamic cancelreasonId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<DropoffLocations> dropoffLocations;
  final List<TripBid> tripBids;

  factory TripList.fromJson(Map<String, dynamic> json){
    return TripList(
      id: json["id"],
      reviewStatus: json["review_status"],
      customerId: json["customer_id"],
      categoryId: json["category_id"],
      sizecategoryId: json["sizecategory_id"],
      truckType: json["truck_type"],
      vehicleId: json["vehicle_id"],
      assignedDriverId: json["assigned_driver_id"],
      pickupLocation: json["pickup_location"],
      viaLocation: json["via_location"],
      dropoffLocation: json["dropoff_location"],
      pickupDivision: json["pickup_division"],
      dropoffDivision: json["dropoff_division"],
      addressId: json["address_id"],
      isHourly: json["is_hourly"],
      hours: json["hours"],
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
      isAirport: json["is_airport"],
      productType: json["product_type"],
      productDetails: json["product_details"],
      isLabour: json["is_labour"],
      distance: json["distance"],
      amount: json["amount"],
      extendedAmount: json["extended_amount"],
      status: json["status"],
      biding: json["biding"],
      bidingExpiredAt: DateTime.tryParse(json["biding_expired_at"] ?? ""),
      isCancel: json["is_cancel"],
      cancelreasonId: json["cancelreason_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      dropoffLocations: json["dropoff_locations"] == null ? [] : List<DropoffLocations>.from(json["dropoff_locations"]!.map((x) => x)),
      tripBids: json["trip_bids"] == null ? [] : List<TripBid>.from(json["trip_bids"]!.map((x) => TripBid.fromJson(x))),
    );
  }

}

class TripBid {
  TripBid({
    required this.id,
    required this.tripId,
    required this.customerId,
    required this.partnerId,
    required this.vehicleCategory,
    required this.vehicleId,
    required this.assignedDriverId,
    required this.carId,
    required this.amount,
    required this.bidAmount,
    required this.extraPrice,
    required this.platformCharge,
    required this.advance,
    required this.drivercollectamount,
    required this.drivercredit,
    required this.promoAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.getvehicle,
    required this.getpartner,
    required this.getBrand,
    required this.getCar,
  });

  final int? id;
  final String? tripId;
  final String? customerId;
  final String? partnerId;
  final String? vehicleCategory;
  final String? vehicleId;
  final dynamic assignedDriverId;
  final String? carId;
  final int? amount;
  final String? bidAmount;
  final String? extraPrice;
  final String? platformCharge;
  final String? advance;
  final int? drivercollectamount;
  final int? drivercredit;
  final int? promoAmount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GetCar? getvehicle;
  final Getpartner? getpartner;
  final GetBrand? getBrand;
  final GetCar? getCar;

  factory TripBid.fromJson(Map<String, dynamic> json){
    return TripBid(
      id: json["id"],
      tripId: json["trip_id"],
      customerId: json["customer_id"],
      partnerId: json["partner_id"],
      vehicleCategory: json["vehicle_category"],
      vehicleId: json["vehicle_id"],
      assignedDriverId: json["assigned_driver_id"],
      carId: json["car_id"],
      amount: json["amount"],
      bidAmount: json["bid_amount"],
      extraPrice: json["extra_price"],
      platformCharge: json["platform_charge"],
      advance: json["advance"].toString(),
      drivercollectamount: json["drivercollectamount"],
      drivercredit: json["drivercredit"],
      promoAmount: json["promo_amount"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      getvehicle: json["getvehicle"] == null ? null : GetCar.fromJson(json["getvehicle"]),
      getpartner: json["getpartner"] == null ? null : Getpartner.fromJson(json["getpartner"]),
      getBrand: json["get_brand"] == null ? null : GetBrand.fromJson(json["get_brand"]),
      getCar: json["get_car"] == null ? null : GetCar.fromJson(json["get_car"]),
    );
  }

}

class GetBrand {
  GetBrand({
    required this.id,
    required this.vehicleCategory,
    required this.sizecategoryId,
    required this.truckType,
    required this.name,
    required this.nameBn,
    required this.slug,
    required this.capacity,
    required this.biddingTime,
    required this.blockTime,
    required this.scheduleDay,
    required this.lowValue,
    required this.highValue,
    required this.bookingPercentage,
    required this.image,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? vehicleCategory;
  final dynamic sizecategoryId;
  final dynamic truckType;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? biddingTime;
  final String? blockTime;
  final String? scheduleDay;
  final String? lowValue;
  final String? highValue;
  final String? bookingPercentage;
  final String? image;
  final String? description;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetBrand.fromJson(Map<String, dynamic> json){
    return GetBrand(
      id: json["id"],
      vehicleCategory: json["vehicle_category"],
      sizecategoryId: json["sizecategory_id"],
      truckType: json["truck_type"],
      name: json["name"],
      nameBn: json["name_bn"],
      slug: json["slug"],
      capacity: json["capacity"],
      biddingTime: json["bidding_time"],
      blockTime: json["block_time"],
      scheduleDay: json["schedule_day"],
      lowValue: json["low_value"],
      highValue: json["high_value"],
      bookingPercentage: json["booking_percentage"],
      image: json["image"],
      description: json["description"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class GetCar {
  GetCar({
    required this.id,
    required this.partnerId,
    required this.vehicleCategory,
    required this.brand,
    required this.sizecategoryId,
    required this.truckType,
    required this.metro,
    required this.metroType,
    required this.metroNo,
    required this.model,
    required this.modelYear,
    required this.vehicleColor,
    required this.aircondition,
    required this.brandName,
    required this.fuelType,
    required this.vehicleFrontPic,
    required this.vehicleBackPic,
    required this.vehicleInsidePic1,
    required this.vehicleInsidePic2,
    required this.vehiclePlateNo,
    required this.vehicleRegPic,
    required this.vehicleRootPic,
    required this.vehicleFitnessPic,
    required this.vehicleTaxPic,
    required this.vehicleInsurancePic,
    required this.vehicleDrivingFront,
    required this.vehicleDrivingBack,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.getMetroType,
  });

  final int? id;
  final String? partnerId;
  final String? vehicleCategory;
  final String? brand;
  final dynamic sizecategoryId;
  final dynamic truckType;
  final String? metro;
  final String? metroType;
  final String? metroNo;
  final String? model;
  final String? modelYear;
  final String? vehicleColor;
  final String? aircondition;
  final String? brandName;
  final String? fuelType;
  final String? vehicleFrontPic;
  final String? vehicleBackPic;
  final String? vehicleInsidePic1;
  final String? vehicleInsidePic2;
  final String? vehiclePlateNo;
  final String? vehicleRegPic;
  final String? vehicleRootPic;
  final String? vehicleFitnessPic;
  final String? vehicleTaxPic;
  final String? vehicleInsurancePic;
  final dynamic vehicleDrivingFront;
  final dynamic vehicleDrivingBack;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GetMetroType? getMetroType;

  factory GetCar.fromJson(Map<String, dynamic> json){
    return GetCar(
      id: json["id"],
      partnerId: json["partner_id"],
      vehicleCategory: json["vehicle_category"],
      brand: json["brand"],
      sizecategoryId: json["sizecategory_id"],
      truckType: json["truck_type"],
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
      vehicleInsidePic1: json["vehicle_inside_pic1"],
      vehicleInsidePic2: json["vehicle_inside_pic2"],
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
      getMetroType: json["get_metro_type"] == null ? null : GetMetroType.fromJson(json["get_metro_type"]),
    );
  }

}

class GetMetroType {
  GetMetroType({
    required this.id,
    required this.metroSubName,
    required this.status,
    required this.nameBn,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? metroSubName;
  final String? status;
  final String? nameBn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetMetroType.fromJson(Map<String, dynamic> json){
    return GetMetroType(
      id: json["id"],
      metroSubName: json["metro_sub_name"],
      status: json["status"],
      nameBn: json["name_bn"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Getpartner {
  Getpartner({
    required this.id,
    required this.name,
    required this.rating,
    required this.phone,
    required this.email,
    required this.image,
    required this.categoryId,
    required this.sizecategoryId,
    required this.vehicleId,
    required this.truckType,
    required this.docType,
    required this.docNumber,
    required this.drivingLicenseNo,
    required this.docFront,
    required this.docBack,
    required this.drivingLicenseFront,
    required this.drivingLicenseBack,
    required this.divisionId,
    required this.districtId,
    required this.thanaId,
    required this.address,
    required this.gender,
    required this.referCode,
    required this.myreferKey,
    required this.verify,
    required this.forgotCode,
    required this.credit,
    required this.debit,
    required this.deviceToken,
    required this.deviceId,
    required this.packageId,
    required this.packageStatus,
    required this.enableDate,
    required this.expireDate,
    required this.currentMap,
    required this.cancelButton,
    required this.cancelCount,
    required this.suspendExpiredAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final dynamic rating;
  final String? phone;
  final String? email;
  final String? image;
  final String? categoryId;
  final dynamic sizecategoryId;
  final dynamic vehicleId;
  final dynamic truckType;
  final String? docType;
  final String? docNumber;
  final dynamic drivingLicenseNo;
  final dynamic docFront;
  final dynamic docBack;
  final String? drivingLicenseFront;
  final String? drivingLicenseBack;
  final String? divisionId;
  final String? districtId;
  final String? thanaId;
  final String? address;
  final String? gender;
  final dynamic referCode;
  final String? myreferKey;
  final String? verify;
  final dynamic forgotCode;
  final String? credit;
  final String? debit;
  final String? deviceToken;
  final String? deviceId;
  final String? packageId;
  final String? packageStatus;
  final DateTime? enableDate;
  final DateTime? expireDate;
  final String? currentMap;
  final String? cancelButton;
  final String? cancelCount;
  final dynamic suspendExpiredAt;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Getpartner.fromJson(Map<String, dynamic> json){
    return Getpartner(
      id: json["id"],
      name: json["name"],
      rating: json["rating"],
      phone: json["phone"],
      email: json["email"],
      image: json["image"],
      categoryId: json["category_id"],
      sizecategoryId: json["sizecategory_id"],
      vehicleId: json["vehicle_id"],
      truckType: json["truck_type"],
      docType: json["doc_type"],
      docNumber: json["doc_number"],
      drivingLicenseNo: json["driving_license_no"],
      docFront: json["doc_front"],
      docBack: json["doc_back"],
      drivingLicenseFront: json["driving_license_front"],
      drivingLicenseBack: json["driving_license_back"],
      divisionId: json["division_id"],
      districtId: json["district_id"],
      thanaId: json["thana_id"],
      address: json["address"],
      gender: json["gender"],
      referCode: json["refer_code"],
      myreferKey: json["myrefer_key"],
      verify: json["verify"],
      forgotCode: json["forgot_code"],
      credit: json["credit"],
      debit: json["debit"],
      deviceToken: json["device_token"],
      deviceId: json["device_id"],
      packageId: json["package_id"],
      packageStatus: json["package_status"],
      enableDate: DateTime.tryParse(json["enable_date"] ?? ""),
      expireDate: DateTime.tryParse(json["expire_date"] ?? ""),
      currentMap: json["current_map"],
      cancelButton: json["cancel_button"],
      cancelCount: json["cancel_count"],
      suspendExpiredAt: json["suspend_expired_at"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }



}
String? _toStr(dynamic value) => value?.toString();
class DropoffLocations {
  final int? id;
  final String? tripId;
  final String? dropoffLocation;
  final String? dropoffMap;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  DropoffLocations({
    this.id,
    this.tripId,
    this.dropoffLocation,
    this.dropoffMap,
    this.status,
    this.createdAt,
    this.updatedAt,
  });


  DropoffLocations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        tripId = _toStr(json['trip_id']),
        dropoffLocation = _toStr(json['dropoff_location']),
        dropoffMap = _toStr(json['dropoff_map']),
        status = _toStr(json['status']),
        createdAt = _toStr(json['created_at']),
        updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'trip_id': tripId,
    'dropoff_location': dropoffLocation,
    'dropoff_map': dropoffMap,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
