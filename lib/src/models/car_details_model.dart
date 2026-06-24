class CarDetailsModel {
  CarDetailsModel({
     this.status,
     this.data,
  });

  final String? status;
  final Data? data;

  factory CarDetailsModel.fromJson(Map<String, dynamic> json){
    return CarDetailsModel(
      status: parseString(json["status"]),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.biddata,
    required this.ratingAvg,
    required this.ratingCounts,
    required this.totalReviews,
  });

  final Biddata? biddata;
  final int? ratingAvg;
  final RatingCounts? ratingCounts;
  final int? totalReviews;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      biddata: json["biddata"] == null ? null : Biddata.fromJson(json["biddata"]),
      ratingAvg: parseInt(json["rating_avg"]),
      ratingCounts: json["rating_counts"] == null ? null : RatingCounts.fromJson(json["rating_counts"]),
      totalReviews: parseInt(json["total_reviews"]),
    );
  }

}

class Biddata {
  Biddata({
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
    required this.driverbookingportion,
    required this.appcommission,
    required this.appcommissionamount,
    required this.promoAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.getvehicle,
    required this.getpartner,
    required this.getBrand,
    required this.getCar,
    required this.getDriver,
  });

  final int? id;
  final int? tripId;
  final int? customerId;
  final int? partnerId;
  final int? vehicleCategory;
  final int? vehicleId;
  final int? assignedDriverId;
  final int? carId;
  final int? amount;
  final int? bidAmount;
  final int? extraPrice;
  final int? platformCharge;
  final int? advance;
  final int? drivercollectamount;
  final int? drivercredit;
  final String? driverbookingportion;
  final String? appcommission;
  final String? appcommissionamount;
  final int? promoAmount;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Get? getvehicle;
  final Getpartner? getpartner;
  final GetBrand? getBrand;
  final Get? getCar;
  final GetDriver? getDriver;

