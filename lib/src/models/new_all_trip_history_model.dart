class NewAllTripHistoryModel {
  final String? status;
  final String? message;
  final List<SortedTrips>? sortedTrips;

  NewAllTripHistoryModel({
    this.status,
    this.message,
    this.sortedTrips,
  });

  NewAllTripHistoryModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        sortedTrips = (json['sorted_trips'] as List?)?.map((dynamic e) => SortedTrips.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'sorted_trips' : sortedTrips?.map((e) => e.toJson()).toList()
  };
}

class SortedTrips {
  final int? id;
  final int? tripId;
  final int? bidId;
  final int? vehicleCategory;
  final int? vehicleId;
  final String? pickupLocation;
  final dynamic dropoffLocation;
  final int? partnerId;
  final int? customerId;
  final String? timedate;
  final String? amount;
  final int? otp;
  final String? trackingId;
  final int? status;
  final dynamic cancelType;
  final dynamic cancelledStatus;
  final dynamic cancelledBy;
  final dynamic cancelreasonId;
  final dynamic cancelCreatedAt;
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

  SortedTrips.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        tripId = json['trip_id'] as int?,
        bidId = json['bid_id'] as int?,
        vehicleCategory = json['vehicle_category'] as int?,
        vehicleId = json['vehicle_id'] as int?,
        pickupLocation = json['pickup_location'] as String?,
        dropoffLocation = json['dropoff_location'],
        partnerId = json['partner_id'] as int?,
        customerId = json['customer_id'] as int?,
        timedate = json['timedate'] as String?,
        amount = json['amount'].toString(),
        otp = json['otp'] as int?,
        trackingId = json['tracking_id'] as String?,
        status = json['status'] as int?,
        cancelType = json['cancel_type'],
        cancelledStatus = json['cancelled_status'],
        cancelledBy = json['cancelled_by'],
        cancelreasonId = json['cancelreason_id'],
        cancelCreatedAt = json['cancel_created_at'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        source = json['source'] as String?,
        returnRelationships = json['return_relationships'] is Map<String, dynamic>
            ? ReturnRelationships.fromJson(json['return_relationships'] as Map<String, dynamic>)
            : null,
        rentalRelationships = json['rental_relationships'] is Map<String, dynamic>
            ? RentalRelationships.fromJson(json['rental_relationships'] as Map<String, dynamic>)
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
      : returnPartner = (json['return_partner'] as Map<String,dynamic>?) != null ? ReturnPartner.fromJson(json['return_partner'] as Map<String,dynamic>) : null,
        returnTrip = (json['return_trip'] as Map<String,dynamic>?) != null ? ReturnTrip.fromJson(json['return_trip'] as Map<String,dynamic>) : null,
        returnDriver = (json['return_driver'] as Map<String,dynamic>?) != null ? ReturnDriver.fromJson(json['return_driver'] as Map<String,dynamic>) : null,
        retrunCategory = (json['retrun_category'] as Map<String,dynamic>?) != null ? RetrunCategory.fromJson(json['retrun_category'] as Map<String,dynamic>) : null,
        returnVehicle =
            (json['return_vehicle'] as Map<String, dynamic>?) != null
                ? ReturnVehicle.fromJson(
                    json['return_vehicle'] as Map<String, dynamic>)
                : null,
        customerBidDetails =
            (json['customer_bid_details'] as Map<String, dynamic>?) != null
                ? CustomerBidDetails.fromJson(
                    json['customer_bid_details'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
    'return_partner' : returnPartner?.toJson(),
    'return_trip' : returnTrip?.toJson(),
    'return_driver' : returnDriver?.toJson(),
    'retrun_category' : retrunCategory?.toJson(),
    'return_vehicle' : returnVehicle?.toJson()
  };
}

class CustomerBidDetails {
  final int? id;
  final int? partnerTripId;
  final String? pickupLocation;
  final dynamic dropoffLocation;
  final String? map;
  final dynamic dropoffMap;
  final String? price;
  final int? customerId;
  final int? returnTripId;
  final int? partnerId;
  final String? note;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  CustomerBidDetails({
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

  CustomerBidDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        partnerTripId = json['partner_trip_id'] as int?,
        pickupLocation = json['pickup_location'] as String?,
        dropoffLocation = json['dropoff_location'],
        map = json['map'] as String?,
        dropoffMap = json['dropoff_map'],
        price = json['price'] as String?,
        customerId = json['customer_id'] as int?,
        returnTripId = json['return_trip_id'] as int?,
        partnerId = json['partner_id'] as int?,
        note = json['note'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'partner_trip_id' : partnerTripId,
    'pickup_location' : pickupLocation,
    'dropoff_location' : dropoffLocation,
    'map' : map,
    'dropoff_map' : dropoffMap,
    'price' : price,
    'customer_id' : customerId,
    'return_trip_id' : returnTripId,
    'partner_id' : partnerId,
    'note' : note,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class ReturnPartner {
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

  ReturnPartner({
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

  ReturnPartner.fromJson(Map<String, dynamic> json)
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

class ReturnTrip {
  final int? id;
  final int? pickupDivision;
  final int? dropoffDivision;
  final String? location;
  final String? destination;
  final String? amount;
  final String? timedate;
  final int? partnerId;
  final int? vehicleCategory;
  final int? vehicleId;
  final int? biding;
  final String? trackingId;
  final int? assignedVehicleId;
  final int? assignedDriverId;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final GetDriver? getDriver;
  final List<DropoffLocations>? dropoffLocations;

  ReturnTrip({
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

  ReturnTrip.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        pickupDivision = json['pickup_division'] as int?,
        dropoffDivision = json['dropoff_division'] as int?,
        location = json['location'] as String?,
        destination = json['destination'] as String?,
        amount = json['amount'] as String?,
        timedate = json['timedate'] as String?,
        partnerId = json['partner_id'] as int?,
        vehicleCategory = json['vehicle_category'] as int?,
        vehicleId = json['vehicle_id'] as int?,
        biding = json['biding'] as int?,
        trackingId = json['tracking_id'] as String?,
        assignedVehicleId = json['assigned_vehicle_id'] as int?,
        assignedDriverId = json['assigned_driver_id'] as int?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        getDriver = (json['get_driver'] as Map<String, dynamic>?) != null
            ? GetDriver.fromJson(json['get_driver'] as Map<String, dynamic>)
            : null,
        dropoffLocations = (json['dropoff_locations'] as List?)
            ?.map((dynamic e) =>
                DropoffLocations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'pickup_division' : pickupDivision,
    'dropoff_division' : dropoffDivision,
    'location' : location,
    'destination' : destination,
    'amount' : amount,
    'timedate' : timedate,
    'partner_id' : partnerId,
    'vehicle_category' : vehicleCategory,
    'vehicle_id' : vehicleId,
    'biding' : biding,
    'tracking_id' : trackingId,
    'assigned_vehicle_id' : assignedVehicleId,
    'assigned_driver_id' : assignedDriverId,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'get_driver' : getDriver?.toJson()
  };
}

class GetDriver {
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
    'id' : id,
    'partner_id' : partnerId,
    'name' : name,
    'phone' : phone,
    'contact_no' : contactNo,
    'email' : email,
    'gender' : gender,
    'address' : address,
    'driving_no' : drivingNo,
    'driving_image' : drivingImage,
    'nid_front' : nidFront,
    'nid_back' : nidBack,
    'image' : image,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class ReturnDriver {
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
    'id' : id,
    'partner_id' : partnerId,
    'name' : name,
    'phone' : phone,
    'contact_no' : contactNo,
    'email' : email,
    'gender' : gender,
    'address' : address,
    'driving_no' : drivingNo,
    'driving_image' : drivingImage,
    'nid_front' : nidFront,
    'nid_back' : nidBack,
    'image' : image,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class RetrunCategory {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? image;
  final int? status;
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
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_bn' : nameBn,
    'slug' : slug,
    'image' : image,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
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
  final int? status;
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

class RentalRelationships {
  final Partner? partner;
  final Vehicle? vehicle;
  final Category? category;
  final Trip? trip;

  RentalRelationships({
    this.partner,
    this.vehicle,
    this.category,
    this.trip,
  });

  RentalRelationships.fromJson(Map<String, dynamic> json)
      : partner = (json['partner'] as Map<String,dynamic>?) != null ? Partner.fromJson(json['partner'] as Map<String,dynamic>) : null,
        vehicle = (json['vehicle'] as Map<String,dynamic>?) != null ? Vehicle.fromJson(json['vehicle'] as Map<String,dynamic>) : null,
        category = (json['category'] as Map<String,dynamic>?) != null ? Category.fromJson(json['category'] as Map<String,dynamic>) : null,
        trip = (json['trip'] as Map<String,dynamic>?) != null ? Trip.fromJson(json['trip'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'partner' : partner?.toJson(),
    'vehicle' : vehicle?.toJson(),
    'category' : category?.toJson(),
    'trip' : trip?.toJson()
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
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class Category {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? image;
  final int? status;
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
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_bn' : nameBn,
    'slug' : slug,
    'image' : image,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class Trip {
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
  final String? productDetails;
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

  Trip({
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

  Trip.fromJson(Map<String, dynamic> json)
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
        productDetails = json['product_details'] as String?,
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
        dropoffLocations = (json['dropoff_locations'] as List?)?.map((dynamic e) => DropoffLocations.fromJson(e as Map<String,dynamic>)).toList();

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
    'dropoff_locations' : dropoffLocations?.map((e) => e.toJson()).toList()
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