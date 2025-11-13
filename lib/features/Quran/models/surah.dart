class Surah {
  final int id;                    
  final String name;              
  final String transliteration;    
  final String type;              
  final int totalVerses;          

  const Surah({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.type,
    required this.totalVerses,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'] as int,
      name: json['name'] as String,
      transliteration: json['transliteration'] as String,
      type: json['type'] as String,
      totalVerses: json['totalVerses'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'transliteration': transliteration,
      'type': type,
      'totalVerses': totalVerses,
      
    };
  }

  bool get isMeccan => type == 'مكية';

  bool get isMedinan => type == 'مدنية';

  bool get hasBasmalah => id != 9;

  @override
  String toString() {
    return 'Surah{id: $id, name: $name, transliteration: $transliteration, type: $type, totalVerses: $totalVerses}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Surah &&
        other.id == id &&
        other.name == name &&
        other.transliteration == transliteration &&
        other.type == type &&
        other.totalVerses == totalVerses;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        transliteration.hashCode ^
        type.hashCode ^
        totalVerses.hashCode;
  }
}