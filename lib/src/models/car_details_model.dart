import 'live_bidding_model.dart';

class CarDetailsModel {
  CarDetailsModel({
     this.status,
     this.data,
  });

  final String? status;
  final Data? data;

  factory CarDetailsModel.fromJson(Map<String, dynamic> json){
    return CarDetailsModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.biddata,
    required this.metrotype,
    required this.ratingAvg,
    required this.ratingCounts,
    required this.totalReviews,
  });

  final Biddata? biddata;
  final dynamic metrotype;
  final int? ratingAvg;
  final RatingCounts? ratingCounts;
  final int? totalReviews;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      biddata: json["biddata"] == null ? null : Biddata.fromJson(json["biddata"]),
      metrotype: json["metrotype"],
      ratingAvg: json["rating_avg"],
      ratingCounts: json["rating_counts"] == null ? null : RatingCounts.fromJson(json["rating_counts"]),
      totalReviews: json["total_reviews"],
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
  final String? extraPrice;
  final String? platformCharge;
  final int? advance;
  final int? drivercollectamount;
  final int? drivercredit;
  final int? promoAmount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Get? getvehicle;
  final Getpartner? getpartner;
  final GetBrand? getBrand;
  final Get? getCar;

  factory Biddata.fromJson(Map<String, dynamic> json) {
    return Biddata(
      id: parseInt(json["id"]),

      tripId: parseString(json["trip_id"]),
      customerId: parseString(json["customer_id"]),
      partnerId: parseString(json["partner_id"]),
      vehicleCategory: parseString(json["vehicle_category"]),
      vehicleId: parseString(json["vehicle_id"]),

      assignedDriverId: parseInt(json["assigned_driver_id"]),
      carId: parseString(json["car_id"]),

      amount: parseInt(json["amount"]),
      extraPrice: parseString(json["extra_price"]),
      platformCharge: parseString(json["platform_charge"]),

      advance: parseInt(json["advance"]),
      drivercollectamount: parseInt(json["drivercollectamount"]),
      drivercredit: parseInt(json["drivercredit"]),
      promoAmount: parseInt(json["promo_amount"]),

      status: parseString(json["status"]),

      createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"]?.toString() ?? ""),

      getvehicle: json["getvehicle"] != null
          ? Get.fromJson(json["getvehicle"])
          : null,

      getpartner: json["getpartner"] != null
          ? Getpartner.fromJson(json["getpartner"])
          : null,

      getBrand: json["get_brand"] != null
          ? GetBrand.fromJson(json["get_brand"])
          : null,

      getCar: json["get_car"] != null
          ? Get.fromJson(json["get_car"])
          : null,
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

  factory GetBrand.fromJson(Map<String, dynamic> json) {
    return GetBrand(
      id: parseInt(json["id"]),
      vehicleCategory: parseString(json["vehicle_category"]),

      sizecategoryId: parseInt(json["sizecategory_id"]),
      truckType: parseString(json["truck_type"]),

      name: parseString(json["name"]),
      nameBn: parseString(json["name_bn"]),
      slug: parseString(json["slug"]),

      capacity: parseString(json["capacity"]),
      biddingTime: parseString(json["bidding_time"]),
      blockTime: parseString(json["block_time"]),
      scheduleDay: parseString(json["schedule_day"]),

      lowValue: parseString(json["low_value"]),
      highValue: parseString(json["high_value"]),
      bookingPercentage: parseString(json["booking_percentage"]),

      image: parseString(json["image"]),
      description: parseString(json["description"]),
      status: parseString(json["status"]),

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

  factory Get.fromJson(Map<String, dynamic> json) {
    return Get(
      id: parseInt(json["id"]),

      partnerId: parseString(json["partner_id"]),
      vehicleCategory: parseString(json["vehicle_category"]),
      brand: parseString(json["brand"]),

      sizecategoryId: parseInt(json["sizecategory_id"]),
      truckType: parseString(json["truck_type"]),

      metro: parseString(json["metro"]),
      metroType: parseString(json["metro_type"]),
      metroNo: parseString(json["metro_no"]),

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

      vehicleDrivingFront: parseString(json["vehicle_driving_front"]),
      vehicleDrivingBack: parseString(json["vehicle_driving_back"]),

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
    required this.deviceToken,
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
  final String? drivingLicenseNo;
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

  factory Getpartner.fromJson(Map<String, dynamic> json) {
    return Getpartner(
      id: parseInt(json["id"]),
      name: parseString(json["name"]),
      rating: parseDouble(json["rating"]),

      phone: parseString(json["phone"]),
      email: parseString(json["email"]),
      image: parseString(json["image"]),

      categoryId: parseString(json["category_id"]),
      sizecategoryId: parseInt(json["sizecategory_id"]),
      vehicleId: parseInt(json["vehicle_id"]),
      truckType: parseString(json["truck_type"]),

      docType: parseString(json["doc_type"]),
      docNumber: parseString(json["doc_number"]),
      drivingLicenseNo: parseString(json["driving_license_no"]),

      docFront: parseString(json["doc_front"]),
      docBack: parseString(json["doc_back"]),
      drivingLicenseFront: parseString(json["driving_license_front"]),
      drivingLicenseBack: parseString(json["driving_license_back"]),

      divisionId: parseString(json["division_id"]),
      districtId: parseString(json["district_id"]),
      thanaId: parseString(json["thana_id"]),

      address: parseString(json["address"]),
      gender: parseString(json["gender"]),

      referCode: parseString(json["refer_code"]),
      myreferKey: parseString(json["myrefer_key"]),
      verify: parseString(json["verify"]),

      forgotCode: parseString(json["forgot_code"]),
      credit: parseString(json["credit"]),
      debit: parseString(json["debit"]),

      deviceToken: parseString(json["device_token"]),
      packageId: parseString(json["package_id"]),
      packageStatus: parseString(json["package_status"]),

      enableDate: DateTime.tryParse(json["enable_date"]?.toString() ?? ""),
      expireDate: DateTime.tryParse(json["expire_date"]?.toString() ?? ""),

      currentMap: parseString(json["current_map"]),
      cancelButton: parseString(json["cancel_button"]),
      cancelCount: parseString(json["cancel_count"]),

      suspendExpiredAt: json["suspend_expired_at"],
      status: parseString(json["status"]),

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
      the1Star: json["1_star"],
      the2Star: json["2_star"],
      the3Star: json["3_star"],
      the4Star: json["4_star"],
      the5Star: json["5_star"],
    );
  }

}
