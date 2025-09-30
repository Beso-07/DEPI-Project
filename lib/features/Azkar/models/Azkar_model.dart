import 'dart:convert';

Azkar azkarFromJson(String str) => Azkar.fromJson(json.decode(str));

String azkarToJson(Azkar data) => json.encode(data.toJson());

class Azkar {
  final List<Zekr> morningAzkar;
  final List<Zekr> eveningAzkar;
  final List<Zekr> afterPrayerAzkar;
  final List<Zekr> tasbeeh;
  final List<Zekr> sleepAzkar;
  final List<Zekr> wakeUpAzkar;
  final List<Zekr> quranicDua;
  final List<Zekr> prophetsDua;

  Azkar({
    required this.morningAzkar,
    required this.eveningAzkar,
    required this.afterPrayerAzkar,
    required this.tasbeeh,
    required this.sleepAzkar,
    required this.wakeUpAzkar,
    required this.quranicDua,
    required this.prophetsDua,
  });

  factory Azkar.fromJson(Map<String, dynamic> json) => Azkar(
        morningAzkar:
            List<Zekr>.from(json["أذكار الصباح"].map((x) => Zekr.fromJson(x))),
        eveningAzkar:
            List<Zekr>.from(json["أذكار المساء"].map((x) => Zekr.fromJson(x))),
        afterPrayerAzkar: List<Zekr>.from(
            json["أذكار بعد السلام من الصلاة المفروضة"]
                .map((x) => Zekr.fromJson(x))),
        tasbeeh: List<Zekr>.from(json["تسابيح"].map((x) => Zekr.fromJson(x))),
        sleepAzkar:
            List<Zekr>.from(json["أذكار النوم"].map((x) => Zekr.fromJson(x))),
        wakeUpAzkar: List<Zekr>.from(
            json["أذكار الاستيقاظ"].map((x) => Zekr.fromJson(x))),
        quranicDua:
            List<Zekr>.from(json["أدعية قرآنية"].map((x) => Zekr.fromJson(x))),
        prophetsDua: List<Zekr>.from(
            json["أدعية الأنبياء"].map((x) => Zekr.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "أذكار الصباح": List<dynamic>.from(morningAzkar.map((x) => x.toJson())),
        "أذكار المساء": List<dynamic>.from(eveningAzkar.map((x) => x.toJson())),
        "أذكار بعد السلام من الصلاة المفروضة":
            List<dynamic>.from(afterPrayerAzkar.map((x) => x.toJson())),
        "تسابيح": List<dynamic>.from(tasbeeh.map((x) => x.toJson())),
        "أذكار النوم": List<dynamic>.from(sleepAzkar.map((x) => x.toJson())),
        "أذكار الاستيقاظ":
            List<dynamic>.from(wakeUpAzkar.map((x) => x.toJson())),
        "أدعية قرآنية": List<dynamic>.from(quranicDua.map((x) => x.toJson())),
        "أدعية الأنبياء":
            List<dynamic>.from(prophetsDua.map((x) => x.toJson())),
      };
}

class Zekr {
  final String? category;
  final String? count;
  final String? description;
  final String? reference;
  final String? content;

  Zekr({
    this.category,
    this.count,
    this.description,
    this.reference,
    this.content,
  });

  factory Zekr.fromJson(Map<String, dynamic> json) => Zekr(
        category: json["category"],
        count: json["count"],
        description: json["description"],
        reference: json["reference"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "count": count,
        "description": description,
        "reference": reference,
        "content": content,
      };
}
