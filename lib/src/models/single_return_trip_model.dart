class SingleReturnTripDetailsModelNew {
  final String? status;
  final Data? data;

  SingleReturnTripDetailsModelNew({this.status, this.data});

  SingleReturnTripDetailsModelNew.fromJson(Map<String, dynamic> json)
    : status = json['status'] as String?,
      data = (json['data'] as Map<String, dynamic>?) != null
          ? Data.fromJson(json['data'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}

/// safe converter
String? _toStr(dynamic v) => v?.toString();

class Data {
  final TripHistory? tripHistory;
  final Partner? partner;
  final Driver? driver;
  final Vehicle? vehicle;

  Data({this.tripHistory, this.partner, this.driver, this.vehicle});

  Data.fromJson(Map<String, dynamic> json)
    : tripHistory = (json['trip_history'] as Map<String, dynamic>?) != null
          ? TripHistory.fromJson(json['trip_history'] as Map<String, dynamic>)
          : null,
      partner = (json['partner'] as Map<String, dynamic>?) != null
          ? Partner.fromJson(json['partner'] as Map<String, dynamic>)
          : null,
      driver = (json['driver'] as Map<String, dynamic>?) != null
          ? Driver.fromJson(json['driver'] as Map<String, dynamic>)
          : null,
      vehicle = (json['vehicle'] as Map<String, dynamic>?) != null
          ? Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {
    'trip_history': tripHistory?.toJson(),
    'partner': partner?.toJson(),
    'driver': driver?.toJson(),
    'vehicle': vehicle?.toJson(),
  };
}

class TripHistory {
  final int? id;

  final PickupDivision? pickupDivision;
  final DropoffDivision? dropoffDivision;

  final String? location;
  final String? destination;
  final String? amount;
  final String? timedate;
  final String? partnerId;
  final String? vehicleCategory;
  final String? vehicleId;
  final String? biding;
  final String? trackingId;
  final String? assignedVehicleId;
  final String? assignedDriverId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  final Category? category;
  final Getvehicle? getvehicle;
  final Getpartner? getpartner;
  final GetDriver? getDriver;
  final GetCar? getCar;
  final List<BidLists>? bidLists;
  final List<DropoffLocations>? dropoffLocations;

  TripHistory({
    this.id,
    this.pickupDivision,
    this.dropoffDivision,
    this.location,
    this.destination,
    this.amount,
    this.timedate,
    this.partnerId,
    this.vehicleCategory,
    this.vehicleId,
    this.biding,
    this.trackingId,
    this.assignedVehicleId,
    this.assignedDriverId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.getvehicle,
    this.getpartner,
    this.getDriver,
    this.getCar,
    this.bidLists,
    this.dropoffLocations,
  });

  TripHistory.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      pickupDivision = json['pickup_division'] != null
          ? PickupDivision.fromJson(json['pickup_division'])
          : null,
      dropoffDivision = json['dropoff_division'] != null
          ? DropoffDivision.fromJson(json['dropoff_division'])
          : null,
      location = _toStr(json['location']),
      destination = _toStr(json['destination']),
      amount = _toStr(json['amount']),
      timedate = _toStr(json['timedate']),
      partnerId = _toStr(json['partner_id']),
      vehicleCategory = _toStr(json['vehicle_category']),
      vehicleId = _toStr(json['vehicle_id']),
      biding = _toStr(json['biding']),
      trackingId = _toStr(json['tracking_id']),
      assignedVehicleId = _toStr(json['assigned_vehicle_id']),
      assignedDriverId = _toStr(json['assigned_driver_id']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']),
      category = json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      getvehicle = json['getvehicle'] != null
          ? Getvehicle.fromJson(json['getvehicle'])
          : null,
      getpartner = json['getpartner'] != null
          ? Getpartner.fromJson(json['getpartner'])
          : null,
      getDriver = json['get_driver'] != null
          ? GetDriver.fromJson(json['get_driver'])
          : null,
      getCar = json['get_car'] != null
          ? GetCar.fromJson(json['get_car'])
          : null,
      bidLists = (json['bid_lists'] as List?)
          ?.map((e) => BidLists.fromJson(e))
          .toList(),
      dropoffLocations = (json['dropoff_locations'] as List?)
          ?.map((e) => DropoffLocations.fromJson(e))
          .toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'pickup_division': pickupDivision?.toJson(),
    'dropoff_division': dropoffDivision?.toJson(),
    'location': location,
    'destination': destination,
    'amount': amount,
    'timedate': timedate,
    'partner_id': partnerId,
    'vehicle_category': vehicleCategory,
    'vehicle_id': vehicleId,
    'biding': biding,
    'tracking_id': trackingId,
    'assigned_vehicle_id': assignedVehicleId,
    'assigned_driver_id': assignedDriverId,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'category': category?.toJson(),
    'getvehicle': getvehicle?.toJson(),
    'getpartner': getpartner?.toJson(),
    'get_driver': getDriver?.toJson(),
    'get_car': getCar?.toJson(),
    'bid_lists': bidLists?.map((e) => e.toJson()).toList(),
    'dropoff_locations': dropoffLocations?.map((e) => e.toJson()).toList(),
  };
}

class PickupDivision {
  final int? id;

  final String? name;
  final String? nameBn;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  PickupDivision({
    this.id,
    this.name,
    this.nameBn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  PickupDivision.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = _toStr(json['name']),
      nameBn = _toStr(json['name_bn']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_bn': nameBn,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class DropoffDivision {
  final int? id;

  final String? name;
  final String? nameBn;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  DropoffDivision({
    this.id,
    this.name,
    this.nameBn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  /// safe converter

  DropoffDivision.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = _toStr(json['name']),
      nameBn = _toStr(json['name_bn']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_bn': nameBn,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Category {
  final int? id;

  final String? name;
  final String? nameBn;
  final String? slug;
  final String? image;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Category({
    this.id,
    this.name,
    this.nameBn,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = _toStr(json['name']),
      nameBn = _toStr(json['name_bn']),
      slug = _toStr(json['slug']),
      image = _toStr(json['image']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_bn': nameBn,
    'slug': slug,
    'image': image,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Getvehicle {
  final int? id;

  final String? vehicleCategory;
  final String? sizecategoryId;
  final String? truckType;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? image;
  final String? description;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Getvehicle({
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

  Getvehicle.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      vehicleCategory = _toStr(json['vehicle_category']),
      sizecategoryId = _toStr(json['sizecategory_id']),
      truckType = _toStr(json['truck_type']),
      name = _toStr(json['name']),
      nameBn = _toStr(json['name_bn']),
      slug = _toStr(json['slug']),
      capacity = _toStr(json['capacity']),
      image = _toStr(json['image']),
      description = _toStr(json['description']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'vehicle_category': vehicleCategory,
    'sizecategory_id': sizecategoryId,
    'truck_type': truckType,
    'name': name,
    'name_bn': nameBn,
    'slug': slug,
    'capacity': capacity,
    'image': image,
    'description': description,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Getpartner {
  final int? id;

  final String? name;
  final String? phone;
  final String? email;
  final String? image;
  final String? categoryId;
  final String? sizecategoryId;
  final String? vehicleId;
  final String? truckType;
  final String? docType;
  final String? docNumber;
  final String? docFront;
  final String? docBack;
  final String? drivingLicenseFront;
  final String? drivingLicenseBack;
  final String? divisionId;
  final String? districtId;
  final String? thanaId;
  final String? address;
  final String? gender;
  final String? referCode;
  final String? myreferKey;
  final String? verify;
  final String? forgotCode;
  final String? credit;
  final String? debit;
  final String? deviceToken;
  final String? packageId;
  final String? packageStatus;
  final String? enableDate;
  final String? expireDate;
  final String? currentMap;
  final String? cancelButton;
  final String? cancelCount;
  final String? suspendExpiredAt;
  final String? status;
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
      name = _toStr(json['name']),
      phone = _toStr(json['phone']),
      email = _toStr(json['email']),
      image = _toStr(json['image']),
      categoryId = _toStr(json['category_id']),
      sizecategoryId = _toStr(json['sizecategory_id']),
      vehicleId = _toStr(json['vehicle_id']),
      truckType = _toStr(json['truck_type']),
      docType = _toStr(json['doc_type']),
      docNumber = _toStr(json['doc_number']),
      docFront = _toStr(json['doc_front']),
      docBack = _toStr(json['doc_back']),
      drivingLicenseFront = _toStr(json['driving_license_front']),
      drivingLicenseBack = _toStr(json['driving_license_back']),
      divisionId = _toStr(json['division_id']),
      districtId = _toStr(json['district_id']),
      thanaId = _toStr(json['thana_id']),
      address = _toStr(json['address']),
      gender = _toStr(json['gender']),
      referCode = _toStr(json['refer_code']),
      myreferKey = _toStr(json['myrefer_key']),
      verify = _toStr(json['verify']),
      forgotCode = _toStr(json['forgot_code']),
      credit = _toStr(json['credit']),
      debit = _toStr(json['debit']),
      deviceToken = _toStr(json['device_token']),
      packageId = _toStr(json['package_id']),
      packageStatus = _toStr(json['package_status']),
      enableDate = _toStr(json['enable_date']),
      expireDate = _toStr(json['expire_date']),
      currentMap = _toStr(json['current_map']),
      cancelButton = _toStr(json['cancel_button']),
      cancelCount = _toStr(json['cancel_count']),
      suspendExpiredAt = _toStr(json['suspend_expired_at']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'image': image,
    'category_id': categoryId,
    'sizecategory_id': sizecategoryId,
    'vehicle_id': vehicleId,
    'truck_type': truckType,
    'doc_type': docType,
    'doc_number': docNumber,
    'doc_front': docFront,
    'doc_back': docBack,
    'driving_license_front': drivingLicenseFront,
    'driving_license_back': drivingLicenseBack,
    'division_id': divisionId,
    'district_id': districtId,
    'thana_id': thanaId,
    'address': address,
    'gender': gender,
    'refer_code': referCode,
    'myrefer_key': myreferKey,
    'verify': verify,
    'forgot_code': forgotCode,
    'credit': credit,
    'debit': debit,
    'device_token': deviceToken,
    'package_id': packageId,
    'package_status': packageStatus,
    'enable_date': enableDate,
    'expire_date': expireDate,
    'current_map': currentMap,
    'cancel_button': cancelButton,
    'cancel_count': cancelCount,
    'suspend_expired_at': suspendExpiredAt,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class GetDriver {
  final int? id;

  final String? partnerId;
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
  final String? createdAt;
  final String? updatedAt;

  GetDriver({
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

  GetDriver.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partnerId = _toStr(json['partner_id']),
      name = _toStr(json['name']),
      phone = _toStr(json['phone']),
      contactNo = _toStr(json['contact_no']),
      email = _toStr(json['email']),
      gender = _toStr(json['gender']),
      address = _toStr(json['address']),
      drivingNo = _toStr(json['driving_no']),
      drivingImage = _toStr(json['driving_image']),
      nidFront = _toStr(json['nid_front']),
      nidBack = _toStr(json['nid_back']),
      image = _toStr(json['image']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'partner_id': partnerId,
    'name': name,
    'phone': phone,
    'contact_no': contactNo,
    'email': email,
    'gender': gender,
    'address': address,
    'driving_no': drivingNo,
    'driving_image': drivingImage,
    'nid_front': nidFront,
    'nid_back': nidBack,
    'image': image,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class GetCar {
  final int? id;

  final String? partnerId;
  final String? vehicleCategory;
  final String? brand;
  final String? sizecategoryId;
  final String? truckType;
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
  final String? vehiclePlateNo;
  final String? vehicleRegPic;
  final String? vehicleRootPic;
  final String? vehicleFitnessPic;
  final String? vehicleTaxPic;
  final String? vehicleInsurancePic;
  final String? vehicleDrivingFront;
  final String? vehicleDrivingBack;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  GetCar({
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

  GetCar.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partnerId = _toStr(json['partner_id']),
      vehicleCategory = _toStr(json['vehicle_category']),
      brand = _toStr(json['brand']),
      sizecategoryId = _toStr(json['sizecategory_id']),
      truckType = _toStr(json['truck_type']),
      metro = _toStr(json['metro']),
      metroType = _toStr(json['metro_type']),
      metroNo = _toStr(json['metro_no']),
      model = _toStr(json['model']),
      modelYear = _toStr(json['model_year']),
      vehicleColor = _toStr(json['vehicle_color']),
      aircondition = _toStr(json['aircondition']),
      brandName = _toStr(json['brand_name']),
      fuelType = _toStr(json['fuel_type']),
      vehicleFrontPic = _toStr(json['vehicle_front_pic']),
      vehicleBackPic = _toStr(json['vehicle_back_pic']),
      vehiclePlateNo = _toStr(json['vehicle_plate_no']),
      vehicleRegPic = _toStr(json['vehicle_reg_pic']),
      vehicleRootPic = _toStr(json['vehicle_root_pic']),
      vehicleFitnessPic = _toStr(json['vehicle_fitness_pic']),
      vehicleTaxPic = _toStr(json['vehicle_tax_pic']),
      vehicleInsurancePic = _toStr(json['vehicle_insurance_pic']),
      vehicleDrivingFront = _toStr(json['vehicle_driving_front']),
      vehicleDrivingBack = _toStr(json['vehicle_driving_back']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'partner_id': partnerId,
    'vehicle_category': vehicleCategory,
    'brand': brand,
    'sizecategory_id': sizecategoryId,
    'truck_type': truckType,
    'metro': metro,
    'metro_type': metroType,
    'metro_no': metroNo,
    'model': model,
    'model_year': modelYear,
    'vehicle_color': vehicleColor,
    'aircondition': aircondition,
    'brand_name': brandName,
    'fuel_type': fuelType,
    'vehicle_front_pic': vehicleFrontPic,
    'vehicle_back_pic': vehicleBackPic,
    'vehicle_plate_no': vehiclePlateNo,
    'vehicle_reg_pic': vehicleRegPic,
    'vehicle_root_pic': vehicleRootPic,
    'vehicle_fitness_pic': vehicleFitnessPic,
    'vehicle_tax_pic': vehicleTaxPic,
    'vehicle_insurance_pic': vehicleInsurancePic,
    'vehicle_driving_front': vehicleDrivingFront,
    'vehicle_driving_back': vehicleDrivingBack,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class BidLists {
  final int? id;

  final String? partnerTripId;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String? map;
  final String? dropoffMap;
  final String? price;
  final String? customerId;
  final String? returnTripId;
  final String? partnerId;
  final String? note;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Customer? customer;

  BidLists({
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
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  BidLists.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partnerTripId = _toStr(json['partner_trip_id']),
      pickupLocation = _toStr(json['pickup_location']),
      dropoffLocation = _toStr(json['dropoff_location']),
      map = _toStr(json['map']),
      dropoffMap = _toStr(json['dropoff_map']),
      price = _toStr(json['price']),
      customerId = _toStr(json['customer_id']),
      returnTripId = _toStr(json['return_trip_id']),
      partnerId = _toStr(json['partner_id']),
      note = _toStr(json['note']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']),
      customer = (json['customer'] as Map<String, dynamic>?) != null
          ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'partner_trip_id': partnerTripId,
    'pickup_location': pickupLocation,
    'dropoff_location': dropoffLocation,
    'map': map,
    'dropoff_map': dropoffMap,
    'price': price,
    'customer_id': customerId,
    'return_trip_id': returnTripId,
    'partner_id': partnerId,
    'note': note,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'customer': customer?.toJson(),
  };
}

class Customer {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? birthday;
  final String? gender;
  final String? district;
  final String? address;
  final String? image;
  final String? verify;
  final String? expireAt;
  final dynamic forgotCode;
  final String? cancelCount;
  final dynamic suspendExpiredAt;
  final String? status;
  final String? deviceToken;
  final String? createdAt;
  final String? updatedAt;

  Customer({
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
    this.cancelCount,
    this.suspendExpiredAt,
    this.status,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
  });

  Customer.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = _toStr(json['name']),
      phone = _toStr(json['phone']),
      email = _toStr(json['email']),
      birthday = _toStr(json['birthday']),
      gender = _toStr(json['gender']),
      district = _toStr(json['district']),
      address = _toStr(json['address']),
      image = _toStr(json['image']),
      verify = _toStr(json['verify']),
      expireAt = _toStr(json['expire_at']),
      forgotCode = json['forgot_code'],
      cancelCount = _toStr(json['cancel_count']),
      suspendExpiredAt = json['suspend_expired_at'],
      status = _toStr(json['status']),
      deviceToken = _toStr(json['device_token']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'birthday': birthday,
    'gender': gender,
    'district': district,
    'address': address,
    'image': image,
    'verify': verify,
    'expire_at': expireAt,
    'forgot_code': forgotCode,
    'cancel_count': cancelCount,
    'suspend_expired_at': suspendExpiredAt,
    'status': status,
    'device_token': deviceToken,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class DropoffLocations {
  final int? id; // main ID stays int
  final String? bidId;
  final String? tripId;
  final String? dropoffLocation;
  final String? dropoffMap;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  DropoffLocations({
    this.id,
    this.bidId,
    this.tripId,
    this.dropoffLocation,
    this.dropoffMap,
    this.status,
    this.createdAt,
    this.updatedAt,
  });


  DropoffLocations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        bidId = _toStr(json['bid_id']),
        tripId = _toStr(json['trip_id']),
        dropoffLocation = _toStr(json['dropoff_location']),
        dropoffMap = _toStr(json['dropoff_map']),
        status = _toStr(json['status']),
        createdAt = _toStr(json['created_at']),
        updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'bid_id': bidId,
    'trip_id': tripId,
    'dropoff_location': dropoffLocation,
    'dropoff_map': dropoffMap,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}


class Partner {
  final int? id; // main ID stays int
  final String? name;
  final String? phone;
  final String? email;
  final String? image;
  final String? categoryId;
  final String? sizecategoryId;
  final String? vehicleId;
  final String? truckType;
  final String? docType;
  final String? docNumber;
  final String? docFront;
  final String? docBack;
  final String? drivingLicenseFront;
  final String? drivingLicenseBack;
  final String? divisionId;
  final String? districtId;
  final String? thanaId;
  final String? address;
  final String? gender;
  final String? referCode;
  final String? myreferKey;
  final String? verify;
  final String? forgotCode;
  final String? credit;
  final String? debit;
  final String? deviceToken;
  final String? packageId;
  final String? packageStatus;
  final String? enableDate;
  final String? expireDate;
  final String? currentMap;
  final String? cancelButton;
  final String? cancelCount;
  final String? suspendExpiredAt;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Partner({
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



  Partner.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = _toStr(json['name']),
        phone = _toStr(json['phone']),
        email = _toStr(json['email']),
        image = _toStr(json['image']),
        categoryId = _toStr(json['category_id']),
        sizecategoryId = _toStr(json['sizecategory_id']),
        vehicleId = _toStr(json['vehicle_id']),
        truckType = _toStr(json['truck_type']),
        docType = _toStr(json['doc_type']),
        docNumber = _toStr(json['doc_number']),
        docFront = _toStr(json['doc_front']),
        docBack = _toStr(json['doc_back']),
        drivingLicenseFront = _toStr(json['driving_license_front']),
        drivingLicenseBack = _toStr(json['driving_license_back']),
        divisionId = _toStr(json['division_id']),
        districtId = _toStr(json['district_id']),
        thanaId = _toStr(json['thana_id']),
        address = _toStr(json['address']),
        gender = _toStr(json['gender']),
        referCode = _toStr(json['refer_code']),
        myreferKey = _toStr(json['myrefer_key']),
        verify = _toStr(json['verify']),
        forgotCode = _toStr(json['forgot_code']),
        credit = _toStr(json['credit']),
        debit = _toStr(json['debit']),
        deviceToken = _toStr(json['device_token']),
        packageId = _toStr(json['package_id']),
        packageStatus = _toStr(json['package_status']),
        enableDate = _toStr(json['enable_date']),
        expireDate = _toStr(json['expire_date']),
        currentMap = _toStr(json['current_map']),
        cancelButton = _toStr(json['cancel_button']),
        cancelCount = _toStr(json['cancel_count']),
        suspendExpiredAt = _toStr(json['suspend_expired_at']),
        status = _toStr(json['status']),
        createdAt = _toStr(json['created_at']),
        updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'image': image,
    'category_id': categoryId,
    'sizecategory_id': sizecategoryId,
    'vehicle_id': vehicleId,
    'truck_type': truckType,
    'doc_type': docType,
    'doc_number': docNumber,
    'doc_front': docFront,
    'doc_back': docBack,
    'driving_license_front': drivingLicenseFront,
    'driving_license_back': drivingLicenseBack,
    'division_id': divisionId,
    'district_id': districtId,
    'thana_id': thanaId,
    'address': address,
    'gender': gender,
    'refer_code': referCode,
    'myrefer_key': myreferKey,
    'verify': verify,
    'forgot_code': forgotCode,
    'credit': credit,
    'debit': debit,
    'device_token': deviceToken,
    'package_id': packageId,
    'package_status': packageStatus,
    'enable_date': enableDate,
    'expire_date': expireDate,
    'current_map': currentMap,
    'cancel_button': cancelButton,
    'cancel_count': cancelCount,
    'suspend_expired_at': suspendExpiredAt,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}


class Driver {
  final int? id;
  final String? partnerId;
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
  final String? createdAt;
  final String? updatedAt;

  Driver({
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



  Driver.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partnerId = _toStr(json['partner_id']),
      name = _toStr(json['name']),
      phone = _toStr(json['phone']),
      contactNo = _toStr(json['contact_no']),
      email = _toStr(json['email']),
      gender = _toStr(json['gender']),
      address = _toStr(json['address']),
      drivingNo = _toStr(json['driving_no']),
      drivingImage = _toStr(json['driving_image']),
      nidFront = _toStr(json['nid_front']),
      nidBack = _toStr(json['nid_back']),
      image = _toStr(json['image']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'partner_id': partnerId,
    'name': name,
    'phone': phone,
    'contact_no': contactNo,
    'email': email,
    'gender': gender,
    'address': address,
    'driving_no': drivingNo,
    'driving_image': drivingImage,
    'nid_front': nidFront,
    'nid_back': nidBack,
    'image': image,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Vehicle {
  final int? id; // main ID remains int
  final String? partnerId;
  final String? vehicleCategory;
  final String? brand;
  final String? sizecategoryId;
  final String? truckType;
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
  final String? vehiclePlateNo;
  final String? vehicleRegPic;
  final String? vehicleRootPic;
  final String? vehicleFitnessPic;
  final String? vehicleTaxPic;
  final String? vehicleInsurancePic;
  final String? vehicleDrivingFront;
  final String? vehicleDrivingBack;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Vehicle({
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


  Vehicle.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partnerId = _toStr(json['partner_id']),
      vehicleCategory = _toStr(json['vehicle_category']),
      brand = _toStr(json['brand']),
      sizecategoryId = _toStr(json['sizecategory_id']),
      truckType = _toStr(json['truck_type']),
      metro = _toStr(json['metro']),
      metroType = _toStr(json['metro_type']),
      metroNo = _toStr(json['metro_no']),
      model = _toStr(json['model']),
      modelYear = _toStr(json['model_year']),
      vehicleColor = _toStr(json['vehicle_color']),
      aircondition = _toStr(json['aircondition']),
      brandName = _toStr(json['brand_name']),
      fuelType = _toStr(json['fuel_type']),
      vehicleFrontPic = _toStr(json['vehicle_front_pic']),
      vehicleBackPic = _toStr(json['vehicle_back_pic']),
      vehiclePlateNo = _toStr(json['vehicle_plate_no']),
      vehicleRegPic = _toStr(json['vehicle_reg_pic']),
      vehicleRootPic = _toStr(json['vehicle_root_pic']),
      vehicleFitnessPic = _toStr(json['vehicle_fitness_pic']),
      vehicleTaxPic = _toStr(json['vehicle_tax_pic']),
      vehicleInsurancePic = _toStr(json['vehicle_insurance_pic']),
      vehicleDrivingFront = _toStr(json['vehicle_driving_front']),
      vehicleDrivingBack = _toStr(json['vehicle_driving_back']),
      status = _toStr(json['status']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'partner_id': partnerId,
    'vehicle_category': vehicleCategory,
    'brand': brand,
    'sizecategory_id': sizecategoryId,
    'truck_type': truckType,
    'metro': metro,
    'metro_type': metroType,
    'metro_no': metroNo,
    'model': model,
    'model_year': modelYear,
    'vehicle_color': vehicleColor,
    'aircondition': aircondition,
    'brand_name': brandName,
    'fuel_type': fuelType,
    'vehicle_front_pic': vehicleFrontPic,
    'vehicle_back_pic': vehicleBackPic,
    'vehicle_plate_no': vehiclePlateNo,
    'vehicle_reg_pic': vehicleRegPic,
    'vehicle_root_pic': vehicleRootPic,
    'vehicle_fitness_pic': vehicleFitnessPic,
    'vehicle_tax_pic': vehicleTaxPic,
    'vehicle_insurance_pic': vehicleInsurancePic,
    'vehicle_driving_front': vehicleDrivingFront,
    'vehicle_driving_back': vehicleDrivingBack,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
