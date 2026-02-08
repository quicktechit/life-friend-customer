class CustomerProfileModel {
  final String? status;
  final CustomerDatas? data;

  CustomerProfileModel({
    this.status,
    this.data,
  });

  CustomerProfileModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? CustomerDatas.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'data' : data?.toJson()
  };
}

class CustomerDatas {
  final int? id;
  final dynamic name;
  final String? phone;
  final dynamic email;
  final dynamic birthday;
  final dynamic gender;
  final dynamic district;
  final dynamic address;
  final dynamic image;
  final String? verify;
  final String? expireAt;
  final dynamic forgotCode;
  final String? cancelCount;
  final String? cancelButton;
  final dynamic suspendExpiredAt;
  final String? status;
  final String? deviceToken;
  final String? createdAt;
  final String? updatedAt;

  CustomerDatas({
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
    this.cancelButton,
    this.suspendExpiredAt,
    this.status,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
  });

  CustomerDatas.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'],
        phone = json['phone'] as String?,
        email = json['email'],
        birthday = json['birthday'],
        gender = json['gender'],
        district = json['district'],
        address = json['address'],
        image = json['image'],
        verify = json['verify'] as String?,
        expireAt = json['expire_at'] as String?,
        forgotCode = json['forgot_code'],
        cancelCount = json['cancel_count'].toString(),
        cancelButton = json['cancel_button'] .toString(),
        suspendExpiredAt = json['suspend_expired_at'],
        status = json['status'].toString(),
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
    'cancel_button' : cancelButton,
    'suspend_expired_at' : suspendExpiredAt,
    'status' : status,
    'device_token' : deviceToken,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}