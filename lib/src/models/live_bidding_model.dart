class LiveBiddingModel {
  final String? status;
  final List<TripList>? tripList;

  LiveBiddingModel({
    this.status,
    this.tripList,
  });

  LiveBiddingModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        tripList = (json['trip_list'] as List?)?.map((dynamic e) => TripList.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'trip_list' : tripList?.map((e) => e.toJson()).toList()
  };
}

class TripList {
  final int? id;
  final int? customerId;
  final int? categoryId;
  final int? sizecategoryId;
  final String? truckType;
  final int? vehicleId;
  final String? pickupLocation;
  final dynamic viaLocation;
  final dynamic dropoffLocation;
  final dynamic addressId;
  final dynamic isHourly;
  final dynamic hours;
  final String? map;
  final dynamic dropoffMap;
  final dynamic districtId;
  final dynamic portId;
  final String? datetime;
  final dynamic roundTrip;
  final dynamic promoKey;
  final dynamic roundDatetime;
  final dynamic note;
  final String? trackingId;
  final int? isAirport;
  final int? productType;
  final dynamic productDetails;
  final int? isLabour;
  final int? distance;
  final int? amount;
  final int? extendedAmount;
  final int? status;
  final int? biding;
  final String? bidingExpiredAt;
  final int? isCancel;
  final dynamic cancelreasonId;
  final String? createdAt;
  final String? updatedAt;
  final List<DropoffLocations>? dropoffLocations;
  final List<TripBids>? tripBids;

  TripList({
    this.id,
    this.customerId,
    this.categoryId,
    this.sizecategoryId,
    this.truckType,
    this.vehicleId,
    this.pickupLocation,
    this.viaLocation,
    this.dropoffLocation,
    this.addressId,
    this.isHourly,
    this.hours,
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
    this.isAirport,
    this.productType,
    this.productDetails,
    this.isLabour,
    this.distance,
    this.amount,
    this.extendedAmount,
    this.status,
    this.biding,
    this.bidingExpiredAt,
    this.isCancel,
    this.cancelreasonId,
    this.createdAt,
    this.updatedAt,
    this.dropoffLocations,
    this.tripBids,
  });

