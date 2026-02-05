class Suggestion {
  final String description;
  final String placeId;

  Suggestion({
    required this.description,
    required this.placeId,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}