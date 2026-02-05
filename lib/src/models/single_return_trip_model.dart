class SingleReturnTripDetailsModelNew {
  final String? status;
  final Data? data;

  SingleReturnTripDetailsModelNew({
    this.status,
    this.data,
  });

  SingleReturnTripDetailsModelNew.fromJson(Map<String, dynamic> json)
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
  final Vehicle? vehicle;

  Data({
    this.tripHistory,
    this.partner,
    this.driver,
    this.vehicle,
  });

  Data.fromJson(Map<String, dynamic> json)
      : tripHistory = (json['trip_history'] as Map<String,dynamic>?) != null ? TripHistory.fromJson(json['trip_history'] as Map<String,dynamic>) : null,
        partner = (json['partner'] as Map<String,dynamic>?) != null ? Partner.fromJson(json['partner'] as Map<String,dynamic>) : null,
        driver = (json['driver'] as Map<String,dynamic>?) != null ? Driver.fromJson(json['driver'] as Map<String,dynamic>) : null,
        vehicle = (json['vehicle'] as Map<String,dynamic>?) != null ? Vehicle.fromJson(json['vehicle'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'trip_history' : tripHistory?.toJson(),
    'partner' : partner?.toJson(),
    'driver' : driver?.toJson(),
    'vehicle' : vehicle?.toJson()
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
        pickupDivision = (json['pickup_division'] as Map<String,dynamic>?) != null ? PickupDivision.fromJson(json['pickup_division'] as Map<String,dynamic>) : null,
        dropoffDivision = (json['dropoff_division'] as Map<String,dynamic>?) != null ? DropoffDivision.fromJson(json['dropoff_division'] as Map<String,dynamic>) : null,
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
        category = (json['category'] as Map<String,dynamic>?) != null ? Category.fromJson(json['category'] as Map<String,dynamic>) : null,
        getvehicle = (json['getvehicle'] as Map<String,dynamic>?) != null ? Getvehicle.fromJson(json['getvehicle'] as Map<String,dynamic>) : null,
        getpartner = (json['getpartner'] as Map<String,dynamic>?) != null ? Getpartner.fromJson(json['getpartner'] as Map<String,dynamic>) : null,
        getDriver = (json['get_driver'] as Map<String,dynamic>?) != null ? GetDriver.fromJson(json['get_driver'] as Map<String,dynamic>) : null,
        getCar = (json['get_car'] as Map<String,dynamic>?) != null ? GetCar.fromJson(json['get_car'] as Map<String,dynamic>) : null,
        bidLists = (json['bid_lists'] as List?)?.map((dynamic e) => BidLists.fromJson(e as Map<String,dynamic>)).toList(),
        dropoffLocations = (json['dropoff_locations'] as List?)?.map((dynamic e) => DropoffLocations.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'pickup_division' : pickupDivision?.toJson(),
    'dropoff_division' : dropoffDivision?.toJson(),
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
    'category' : category?.toJson(),
    'getvehicle' : getvehicle?.toJson(),
    'getpartner' : getpartner?.toJson(),
    'get_driver' : getDriver?.toJson(),
    'get_car' : getCar?.toJson(),
    'bid_lists' : bidLists?.map((e) => e.toJson()).toList(),
    'dropoff_locations' : dropoffLocations?.map((e) => e.toJson()).toList()
  };
}

class PickupDivision {
  final int? id;
  final String? name;
  final String? nameBn;
  final int? status;
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
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_bn' : nameBn,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class DropoffDivision {
  final int? id;
  final String? name;
  final String? nameBn;
  final int? status;
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

  DropoffDivision.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'name_bn' : nameBn,
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

class Getvehicle {
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

class GetCar {
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

class BidLists {
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
        updatedAt = json['updated_at'] as String?,
        customer = (json['customer'] as Map<String,dynamic>?) != null ? Customer.fromJson(json['customer'] as Map<String,dynamic>) : null;

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
    'updated_at' : updatedAt,
    'customer' : customer?.toJson()
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
  final int? cancelCount;
  final dynamic suspendExpiredAt;
  final int? status;
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
        name = json['name'] as String?,
        phone = json['phone'] as String?,
        email = json['email'] as String?,
        birthday = json['birthday'] as String?,
        gender = json['gender'] as String?,
        district = json['district'] as String?,
        address = json['address'] as String?,
        image = json['image'] as String?,
        verify = json['verify'] as String?,
        expireAt = json['expire_at'] as String?,
        forgotCode = json['forgot_code'],
        cancelCount = json['cancel_count'] as int?,
        suspendExpiredAt = json['suspend_expired_at'],
        status = json['status'] as int?,
        deviceToken = json['device_token'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'phone' : phone,
    'email' : email,
    'birthday' : birthday,
    'gender' : gender,
    'district' : district,
    'address' : address,
    'image' : image,
    'verify' : verify,
    'expire_at' : expireAt,
    'forgot_code' : forgotCode,
    'cancel_count' : cancelCount,
    'suspend_expired_at' : suspendExpiredAt,
    'status' : status,
    'device_token' : deviceToken,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class DropoffLocations {
  final int? id;
  final int? bidId;
  final int? tripId;
  final String? dropoffLocation;
  final String? dropoffMap;
  final int? status;
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
        bidId = json['bid_id'] as int?,
        tripId = json['trip_id'] as int?,
        dropoffLocation = json['dropoff_location'] as String?,
        dropoffMap = json['dropoff_map'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'bid_id' : bidId,
    'trip_id' : tripId,
    'dropoff_location' : dropoffLocation,
    'dropoff_map' : dropoffMap,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
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

class Vehicle {
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