import 'package:pickup_load_update/src/models/live_bidding_model.dart';

class TripStatusModel {
  TripStatusModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  factory TripStatusModel.fromJson(Map<String, dynamic> json){
    return TripStatusModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.tripId,
    required this.remainingSeconds,
    required this.remainingMinutes,
    required this.isExpired,
  });

  final int? tripId;
  final int? remainingSeconds;
  final int? remainingMinutes;
  final String? isExpired;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      tripId:parseInt( json["trip_id"]),
      remainingSeconds: parseInt(json["remaining_seconds"]),
      remainingMinutes: parseInt(json["remaining_minutes"]),
      isExpired: parseString(json["is_expired"]),
    );
  }

}
