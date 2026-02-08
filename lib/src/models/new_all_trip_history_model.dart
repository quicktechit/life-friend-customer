class NewAllTripHistoryModel {
  final String? status;
  final String? message;
  final List<SortedTrips>? sortedTrips;

  NewAllTripHistoryModel({this.status, this.message, this.sortedTrips});

  NewAllTripHistoryModel.fromJson(Map<String, dynamic> json)
    : status = json['status'] as String?,
      message = json['message'] as String?,
      sortedTrips = (json['sorted_trips'] as List?)
          ?.map((dynamic e) => SortedTrips.fromJson(e as Map<String, dynamic>))
          .toList();

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'sorted_trips': sortedTrips?.map((e) => e.toJson()).toList(),
  };
}

class SortedTrips {
  final int? id;

  final String? tripId;
  final String? bidId;
  final String? vehicleCategory;
  final String? vehicleId;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String? partnerId;
  final String? customerId;
  final String? timedate;
  final String? amount;
  final String? otp;
  final String? trackingId;
  final String? status;
  final String? cancelType;
  final String? cancelledStatus;
  final String? cancelledBy;
  final String? cancelreasonId;
  final String? cancelCreatedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? source;

  final ReturnRelationships? returnRelationships;
  final RentalRelationships? rentalRelationships;

  SortedTrips({
    this.id,
    this.tripId,
    this.bidId,
    this.vehicleCategory,
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
    this.cancelType,
    this.cancelledStatus,
    this.cancelledBy,
    this.cancelreasonId,
    this.cancelCreatedAt,
    this.createdAt,
    this.updatedAt,
    this.source,
    this.returnRelationships,
    this.rentalRelationships,
  });

  /// SAFE parsing (handles int/double/null automatically)
  static String? _toStr(dynamic v) => v?.toString();

  SortedTrips.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      tripId = _toStr(json['trip_id']),
      bidId = _toStr(json['bid_id']),
      vehicleCategory = _toStr(json['vehicle_category']),
      vehicleId = _toStr(json['vehicle_id']),
      pickupLocation = _toStr(json['pickup_location']),
      dropoffLocation = _toStr(json['dropoff_location']),
      partnerId = _toStr(json['partner_id']),
      customerId = _toStr(json['customer_id']),
      timedate = _toStr(json['timedate']),
      amount = _toStr(json['amount']),
      otp = _toStr(json['otp']),
      trackingId = _toStr(json['tracking_id']),
      status = _toStr(json['status']),
      cancelType = _toStr(json['cancel_type']),
      cancelledStatus = _toStr(json['cancelled_status']),
      cancelledBy = _toStr(json['cancelled_by']),
      cancelreasonId = _toStr(json['cancelreason_id']),
      cancelCreatedAt = _toStr(json['cancel_created_at']),
      createdAt = _toStr(json['created_at']),
      updatedAt = _toStr(json['updated_at']),
      source = _toStr(json['source']),
      returnRelationships = json['return_relationships'] is Map<String, dynamic>
          ? ReturnRelationships.fromJson(
              json['return_relationships'] as Map<String, dynamic>,
            )
          : null,
      rentalRelationships = json['rental_relationships'] is Map<String, dynamic>
          ? RentalRelationships.fromJson(
              json['rental_relationships'] as Map<String, dynamic>,
            )
          : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'trip_id': tripId,
    'bid_id': bidId,
    'vehicle_category': vehicleCategory,
    'vehicle_id': vehicleId,
    'pickup_location': pickupLocation,
    'dropoff_location': dropoffLocation,
    'partner_id': partnerId,
    'customer_id': customerId,
    'timedate': timedate,
    'amount': amount,
    'otp': otp,
    'tracking_id': trackingId,
    'status': status,
    'cancel_type': cancelType,
    'cancelled_status': cancelledStatus,
    'cancelled_by': cancelledBy,
    'cancelreason_id': cancelreasonId,
    'cancel_created_at': cancelCreatedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'source': source,
    'return_relationships': returnRelationships?.toJson(),
    'rental_relationships': rentalRelationships?.toJson(),
  };
}

class ReturnRelationships {
  final ReturnPartner? returnPartner;
  final ReturnTrip? returnTrip;
  final ReturnDriver? returnDriver;
  final RetrunCategory? retrunCategory;
  final ReturnVehicle? returnVehicle;
  final CustomerBidDetails? customerBidDetails;

  ReturnRelationships({
    this.returnPartner,
    this.returnTrip,
    this.returnDriver,
    this.retrunCategory,
    this.returnVehicle,
    this.customerBidDetails,
  });

  ReturnRelationships.fromJson(Map<String, dynamic> json)
    : returnPartner = (json['return_partner'] as Map<String, dynamic>?) != null
          ? ReturnPartner.fromJson(
              json['return_partner'] as Map<String, dynamic>,
            )
          : null,
      returnTrip = (json['return_trip'] as Map<String, dynamic>?) != null
          ? ReturnTrip.fromJson(json['return_trip'] as Map<String, dynamic>)
          : null,
      returnDriver = (json['return_driver'] as Map<String, dynamic>?) != null
          ? ReturnDriver.fromJson(json['return_driver'] as Map<String, dynamic>)
          : null,
      retrunCategory =
          (json['retrun_category'] as Map<String, dynamic>?) != null
          ? RetrunCategory.fromJson(
              json['retrun_category'] as Map<String, dynamic>,
            )
          : null,
      returnVehicle = (json['return_vehicle'] as Map<String, dynamic>?) != null
          ? ReturnVehicle.fromJson(
              json['return_vehicle'] as Map<String, dynamic>,
            )
          : null,
      customerBidDetails =
          (json['customer_bid_details'] as Map<String, dynamic>?) != null
          ? CustomerBidDetails.fromJson(
              json['customer_bid_details'] as Map<String, dynamic>,
            )
          : null;

