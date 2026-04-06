class LiveTermsModel {
    LiveTermsModel({
         this.status,
         this.data,
    });

    final String? status;
    final Data? data;

    factory LiveTermsModel.fromJson(Map<String, dynamic> json){ 
        return LiveTermsModel(
            status: json["status"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.id,
        required this.terms,
        required this.labourcharge,
        required this.waitingcharge,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? terms;
    final String? labourcharge;
    final String? waitingcharge;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            terms: json["terms"],
            labourcharge: json["labourcharge"],
            waitingcharge: json["waitingcharge"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
