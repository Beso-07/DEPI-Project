class AsmaulhusnaModel {
  final int id;
  final String name;
  final String text;

  AsmaulhusnaModel({required this.id, required this.name, required this.text});

  factory AsmaulhusnaModel.fromJson(Map<String, dynamic> json) {
    return AsmaulhusnaModel(
      id: json['id'],
      name: json['name'],
      text: json['text'],
    );
  }
}
