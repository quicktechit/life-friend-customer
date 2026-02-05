class RentalHistory {
  final String? status;
  final List<Data>? data;

  RentalHistory({
    this.status,
    this.data,
  });

  RentalHistory.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
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
  final dynamic amount;
  final int? extendedAmount;
  final int? status;
  final int? biding;
  final String? bidingExpiredAt;
  final int? isCancel;
  final dynamic cancelreasonId;
  final String? createdAt;
  final String? updatedAt;
  final List<DropoffLocations>? dropoffLocations;
  final Vehicle? vehicle;

  Data({
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
    this.vehicle,
  });

  Data.fromJson(Map<String, dynamic> json)
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
        amount = json['amount'],
        extendedAmount = json['extended_amount'] as int?,
        status = json['status'] as int?,
        biding = json['biding'] as int?,
        bidingExpiredAt = json['biding_expired_at'] as String?,
        isCancel = json['is_cancel'] as int?,
        cancelreasonId = json['cancelreason_id'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
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
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}