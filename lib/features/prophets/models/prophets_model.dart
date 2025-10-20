class ProphetsModel {
  final String name;
  final String meaning;
  final String details;

  ProphetsModel({
    required this.name,
    required this.meaning,
    required this.details,
  });

  factory ProphetsModel.fromJson(Map<String, dynamic> json) {
    return ProphetsModel(
      name: json['name'],
      meaning: json['meaning'],
      details: json['details'],
    );
  }
}
