class GuideLinesModel {
  GuideLinesModel({
      this.status,
      this.data,
  });

  final String? status;
  final GuideData? data;

  factory GuideLinesModel.fromJson(Map<String, dynamic> json){
    return GuideLinesModel(
      status: json["status"],
      data: json["data"] == null ? null : GuideData.fromJson(json["data"]),
    );
  }

}

class GuideData {
  GuideData({
      this.guide,
      this.faqs,
  });

  final Guide? guide;
  final List<Faq>? faqs;

  factory GuideData.fromJson(Map<String, dynamic> json){
    return GuideData(
      guide: json["guide"] == null ? null : Guide.fromJson(json["guide"]),
      faqs: json["faqs"] == null ? [] : List<Faq>.from(json["faqs"]!.map((x) => Faq.fromJson(x))),
    );
  }

}

class Faq {
  Faq({
      this.id,
      this.question,
      this.answer,
      this.createdAt,
      this.updatedAt,
  });

  final int? id;
  final String? question;
  final String? answer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Faq.fromJson(Map<String, dynamic> json){
    return Faq(
      id: json["id"],
      question: json["question"],
      answer: json["answer"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Guide {
  Guide({
      this.id,
      this.helpline,
      this.email,
      this.rentalVideoLink,
      this.returnVideoLink,
      this.emergencyHelpline,
      this.visitUs,
      this.privacyPolicy,
      this.terms,
      this.createdAt,
      this.updatedAt,
  });

  final int? id;
  final String? helpline;
  final String? email;
  final String? rentalVideoLink;
  final String? returnVideoLink;
  final String? emergencyHelpline;
  final String? visitUs;
  final String? privacyPolicy;
  final String? terms;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Guide.fromJson(Map<String, dynamic> json){
    return Guide(
      id: json["id"],
      helpline: json["helpline"],
      email: json["email"],
      rentalVideoLink: json["rental_video_link"],
      returnVideoLink: json["return_video_link"],
      emergencyHelpline: json["emergency_helpline"],
      visitUs: json["visit_us"],
      privacyPolicy: json["privacy_policy"],
      terms: json["terms"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