  Map<String, dynamic> toJson() => {
    'return_partner': returnPartner?.toJson(),
    'return_trip': returnTrip?.toJson(),
    'return_driver': returnDriver?.toJson(),
    'retrun_category': retrunCategory?.toJson(),
    'return_vehicle': returnVehicle?.toJson(),
  };
}

class CustomerBidDetails {
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

  const CustomerBidDetails({
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
  });

  /// ✅ static helper (safe for initializer)
  static String? _toStr(dynamic v) => v?.toString();

  CustomerBidDetails.fromJson(Map<String, dynamic> json)
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
      updatedAt = _toStr(json['updated_at']);

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
  };
}

class ReturnPartner {
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

  const ReturnPartner({
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

  /// ✅ static helper (required for initializer list)
  static String? _toStr(dynamic v) => v?.toString();

  ReturnPartner.fromJson(Map<String, dynamic> json)
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

class ReturnTrip {
  final int? id;

  final String? pickupDivision;
  final String? dropoffDivision;
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

  final GetDriver? getDriver;
  final List<DropoffLocations>? dropoffLocations;

  const ReturnTrip({
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
    this.getDriver,
    this.dropoffLocations,
  });

  /// ✅ static helper
  static String? _toStr(dynamic v) => v?.toString();

  ReturnTrip.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      pickupDivision = _toStr(json['pickup_division']),
      dropoffDivision = _toStr(json['dropoff_division']),
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
      getDriver = json['get_driver'] is Map<String, dynamic>
          ? GetDriver.fromJson(json['get_driver'])
          : null,
      dropoffLocations = (json['dropoff_locations'] as List?)
          ?.map((e) => DropoffLocations.fromJson(e))
          .toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'pickup_division': pickupDivision,
    'dropoff_division': dropoffDivision,
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
    'get_driver': getDriver?.toJson(),
    'dropoff_locations': dropoffLocations?.map((e) => e.toJson()).toList(),
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

  const GetDriver({
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

  /// ✅ static helper (initializer-safe)
  static String? _toStr(dynamic v) => v?.toString();

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

class ReturnDriver {
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

  ReturnDriver({
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

  ReturnDriver.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partnerId = json['partner_id'].toString(),
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
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class RetrunCategory {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? image;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  RetrunCategory({
    this.id,
    this.name,
    this.nameBn,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  RetrunCategory.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      nameBn = json['name_bn'] as String?,
      slug = json['slug'] as String?,
      image = json['image'] as String?,
      status = json['status'].toString(),
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

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

class ReturnVehicle {
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
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  ReturnVehicle({
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

  ReturnVehicle.fromJson(Map<String, dynamic> json)
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
      status = json['status'].toString(),
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

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

class RentalRelationships {
  final Partner? partner;
  final Vehicle? vehicle;
  final Category? category;
  final Trip? trip;

  RentalRelationships({this.partner, this.vehicle, this.category, this.trip});

  RentalRelationships.fromJson(Map<String, dynamic> json)
    : partner = (json['partner'] as Map<String, dynamic>?) != null
          ? Partner.fromJson(json['partner'] as Map<String, dynamic>)
          : null,
      vehicle = (json['vehicle'] as Map<String, dynamic>?) != null
          ? Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>)
          : null,
      category = (json['category'] as Map<String, dynamic>?) != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      trip = (json['trip'] as Map<String, dynamic>?) != null
          ? Trip.fromJson(json['trip'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {
    'partner': partner?.toJson(),
    'vehicle': vehicle?.toJson(),
    'category': category?.toJson(),
    'trip': trip?.toJson(),
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

  const Partner({
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

  /// ✅ static helper (initializer-safe)
  static String? _toStr(dynamic v) => v?.toString();

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

  const Vehicle({
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

  /// ✅ initializer-safe helper
  static String? _toStr(dynamic v) => v?.toString();

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
      name = json['name'] as String?,
      nameBn = json['name_bn'] as String?,
      slug = json['slug'] as String?,
      image = json['image'] as String?,
      status = json['status'].toString(),
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

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

class Trip {
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

  final List<DropoffLocations>? dropoffLocations;

  const Trip({
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
  });

  /// ✅ IMPORTANT: must be static for initializer list
  static String? _toStr(dynamic v) => v?.toString();

  Trip.fromJson(Map<String, dynamic> json)
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
      dropoffLocations = (json['dropoff_locations'] as List?)
          ?.map((e) => DropoffLocations.fromJson(e))
          .toList();

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
    'dropoff_locations': dropoffLocations?.map((e) => e.toJson()).toList(),
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
      tripId = json['trip_id'].toString(),
      dropoffLocation = json['dropoff_location'] as String?,
      dropoffMap = json['dropoff_map'] as String?,
      status = json['status'].toString(),
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

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
