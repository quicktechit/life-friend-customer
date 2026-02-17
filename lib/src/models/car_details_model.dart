class CarDetailsModel {
  CarDetailsModel({
    this.status,
    this.data,
  });

  final String? status;
  final CarDetails? data;

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) {
    return CarDetailsModel(
      status: json["status"],
      data: json["data"] == null ? null : CarDetails.fromJson(json["data"]),
    );
  }
}

class CarDetails {
  CarDetails({
    this.averageStar,
    this.reviewsCount,
    this.reviews,
    this.biddata,
    this.metrotype,
  });

  final String? averageStar;
  final int? reviewsCount;
  final List<Review>? reviews;
  final Biddata? biddata;
  final Metrotype? metrotype;

  factory CarDetails.fromJson(Map<String, dynamic> json) {
    return CarDetails(
      averageStar: json["average_star"],
      reviewsCount: json["reviews_count"],
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      biddata:
          json["biddata"] == null ? null : Biddata.fromJson(json["biddata"]),
      metrotype: json["metrotype"] == null
          ? null
          : Metrotype.fromJson(json["metrotype"]),
    );
  }
}

class Biddata {
  Biddata({
    this.id,
    this.tripId,
    this.customerId,
    this.partnerId,
    this.vehicleId,
    this.carId,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.getvehicle,
    this.getpartner,
    this.getBrand,
    this.getCar,
  });

  final int? id;
  final String? tripId;
  final String? customerId;
  final String? partnerId;
  final String? vehicleId;
  final String? carId;
  final String? amount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Get? getvehicle;
  final Getpartner? getpartner;
  final GetBrand? getBrand;
  final Get? getCar;

  factory Biddata.fromJson(Map<String, dynamic> json) {
    return Biddata(
      id: json["id"],
      tripId: json["trip_id"].toString(),
      customerId: json["customer_id"].toString(),
      partnerId: json["partner_id"].toString(),
      vehicleId: json["vehicle_id"].toString(),
      carId: json["car_id"].toString(),
      amount: json["amount"].toString(),
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      getvehicle:
          json["getvehicle"] == null ? null : Get.fromJson(json["getvehicle"]),
      getpartner: json["getpartner"] == null
          ? null
          : Getpartner.fromJson(json["getpartner"]),
      getBrand: json["get_brand"] == null
          ? null
          : GetBrand.fromJson(json["get_brand"]),
      getCar: json["get_car"] == null ? null : Get.fromJson(json["get_car"]),
    );
  }
}

class GetBrand {
  GetBrand({
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
  final String? vehicleCategory;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? image;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetBrand.fromJson(Map<String, dynamic> json) {
    return GetBrand(
      id: json["id"],
      vehicleCategory: json["vehicle_category"].toString(),
      name: json["name"],
      nameBn: json["name_bn"],
      slug: json["slug"],
      capacity: json["capacity"],
      image: json["image"],
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class Get {
  Get({
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
  });

  final int? id;
  final String? partnerId;
  final String? vehicleCategory;
  final String? brand;
  final String? metro;
  final String? metroType;
  final String? metroNo;
  final String? model;
  final String? modelYear;
  final String? vehicleColor;
  final String? aircondition;
  final dynamic brandName;
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

  factory Get.fromJson(Map<String, dynamic> json) {
    return Get(
      id: json["id"],
      partnerId: json["partner_id"].toString(),
      vehicleCategory: json["vehicle_category"].toString(),
      brand: json["brand"],
      metro: json["metro"],
      metroType: json["metro_type"].toString(),
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
  final String? credit;
  final String? debit;
  final String? status;
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
      credit: json["credit"].toString(),
      debit: json["debit"].toString(),
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class Metrotype {
  Metrotype({
    this.id,
    this.metroSubName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? metroSubName;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Metrotype.fromJson(Map<String, dynamic> json) {
    return Metrotype(
      id: json["id"],
      metroSubName: json["metro_sub_name"],
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class Review {
  Review({
    this.id,
    this.tripId,
    this.returnTrip,
    this.partnerId,
    this.customerId,
    this.starReviews,
    this.comment,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.getCustomer,
  });

  final int? id;
  final String? tripId;
  final String? returnTrip;
  final String? partnerId;
  final String? customerId;
  final String? starReviews;
  final String? comment;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GetCustomer? getCustomer;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["id"],
      tripId: json["trip_id"].toString(),
      returnTrip: json["return_trip"].toString(),
      partnerId: json["partner_id"].toString(),
      customerId: json["customer_id"].toString(),
      starReviews: json["star_reviews"].toString(),
      comment: json["comment"],
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      getCustomer: json["get_customer"] == null
          ? null
          : GetCustomer.fromJson(json["get_customer"]),
    );
  }
}

class GetCustomer {
  GetCustomer({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.birthday,
    this.gender,
    this.district,
    this.address,
    this.image,
    this.verify,
    this.expireAt,
    this.forgotCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? phone;
  final dynamic email;
  final dynamic birthday;
  final dynamic gender;
  final dynamic district;
  final dynamic address;
  final dynamic image;
  final String? verify;
  final DateTime? expireAt;
  final dynamic forgotCode;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetCustomer.fromJson(Map<String, dynamic> json) {
    return GetCustomer(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      birthday: json["birthday"],
      gender: json["gender"],
      district: json["district"],
      address: json["address"],
      image: json["image"],
      verify: json["verify"],
      expireAt: DateTime.tryParse(json["expire_at"] ?? ""),
      forgotCode: json["forgot_code"],
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
