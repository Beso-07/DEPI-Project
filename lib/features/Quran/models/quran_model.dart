import 'package:hive/hive.dart';

part 'quran_model.g.dart'; // 👈 ده السطر اللي بيولّد الملف التلقائي

@HiveType(typeId: 2) // 👈 رقم مختلف عن الأذكار والأحاديث
class Surah extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? transliteration;

  @HiveField(3)
  String? type;

  @HiveField(4)
  int? totalVerses;

  @HiveField(5)
  int? pageStart;

  @HiveField(6)
  int? pageEnd;

  @HiveField(7)
  List<Verse>? verses;

  Surah({
    this.id,
    this.name,
    this.transliteration,
    this.type,
    this.totalVerses,
    this.pageStart,
    this.pageEnd,
    this.verses,
  });

  Surah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    transliteration = json['transliteration'];
    type = json['type'];
    totalVerses = json['totalVerses'];
    pageStart = json['pageStart'];
    pageEnd = json['pageEnd'];
    if (json['verses'] != null) {
      verses = <Verse>[];
      json['verses'].forEach((v) {
        verses!.add(Verse.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 3)
class Verse extends HiveObject {
  @HiveField(0)
  int? chapter;

  @HiveField(1)
  int? verse;

  @HiveField(2)
  String? text;

  Verse({this.chapter, this.verse, this.text});

  Verse.fromJson(Map<String, dynamic> json) {
    chapter = json['chapter'];
    verse = json['verse'];
    text = json['text'];
  }
}
