class BariKoiMapModel {
  List<Places>? places;
  int? status;

  BariKoiMapModel({this.places, this.status});

  BariKoiMapModel.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      places = <Places>[];
      json['places'].forEach((v) {
        places!.add(Places.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (places != null) {
      data['places'] = places!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Places {
  int? id;
  String? longitude;
  String? latitude;
  String? address;
  String? city;
  String? area;
  int? postCode;
  String? pType;
  String? subType;
  String? district;
  String? uCode;

  Places(
      {this.id,
      this.longitude,
      this.latitude,
      this.address,
      this.city,
      this.area,
      this.postCode,
      this.pType,
      this.subType,
      this.district,
      this.uCode});

  Places.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    city = json['city'];
    area = json['area'];
    postCode = json['postCode'];
    pType = json['pType'];
    subType = json['subType'];
    district = json['district'];
    uCode = json['uCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['address'] = address;
    data['city'] = city;
    data['area'] = area;
    data['postCode'] = postCode;
    data['pType'] = pType;
    data['subType'] = subType;
    data['district'] = district;
    data['uCode'] = uCode;
    return data;
  }
}
