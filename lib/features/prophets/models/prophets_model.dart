class ProphetsModel {
  final String name;
  final String meaning;
  final String details;
  final String url;

  ProphetsModel({
    required this.name,
    required this.meaning,
    required this.details,
    required this.url,
  });

  factory ProphetsModel.fromJson(Map<String, dynamic> json) {
    return ProphetsModel(
      name: json['name'],
      meaning: json['meaning'],
      details: json['details'],
      url: json['url'],
    );
  }
}
