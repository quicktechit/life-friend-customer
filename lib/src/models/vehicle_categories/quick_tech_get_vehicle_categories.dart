class QuickTechGetVehicleCategories {
  QuickTechGetVehicleCategories({
     this.status,
     this.data,
  });

  final String? status;
  final List<Datum>? data;

  factory QuickTechGetVehicleCategories.fromJson(Map<String, dynamic> json){
    return QuickTechGetVehicleCategories(
      status: json["status"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.vehicleCategory,
    required this.sizecategoryId,
    required this.truckType,
    required this.name,
    required this.nameBn,
    required this.slug,
    required this.capacity,
    required this.biddingTime,
    required this.blockTime,
    required this.scheduleDay,
    required this.lowValue,
    required this.highValue,
    required this.bookingPercentage,
    required this.image,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicleQuestions,
  });

  final int? id;
  final String? vehicleCategory;
  final dynamic sizecategoryId;
  final dynamic truckType;
  final String? name;
  final String? nameBn;
  final String? slug;
  final String? capacity;
  final String? biddingTime;
  final String? blockTime;
  final String? scheduleDay;
  final String? lowValue;
  final String? highValue;
  final String? bookingPercentage;
  final String? image;
  final String? description;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<VehicleQuestion> vehicleQuestions;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      vehicleCategory: json["vehicle_category"],
      sizecategoryId: json["sizecategory_id"],
      truckType: json["truck_type"],
      name: json["name"],
      nameBn: json["name_bn"],
      slug: json["slug"],
      capacity: json["capacity"],
      biddingTime: json["bidding_time"],
      blockTime: json["block_time"],
      scheduleDay: json["schedule_day"],
      lowValue: json["low_value"],
      highValue: json["high_value"],
      bookingPercentage: json["booking_percentage"],
      image: json["image"],
      description: json["description"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      vehicleQuestions: json["vehicle_questions"] == null ? [] : List<VehicleQuestion>.from(json["vehicle_questions"]!.map((x) => VehicleQuestion.fromJson(x))),
    );
  }

}

class VehicleQuestion {
  VehicleQuestion({
    required this.id,
    required this.vehicleId,
    required this.question,
    required this.options,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? vehicleId;
  final String? question;
  final List<String> options;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory VehicleQuestion.fromJson(Map<String, dynamic> json){
    return VehicleQuestion(
      id: json["id"],
      vehicleId: json["vehicle_id"],
      question: json["question"],
      options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
