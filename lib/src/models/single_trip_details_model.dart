class SingleTripDetailsModel {
  final String? status;
  final Data? data;

  SingleTripDetailsModel({this.status, this.data});

  SingleTripDetailsModel.fromJson(Map<String, dynamic> json)
    : status = json['status'] as String?,
      data = (json['data'] as Map<String, dynamic>?) != null
          ? Data.fromJson(json['data'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}

String? _toStr(dynamic v) => v?.toString();

class Data {
  final TripHistory? tripHistory;
  final Partner? partner;
  final Driver? driver;

  Data({this.tripHistory, this.partner, this.driver});

  Data.fromJson(Map<String, dynamic> json)
    : tripHistory = (json['trip_history'] as Map<String, dynamic>?) != null
          ? TripHistory.fromJson(json['trip_history'] as Map<String, dynamic>)
          : null,
      partner = json['partner'] != null
          ? Partner.fromJson(json['partner'] as Map<String, dynamic>)
          : null,
      driver = (json['driver'] as Map<String, dynamic>?) != null
          ? Driver.fromJson(json['driver'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {
    'trip_history': tripHistory?.toJson(),
    'partner': partner?.toJson(),
    'driver': driver?.toJson(),
  };
}

class TripHistory {
  final int? id;

  final String? customerId;
  final String? categoryId;
  final String? sizecategoryId;
  final String? truckType;
  final String? vehicleId;
  final String? pickupLocation;
  final String? viaLocation;
  final String? dropoffLocation;
  final String? addressId;
  final String? isHourly;
  final String? hours;
  final String? map;
  final String? dropoffMap;
  final String? districtId;
  final String? portId;
  final String? datetime;
  final String? roundTrip;
  final String? promoKey;
  final String? roundDatetime;
  final String? note;
  final String? trackingId;
  final String? isAirport;
  final String? productType;
  final String? productDetails;
  final String? isLabour;
  final String? distance;
  final String? amount;
  final String? extendedAmount;
  final String? status;
  final String? biding;
  final String? bidingExpiredAt;
  final String? isCancel;
  final String? cancelreasonId;
  final String? createdAt;
  final String? updatedAt;
  final String? otp;
  final String? partnerId;
  final String? assignedDriverId;

  final List<DropoffLocations>? dropoffLocations;
  final Vehicle? vehicle;

  TripHistory({
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
    this.otp,
    this.partnerId,
    this.assignedDriverId,
    this.dropoffLocations,
    this.vehicle,
  });

  /// helper to safely convert any value -> String

  TripHistory.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      customerId = _toStr(json['customer_id']),
      categoryId = _toStr(json['category_id']),
      sizecategoryId = _toStr(json['sizecategory_id']),
      truckType = _toStr(json['truck_type']),
      vehicleId = _toStr(json['vehicle_id']),
      pickupLocation = _toStr(json['pickup_location']),
      viaLocation = _toStr(json['via_location']),
      dropoffLocation = _toStr(json['dropoff_location']),
      addressId = _toStr(json['address_id']),
      isHourly = _toStr(json['is_hourly']),
      hours = _toStr(json['hours']),
      map = _toStr(json['map']),
      dropoffMap = _toStr(json['dropoff_map']),
      districtId = _toStr(json['district_id']),
      portId = _toStr(json['port_id']),
      datetime = _toStr(json['datetime']),
      roundTrip = _toStr(json['round_trip']),
      promoKey = _toStr(json['promo_key']),
      roundDatetime = _toStr(json['round_datetime']),
      note = _toStr(json['note']),
      trackingId = _toStr(json['tracking_id']),
      isAirport = _toStr(json['is_airport']),
      productType = _toStr(json['product_type']),
      productDetails = _toStr(json['product_details']),
      isLabour = _toStr(json['is_labour']),
      distance = _toStr(json['distance']),
      amount = _toStr(json['amount']),
      extendedAmount = _toStr(json['extended_amount']),
      status = _toStr(json['status']),
      biding = _toStr(json['biding']),
      bidingExpiredAt = _toStr(json['biding_expired_at']),
      isCancel = _toStr(json['is_cancel']),
      cancelreasonId = _toStr(json['cancelreason_id']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']),
      otp = _toStr(json['otp']),
      partnerId = _toStr(json['partner_id']),
      assignedDriverId = _toStr(json['assigned_driver_id']),
      dropoffLocations = (json['dropoff_locations'] as List?)
          ?.map((e) => DropoffLocations.fromJson(e))
          .toList(),
      vehicle = json['vehicle'] != null
          ? Vehicle.fromJson(json['vehicle'])
          : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'customer_id': customerId,
    'category_id': categoryId,
    'sizecategory_id': sizecategoryId,
    'truck_type': truckType,
    'vehicle_id': vehicleId,
    'pickup_location': pickupLocation,
    'via_location': viaLocation,
    'dropoff_location': dropoffLocation,
    'address_id': addressId,
    'is_hourly': isHourly,
    'hours': hours,
    'map': map,
    'dropoff_map': dropoffMap,
    'district_id': districtId,
    'port_id': portId,
    'datetime': datetime,
    'round_trip': roundTrip,
    'promo_key': promoKey,
    'round_datetime': roundDatetime,
    'note': note,
    'tracking_id': trackingId,
    'is_airport': isAirport,
    'product_type': productType,
    'product_details': productDetails,
    'is_labour': isLabour,
    'distance': distance,
    'amount': amount,
    'extended_amount': extendedAmount,
    'status': status,
    'biding': biding,
    'biding_expired_at': bidingExpiredAt,
    'is_cancel': isCancel,
    'cancelreason_id': cancelreasonId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'otp': otp,
    'partner_id': partnerId,
    'assigned_driver_id': assignedDriverId,
    'dropoff_locations': dropoffLocations?.map((e) => e.toJson()).toList(),
    'vehicle': vehicle?.toJson(),
  };
}

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

class Vehicle {
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

  Vehicle({
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

  Vehicle.fromJson(Map<String, dynamic> json)
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

class Partner {
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