  factory Biddata.fromJson(Map<String, dynamic> json){
    return Biddata(
      id: parseInt(json["id"]),
      tripId: parseInt(json["trip_id"]),
      customerId: parseInt(json["customer_id"]),
      partnerId: parseInt(json["partner_id"]),
      vehicleCategory: parseInt(json["vehicle_category"]),
      vehicleId: parseInt(json["vehicle_id"]),
      assignedDriverId: parseInt(json["assigned_driver_id"]),
      carId: parseInt(json["car_id"]),
      amount: parseInt(json["amount"]),
      bidAmount: parseInt(json["bid_amount"]),
      extraPrice: parseInt(json["extra_price"]),
      platformCharge: parseInt(json["platform_charge"]),
      advance: parseInt(json["advance"]),
      drivercollectamount: parseInt(json["drivercollectamount"]),
      drivercredit: parseInt(json["drivercredit"]),
      driverbookingportion: parseString(json["driverbookingportion"]),
      appcommission: parseString(json["appcommission"]),
      appcommissionamount: parseString(json["appcommissionamount"]),
      promoAmount: parseInt(json["promo_amount"]),
      status: parseInt(json["status"]),
      createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"]?.toString() ?? ""),
      getvehicle: json["getvehicle"] == null ? null : Get.fromJson(json["getvehicle"]),
      getpartner: json["getpartner"] == null ? null : Getpartner.fromJson(json["getpartner"]),
      getBrand: json["get_brand"] == null ? null : GetBrand.fromJson(json["get_brand"]),
      getCar: json["get_car"] == null ? null : Get.fromJson(json["get_car"]),
      getDriver: json["get_driver"] == null ? null : GetDriver.fromJson(json["get_driver"]),
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
  final int? vehicleCategory;
  final dynamic sizecategoryId;
  final dynamic truckType;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final int? biddingTime;
  final int? blockTime;
  final int? scheduleDay;
  final int? lowValue;
  final int? highValue;
  final int? bookingPercentage;
  final String? image;
  final String? description;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetBrand.fromJson(Map<String, dynamic> json){
    return GetBrand(
      id: parseInt(json["id"]),
      vehicleCategory: parseInt(json["vehicle_category"]),
      sizecategoryId: json["sizecategory_id"],
      truckType: json["truck_type"],
      name: parseString(json["name"]),
      nameBn: parseString(json["name_bn"]),
      slug: parseString(json["slug"]),
      capacity: parseString(json["capacity"]),
      biddingTime: parseInt(json["bidding_time"]),
      blockTime: parseInt(json["block_time"]),
      scheduleDay: parseInt(json["schedule_day"]),
      lowValue: parseInt(json["low_value"]),
      highValue: parseInt(json["high_value"]),
      bookingPercentage: parseInt(json["booking_percentage"]),
      image: parseString(json["image"]),
      description: parseString(json["description"]),
      status: parseInt(json["status"]),
      createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"]?.toString() ?? ""),
    );
  }

}

class Get {
  Get({
    required this.id,
    required this.partnerId,
    required this.vehicleCategory,
    required this.brand,
    required this.sizecategoryId,
    required this.truckType,
    required this.metro,
    required this.metroType,
    required this.metroNo,
    required this.registrationNo,
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
    required this.vehicleLeftPic,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicleRightPic,
    required this.vehicleInsidePic3,
    required this.vehicleRegBackPic,
    required this.fitnessExpiryDate,
    required this.taxExpiryDate,
    required this.getMetroType,
  });

  final int? id;
  final int? partnerId;
  final int? vehicleCategory;
  final int? brand;
  final dynamic sizecategoryId;
  final dynamic truckType;
  final String? metro;
  final int? metroType;
  final String? metroNo;
  final dynamic registrationNo;
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
  final dynamic vehicleLeftPic;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic vehicleRightPic;
  final dynamic vehicleInsidePic3;
  final dynamic vehicleRegBackPic;
  final dynamic fitnessExpiryDate;
  final dynamic taxExpiryDate;
  final GetMetroType? getMetroType;

  factory Get.fromJson(Map<String, dynamic> json){
    return Get(
      id: parseInt(json["id"]),
      partnerId: parseInt(json["partner_id"]),
      vehicleCategory: parseInt(json["vehicle_category"]),
      brand: parseInt(json["brand"]),
      sizecategoryId: json["sizecategory_id"],
      truckType: json["truck_type"],
      metro: parseString(json["metro"]),
      metroType: parseInt(json["metro_type"]),
      metroNo: parseString(json["metro_no"]),
      registrationNo: json["registration_no"],
      model: parseString(json["model"]),
      modelYear: parseString(json["model_year"]),
      vehicleColor: parseString(json["vehicle_color"]),
      aircondition: parseString(json["aircondition"]),
      brandName: parseString(json["brand_name"]),
      fuelType: parseString(json["fuel_type"]),
      vehicleFrontPic: parseString(json["vehicle_front_pic"]),
      vehicleBackPic: parseString(json["vehicle_back_pic"]),
      vehicleInsidePic1: parseString(json["vehicle_inside_pic1"]),
      vehicleInsidePic2: parseString(json["vehicle_inside_pic2"]),
      vehiclePlateNo: parseString(json["vehicle_plate_no"]),
      vehicleRegPic: parseString(json["vehicle_reg_pic"]),
      vehicleRootPic: parseString(json["vehicle_root_pic"]),
      vehicleFitnessPic: parseString(json["vehicle_fitness_pic"]),
      vehicleTaxPic: parseString(json["vehicle_tax_pic"]),
      vehicleInsurancePic: parseString(json["vehicle_insurance_pic"]),
      vehicleDrivingFront: json["vehicle_driving_front"],
      vehicleDrivingBack: json["vehicle_driving_back"],
      vehicleLeftPic: json["vehicle_left_pic"],
      status: parseString(json["status"]),
      createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"]?.toString() ?? ""),
      vehicleRightPic: json["vehicle_right_pic"],
      vehicleInsidePic3: json["vehicle_inside_pic3"],
      vehicleRegBackPic: json["vehicle_reg_back_pic"],
      fitnessExpiryDate: json["fitness_expiry_date"],
      taxExpiryDate: json["tax_expiry_date"],
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
  final int? status;
  final String? nameBn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetMetroType.fromJson(Map<String, dynamic> json){
    return GetMetroType(
      id: parseInt(json["id"]),
      metroSubName: parseString(json["metro_sub_name"]),
      status: parseInt(json["status"]),
      nameBn: parseString(json["name_bn"]),
      createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"]?.toString() ?? ""),
    );
  }

}

class GetDriver {
  GetDriver({
    required this.id,
    required this.partnerId,
    required this.name,
    required this.phone,
    required this.contactNo,
    required this.email,
    required this.gender,
    required this.address,
    required this.drivingNo,
    required this.nidNo,
    required this.drivingImage,
    required this.drivingFront,
    required this.drivingBack,
    required this.drivingExpiredate,
    required this.fitnessExpiryDate,
    required this.taxExpiryDate,
    required this.nidFront,
    required this.nidBack,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
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
  final dynamic nidNo;
  final String? drivingImage;
  final dynamic drivingFront;
  final dynamic drivingBack;
  final dynamic drivingExpiredate;
  final dynamic fitnessExpiryDate;
  final dynamic taxExpiryDate;
  final String? nidFront;
  final String? nidBack;
  final String? image;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetDriver.fromJson(Map<String, dynamic> json){
    return GetDriver(
      id: parseInt(json["id"]),
      partnerId: parseInt(json["partner_id"]),
      name: parseString(json["name"]),
      phone: parseString(json["phone"]),
      contactNo: parseString(json["contact_no"]),
      email: parseString(json["email"]),
      gender: parseString(json["gender"]),
      address: parseString(json["address"]),
      drivingNo: parseString(json["driving_no"]),
      nidNo: json["nid_no"],
      drivingImage: parseString(json["driving_image"]),
      drivingFront: json["driving_front"],
      drivingBack: json["driving_back"],
      drivingExpiredate: json["driving_expiredate"],
      fitnessExpiryDate: json["fitness_expiry_date"],
      taxExpiryDate: json["tax_expiry_date"],
      nidFront: parseString(json["nid_front"]),
      nidBack: parseString(json["nid_back"]),
      image: parseString(json["image"]),
      status: parseString(json["status"]),
      createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"]?.toString() ?? ""),
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
    required this.currentToken,
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
  final int? rating;
  final String? phone;
  final String? email;
  final String? image;
  final int? categoryId;
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
  final int? divisionId;
  final int? districtId;
  final int? thanaId;
  final String? address;
  final String? gender;
  final dynamic referCode;
  final String? myreferKey;
  final String? verify;
  final String? forgotCode;
  final int? credit;
  final int? debit;
  final String? currentToken;
  final String? deviceToken;
  final String? deviceId;
  final int? packageId;
  final int? packageStatus;
  final DateTime? enableDate;
  final DateTime? expireDate;
  final String? currentMap;
  final int? cancelButton;
  final int? cancelCount;
  final dynamic suspendExpiredAt;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Getpartner.fromJson(Map<String, dynamic> json){
    return Getpartner(
      id: parseInt(json["id"]),
      name: parseString(json["name"]),
      rating: parseInt(json["rating"]),
      phone: parseString(json["phone"]),
      email: parseString(json["email"]),
      image: parseString(json["image"]),
      categoryId: parseInt(json["category_id"]),
      sizecategoryId: json["sizecategory_id"],
      vehicleId: json["vehicle_id"],
      truckType: json["truck_type"],
      docType: parseString(json["doc_type"]),
      docNumber: parseString(json["doc_number"]),
      drivingLicenseNo: json["driving_license_no"],
      docFront: json["doc_front"],
      docBack: json["doc_back"],
      drivingLicenseFront: parseString(json["driving_license_front"]),
      drivingLicenseBack: parseString(json["driving_license_back"]),
      divisionId: parseInt(json["division_id"]),
      districtId: parseInt(json["district_id"]),
      thanaId: parseInt(json["thana_id"]),
      address: parseString(json["address"]),
      gender: parseString(json["gender"]),
      referCode: json["refer_code"],
      myreferKey: parseString(json["myrefer_key"]),
      verify: parseString(json["verify"]),
      forgotCode: json["forgot_code"],
      credit: parseInt(json["credit"]),
      debit: parseInt(json["debit"]),
      currentToken: parseString(json["current_token"]),
      deviceToken: parseString(json["device_token"]),
      deviceId: parseString(json["device_id"]),
      packageId: parseInt(json["package_id"]),
      packageStatus: parseInt(json["package_status"]),
      enableDate: DateTime.tryParse(json["enable_date"]?.toString() ?? ""),
      expireDate: DateTime.tryParse(json["expire_date"]?.toString() ?? ""),
      currentMap: parseString(json["current_map"]),
      cancelButton: parseInt(json["cancel_button"]),
      cancelCount: parseInt(json["cancel_count"]),
      suspendExpiredAt: json["suspend_expired_at"],
      status: parseInt(json["status"]),
      createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"]?.toString() ?? ""),
    );
  }

}

class RatingCounts {
  RatingCounts({
    required this.the1Star,
    required this.the2Star,
    required this.the3Star,
    required this.the4Star,
    required this.the5Star,
  });

  final int? the1Star;
  final int? the2Star;
  final int? the3Star;
  final int? the4Star;
  final int? the5Star;

  factory RatingCounts.fromJson(Map<String, dynamic> json){
    return RatingCounts(
      the1Star: parseInt(json["1_star"]),
      the2Star: parseInt(json["2_star"]),
      the3Star: parseInt(json["3_star"]),
      the4Star: parseInt(json["4_star"]),
      the5Star: parseInt(json["5_star"]),
    );
  }

}

int? parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString());
}

double? parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}

String? parseString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}
