class SingleTripDetailsModel {
  final String? status;
  final Data? data;

  SingleTripDetailsModel({
    this.status,
    this.data,
  });

  SingleTripDetailsModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'data' : data?.toJson()
  };
}

class Data {
  final TripHistory? tripHistory;
  final Partner? partner;
  final Driver? driver;

  Data({
    this.tripHistory,
    this.partner,
    this.driver,
  });

  Data.fromJson(Map<String, dynamic> json)
      : tripHistory = (json['trip_history'] as Map<String,dynamic>?) != null ? TripHistory.fromJson(json['trip_history'] as Map<String,dynamic>) : null,
        partner = json['partner'] != null
            ? Partner.fromJson(json['partner'] as Map<String, dynamic>)
            : null,
        driver = (json['driver'] as Map<String, dynamic>?) != null
            ? Driver.fromJson(json['driver'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
    'trip_history' : tripHistory?.toJson(),
        'partner': partner?.toJson(),
        'driver': driver?.toJson()
      };
}

class TripHistory {
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
  final int? otp;
  final int? partnerId;
  final int? assignedDriverId;
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

  TripHistory.fromJson(Map<String, dynamic> json)
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
        otp = json['otp'] as int?,
        partnerId = json['partner_id'] as int?,
        assignedDriverId = json['assigned_driver_id'] as int?,
        dropoffLocations = (json['dropoff_locations'] as List?)?.map((dynamic e) => DropoffLocations.fromJson(e as Map<String,dynamic>)).toList(),
        vehicle = (json['vehicle'] as Map<String,dynamic>?) != null ? Vehicle.fromJson(json['vehicle'] as Map<String,dynamic>) : null;

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
    'otp' : otp,
    'partner_id' : partnerId,
    'assigned_driver_id' : assignedDriverId,
    'dropoff_locations' : dropoffLocations?.map((e) => e.toJson()).toList(),
    'vehicle' : vehicle?.toJson()
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

class Vehicle {
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
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class Partner {
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
  final String? docFront;
  final String? docBack;
  final dynamic drivingLicenseFront;
  final dynamic drivingLicenseBack;
  final int? divisionId;
  final dynamic districtId;
  final dynamic thanaId;
  final String? address;
  final String? gender;
  final dynamic referCode;
  final String? myreferKey;
  final String? verify;
  final String? forgotCode;
  final int? credit;
  final int? debit;
  final dynamic deviceToken;
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
        docFront = json['doc_front'] as String?,
        docBack = json['doc_back'] as String?,
        drivingLicenseFront = json['driving_license_front'],
        drivingLicenseBack = json['driving_license_back'],
        divisionId = json['division_id'] as int?,
        districtId = json['district_id'],
        thanaId = json['thana_id'],
        address = json['address'] as String?,
        gender = json['gender'] as String?,
        referCode = json['refer_code'],
        myreferKey = json['myrefer_key'] as String?,
        verify = json['verify'] as String?,
        forgotCode = json['forgot_code'] as String?,
        credit = json['credit'] as int?,
        debit = json['debit'] as int?,
        deviceToken = json['device_token'],
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
        'updated_at': updatedAt
      };
}

class Driver {
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
        partnerId = json['partner_id'] as int?,
        name = json['name'] as String?,
        phone = json['phone'] as String?,
        contactNo = json['contact_no'] as String?,
        email = json['email'] as String?,
        gender = json['gender'] as String?,
        address = json['address'] as String?,
        drivingNo = json['driving_no'] as String?,
        drivingImage = json['driving_image'] as String?,
        nidFront = json['nid_front'] as String?,
        nidBack = json['nid_back'] as String?,
        image = json['image'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

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
        'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}