  TripList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        customerId = json['customer_id'] as int?,
        categoryId = json['category_id'] as int?,
        sizecategoryId = json['sizecategory_id'] as int?,
        truckType = json['truck_type'] as String?,
        vehicleId = json['vehicle_id'] as int?,
        pickupLocation = json['pickup_location'] as String?,
        viaLocation = json['via_location'],
        dropoffLocation = json['dropoff_location'],
        addressId = json['address_id'],
        isHourly = json['is_hourly'],
        hours = json['hours'],
        map = json['map'] as String?,
        dropoffMap = json['dropoff_map'],
        districtId = json['district_id'],
        portId = json['port_id'],
        datetime = json['datetime'] as String?,
        roundTrip = json['round_trip'],
        promoKey = json['promo_key'],
        roundDatetime = json['round_datetime'],
        note = json['note'],
        trackingId = json['tracking_id'] as String?,
        isAirport = json['is_airport'] as int?,
        productType = json['product_type'] as int?,
        productDetails = json['product_details'],
        isLabour = json['is_labour'] as int?,
        distance = json['distance'] as int?,
        amount = json['amount'] as int?,
        extendedAmount = json['extended_amount'] as int?,
        status = json['status'] as int?,
        biding = json['biding'] as int?,
        bidingExpiredAt = json['biding_expired_at'] as String?,
        isCancel = json['is_cancel'] as int?,
        cancelreasonId = json['cancelreason_id'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        dropoffLocations = (json['dropoff_locations'] as List?)?.map((dynamic e) => DropoffLocations.fromJson(e as Map<String,dynamic>)).toList(),
        tripBids = (json['trip_bids'] as List?)?.map((dynamic e) => TripBids.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'customer_id' : customerId,
    'category_id' : categoryId,
    'sizecategory_id' : sizecategoryId,
    'truck_type' : truckType,
    'vehicle_id' : vehicleId,
    'pickup_location' : pickupLocation,
    'via_location' : viaLocation,
    'dropoff_location' : dropoffLocation,
    'address_id' : addressId,
    'is_hourly' : isHourly,
    'hours' : hours,
    'map' : map,
    'dropoff_map' : dropoffMap,
    'district_id' : districtId,
    'port_id' : portId,
    'datetime' : datetime,
    'round_trip' : roundTrip,
    'promo_key' : promoKey,
    'round_datetime' : roundDatetime,
    'note' : note,
    'tracking_id' : trackingId,
    'is_airport' : isAirport,
    'product_type' : productType,
    'product_details' : productDetails,
    'is_labour' : isLabour,
    'distance' : distance,
    'amount' : amount,
    'extended_amount' : extendedAmount,
    'status' : status,
    'biding' : biding,
    'biding_expired_at' : bidingExpiredAt,
    'is_cancel' : isCancel,
    'cancelreason_id' : cancelreasonId,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'dropoff_locations' : dropoffLocations?.map((e) => e.toJson()).toList(),
    'trip_bids' : tripBids?.map((e) => e.toJson()).toList()
  };
}

class DropoffLocations {
  final int? id;
  final int? tripId;
  final String? dropoffLocation;
  final String? dropoffMap;
  final int? status;
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
        tripId = json['trip_id'] as int?,
        dropoffLocation = json['dropoff_location'] as String?,
        dropoffMap = json['dropoff_map'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'trip_id' : tripId,
    'dropoff_location' : dropoffLocation,
    'dropoff_map' : dropoffMap,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class TripBids {
  final int? id;
  final int? tripId;
  final int? customerId;
  final int? partnerId;
  final int? vehicleCategory;
  final int? vehicleId;
  final int? carId;
  final String? amount;
  final int? extraPrice;
  final int? platformCharge;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final Getvehicle? getvehicle;
  final Getpartner? getpartner;
  final GetBrand? getBrand;

  TripBids({
    this.id,
    this.tripId,
    this.customerId,
    this.partnerId,
    this.vehicleCategory,
    this.vehicleId,
    this.carId,
    this.amount,
    this.extraPrice,
    this.platformCharge,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.getvehicle,
    this.getpartner,
    this.getBrand,
  });

  TripBids.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        tripId = json['trip_id'] as int?,
        customerId = json['customer_id'] as int?,
        partnerId = json['partner_id'] as int?,
        vehicleCategory = json['vehicle_category'] as int?,
        vehicleId = json['vehicle_id'] as int?,
        carId = json['car_id'] as int?,
        amount = json['amount'] as String?,
        extraPrice = json['extra_price'] as int?,
        platformCharge = json['platform_charge'] as int?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        getvehicle = (json['getvehicle'] as Map<String,dynamic>?) != null ? Getvehicle.fromJson(json['getvehicle'] as Map<String,dynamic>) : null,
        getpartner = (json['getpartner'] as Map<String,dynamic>?) != null ? Getpartner.fromJson(json['getpartner'] as Map<String,dynamic>) : null,
        getBrand = (json['get_brand'] as Map<String,dynamic>?) != null ? GetBrand.fromJson(json['get_brand'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'trip_id' : tripId,
    'customer_id' : customerId,
    'partner_id' : partnerId,
    'vehicle_category' : vehicleCategory,
    'vehicle_id' : vehicleId,
    'car_id' : carId,
    'amount' : amount,
    'extra_price' : extraPrice,
    'platform_charge' : platformCharge,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'getvehicle' : getvehicle?.toJson(),
    'getpartner' : getpartner?.toJson(),
    'get_brand' : getBrand?.toJson()
  };
}

class Getvehicle {
  final int? id;
  final int? partnerId;
  final int? vehicleCategory;
  final int? brand;
  final int? sizecategoryId;
  final String? truckType;
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
  final dynamic vehicleRootPic;
  final dynamic vehicleFitnessPic;
  final dynamic vehicleTaxPic;
  final dynamic vehicleInsurancePic;
  final String? vehicleDrivingFront;
  final String? vehicleDrivingBack;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Getvehicle({
    this.id,
    this.partnerId,
    this.vehicleCategory,
    this.brand,
    this.sizecategoryId,
    this.truckType,
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

  Getvehicle.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        partnerId = json['partner_id'] as int?,
        vehicleCategory = json['vehicle_category'] as int?,
        brand = json['brand'] as int?,
        sizecategoryId = json['sizecategory_id'] as int?,
        truckType = json['truck_type'] as String?,
        metro = json['metro'] as String?,
        metroType = json['metro_type'] as int?,
        metroNo = json['metro_no'] as String?,
        model = json['model'] as String?,
        modelYear = json['model_year'] as String?,
        vehicleColor = json['vehicle_color'] as String?,
        aircondition = json['aircondition'] as String?,
        brandName = json['brand_name'] as String?,
        fuelType = json['fuel_type'] as String?,
        vehicleFrontPic = json['vehicle_front_pic'] as String?,
        vehicleBackPic = json['vehicle_back_pic'] as String?,
        vehiclePlateNo = json['vehicle_plate_no'] as String?,
        vehicleRegPic = json['vehicle_reg_pic'] as String?,
        vehicleRootPic = json['vehicle_root_pic'],
        vehicleFitnessPic = json['vehicle_fitness_pic'],
        vehicleTaxPic = json['vehicle_tax_pic'],
        vehicleInsurancePic = json['vehicle_insurance_pic'],
        vehicleDrivingFront = json['vehicle_driving_front'] as String?,
        vehicleDrivingBack = json['vehicle_driving_back'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'partner_id' : partnerId,
    'vehicle_category' : vehicleCategory,
    'brand' : brand,
    'sizecategory_id' : sizecategoryId,
    'truck_type' : truckType,
    'metro' : metro,
    'metro_type' : metroType,
    'metro_no' : metroNo,
    'model' : model,
    'model_year' : modelYear,
    'vehicle_color' : vehicleColor,
    'aircondition' : aircondition,
    'brand_name' : brandName,
    'fuel_type' : fuelType,
    'vehicle_front_pic' : vehicleFrontPic,
    'vehicle_back_pic' : vehicleBackPic,
    'vehicle_plate_no' : vehiclePlateNo,
    'vehicle_reg_pic' : vehicleRegPic,
    'vehicle_root_pic' : vehicleRootPic,
    'vehicle_fitness_pic' : vehicleFitnessPic,
    'vehicle_tax_pic' : vehicleTaxPic,
    'vehicle_insurance_pic' : vehicleInsurancePic,
    'vehicle_driving_front' : vehicleDrivingFront,
    'vehicle_driving_back' : vehicleDrivingBack,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class Getpartner {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? image;
  final int? categoryId;
  final dynamic sizecategoryId;
  final dynamic vehicleId;
  final dynamic truckType;
  final String? docType;
  final String? docNumber;
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
  final dynamic forgotCode;
  final int? credit;
  final int? debit;
  final String? deviceToken;
  final int? packageId;
  final int? packageStatus;
  final String? enableDate;
  final String? expireDate;
  final String? currentMap;
  final int? cancelButton;
  final int? cancelCount;
  final dynamic suspendExpiredAt;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Getpartner({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.categoryId,
    this.sizecategoryId,
    this.vehicleId,
    this.truckType,
    this.docType,
    this.docNumber,
    this.docFront,
    this.docBack,
    this.drivingLicenseFront,
    this.drivingLicenseBack,
    this.divisionId,
    this.districtId,
    this.thanaId,
    this.address,
    this.gender,
    this.referCode,
    this.myreferKey,
    this.verify,
    this.forgotCode,
    this.credit,
    this.debit,
    this.deviceToken,
    this.packageId,
    this.packageStatus,
    this.enableDate,
    this.expireDate,
    this.currentMap,
    this.cancelButton,
    this.cancelCount,
    this.suspendExpiredAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Getpartner.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        phone = json['phone'] as String?,
        email = json['email'] as String?,
        image = json['image'] as String?,
        categoryId = json['category_id'] as int?,
        sizecategoryId = json['sizecategory_id'],
        vehicleId = json['vehicle_id'],
        truckType = json['truck_type'],
        docType = json['doc_type'] as String?,
        docNumber = json['doc_number'] as String?,
        docFront = json['doc_front'],
        docBack = json['doc_back'],
        drivingLicenseFront = json['driving_license_front'] as String?,
        drivingLicenseBack = json['driving_license_back'] as String?,
        divisionId = json['division_id'] as int?,
        districtId = json['district_id'] as int?,
        thanaId = json['thana_id'] as int?,
        address = json['address'] as String?,
        gender = json['gender'] as String?,
        referCode = json['refer_code'],
        myreferKey = json['myrefer_key'] as String?,
        verify = json['verify'] as String?,
        forgotCode = json['forgot_code'],
        credit = json['credit'] as int?,
        debit = json['debit'] as int?,
        deviceToken = json['device_token'] as String?,
        packageId = json['package_id'] as int?,
        packageStatus = json['package_status'] as int?,
        enableDate = json['enable_date'] as String?,
        expireDate = json['expire_date'] as String?,
        currentMap = json['current_map'] as String?,
        cancelButton = json['cancel_button'] as int?,
        cancelCount = json['cancel_count'] as int?,
        suspendExpiredAt = json['suspend_expired_at'],
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'phone' : phone,
    'email' : email,
    'image' : image,
    'category_id' : categoryId,
    'sizecategory_id' : sizecategoryId,
    'vehicle_id' : vehicleId,
    'truck_type' : truckType,
    'doc_type' : docType,
    'doc_number' : docNumber,
    'doc_front' : docFront,
    'doc_back' : docBack,
    'driving_license_front' : drivingLicenseFront,
    'driving_license_back' : drivingLicenseBack,
    'division_id' : divisionId,
    'district_id' : districtId,
    'thana_id' : thanaId,
    'address' : address,
    'gender' : gender,
    'refer_code' : referCode,
    'myrefer_key' : myreferKey,
    'verify' : verify,
    'forgot_code' : forgotCode,
    'credit' : credit,
    'debit' : debit,
    'device_token' : deviceToken,
    'package_id' : packageId,
    'package_status' : packageStatus,
    'enable_date' : enableDate,
    'expire_date' : expireDate,
    'current_map' : currentMap,
    'cancel_button' : cancelButton,
    'cancel_count' : cancelCount,
    'suspend_expired_at' : suspendExpiredAt,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class GetBrand {
  final int? id;
  final int? vehicleCategory;
  final int? sizecategoryId;
  final String? truckType;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? image;
  final String? description;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  GetBrand({
    this.id,
    this.vehicleCategory,
    this.sizecategoryId,
    this.truckType,
    this.name,
    this.nameBn,
    this.slug,
    this.capacity,
    this.image,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  GetBrand.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        vehicleCategory = json['vehicle_category'] as int?,
        sizecategoryId = json['sizecategory_id'] as int?,
        truckType = json['truck_type'] as String?,
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        slug = json['slug'] as String?,
        capacity = json['capacity'] as String?,
        image = json['image'] as String?,
        description = json['description'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'vehicle_category' : vehicleCategory,
    'sizecategory_id' : sizecategoryId,
    'truck_type' : truckType,
    'name' : name,
    'name_bn' : nameBn,
    'slug' : slug,
    'capacity' : capacity,
    'image' : image,
    'description' : description,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}