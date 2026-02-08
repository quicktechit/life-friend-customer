class NotificationsModel {
  NotificationsModel({
    this.status,
    this.data,
  });

  final String? status;
  final List<NotificationData>? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<NotificationData>.from(
              json["data"]!.map((x) => NotificationData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.map((x) => x.toJson()).toList(),
      };
}

class NotificationData {
  NotificationData({
    this.id,
    this.customerId,
    this.doneBy,
    this.title,
    this.body,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? customerId;
  final dynamic doneBy;
  final String? title;
  final String? body;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json["id"],
      customerId: json["customer_id"].toString(),
      doneBy: json["done_by"],
      title: json["title"],
      body: json["body"],
      status: json["status"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "done_by": doneBy,
        "title": title,
        "body": body,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
