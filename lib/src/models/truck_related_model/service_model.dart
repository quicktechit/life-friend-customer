class ServiceModel {
  final String? status;
  final String? message;
  final List<Dataa>? data;

  ServiceModel({
    this.status,
    this.message,
    this.data,
  });

  ServiceModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Dataa.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Dataa {
  final int? id;
  final int? vehicleId;
  final String? name;
  final String? nameBn;
  final int? fees;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Dataa({
    this.id,
    this.vehicleId,
    this.name,
    this.nameBn,
    this.status,
    this.fees,
    this.createdAt,
    this.updatedAt,
  });

  Dataa.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        vehicleId = json['vehicle_id'] as int?,
        name = json['name'] as String?,
        nameBn = json['name_bn'] as String?,
        status = json['status'] as int?,
        fees = json['fees'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'vehicle_id' : vehicleId,
    'name' : name,
    'name_bn' : nameBn,
    'status' : status,
    'fees' : fees,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}