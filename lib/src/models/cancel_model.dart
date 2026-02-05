class CancelModel {
  final String? status;
  final String? message;
  final int? count;
  final int? partnerCount;
  final int? customerCount;
  final int? customerBeforeCount;
  final int? customerAfterCount;
  final List<Data>? data;
  final List<PartnerData>? partnerData;
  final List<CustomerData>? customerData;
  final List<CustomerBoforeData>? customerBoforeData;
  final List<CustomerAfterData>? customerAfterData;

  CancelModel({
    this.status,
    this.message,
    this.count,
    this.partnerCount,
    this.customerCount,
    this.customerBeforeCount,
    this.customerAfterCount,
    this.data,
    this.partnerData,
    this.customerData,
    this.customerBoforeData,
    this.customerAfterData,
  });

  CancelModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        count = json['count'] as int?,
        partnerCount = json['partnerCount'] as int?,
        customerCount = json['customerCount'] as int?,
        customerBeforeCount = json['customerBeforeCount'] as int?,
        customerAfterCount = json['customerAfterCount'] as int?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList(),
        partnerData = (json['partnerData'] as List?)?.map((dynamic e) => PartnerData.fromJson(e as Map<String,dynamic>)).toList(),
        customerData = (json['customerData'] as List?)?.map((dynamic e) => CustomerData.fromJson(e as Map<String,dynamic>)).toList(),
        customerBoforeData = (json['customerBoforeData'] as List?)?.map((dynamic e) => CustomerBoforeData.fromJson(e as Map<String,dynamic>)).toList(),
        customerAfterData = (json['customerAfterData'] as List?)?.map((dynamic e) => CustomerAfterData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'count' : count,
    'partnerCount' : partnerCount,
    'customerCount' : customerCount,
    'customerBeforeCount' : customerBeforeCount,
    'customerAfterCount' : customerAfterCount,
    'data' : data?.map((e) => e.toJson()).toList(),
    'partnerData' : partnerData?.map((e) => e.toJson()).toList(),
    'customerData' : customerData?.map((e) => e.toJson()).toList(),
    'customerBoforeData' : customerBoforeData?.map((e) => e.toJson()).toList(),
    'customerAfterData' : customerAfterData?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final String? type;
  final String? action;
  final String? title;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.type,
    this.action,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        type = json['type'] as String?,
        action = json['action'] as String?,
        title = json['title'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'action' : action,
    'title' : title,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class PartnerData {
  final int? id;
  final String? type;
  final String? action;
  final String? title;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  PartnerData({
    this.id,
    this.type,
    this.action,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  PartnerData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        type = json['type'] as String?,
        action = json['action'] as String?,
        title = json['title'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'action' : action,
    'title' : title,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class CustomerData {
  final int? id;
  final String? type;
  final String? action;
  final String? title;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  CustomerData({
    this.id,
    this.type,
    this.action,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CustomerData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        type = json['type'] as String?,
        action = json['action'] as String?,
        title = json['title'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'action' : action,
    'title' : title,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class CustomerBoforeData {
  final int? id;
  final String? type;
  final String? action;
  final String? title;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  CustomerBoforeData({
    this.id,
    this.type,
    this.action,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CustomerBoforeData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        type = json['type'] as String?,
        action = json['action'] as String?,
        title = json['title'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'action' : action,
    'title' : title,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class CustomerAfterData {
  final int? id;
  final String? type;
  final String? action;
  final String? title;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  CustomerAfterData({
    this.id,
    this.type,
    this.action,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CustomerAfterData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        type = json['type'] as String?,
        action = json['action'] as String?,
        title = json['title'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'action' : action,
    'title' : title,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}