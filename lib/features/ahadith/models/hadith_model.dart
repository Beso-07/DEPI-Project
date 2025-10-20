import 'package:hive/hive.dart';
part 'hadith_model.g.dart';

@HiveType(typeId: 1)
class Hadith {
  @HiveField(0)
  final String hadithContent;
  @HiveField(1)
  final int id;
  Hadith({required this.hadithContent, required this.id});
  factory Hadith.fromJson(Map<String, dynamic> json) =>
      Hadith(hadithContent: json['hadith'], id: json['id']);
}

class HadithModel {
  final List<Hadith> ahmad;
  final List<Hadith> bukari;
  final List<Hadith> muslim;
  final List<Hadith> tirmidhi;
  final List<Hadith> elnasaee;
  final List<Hadith> abudawood;

  HadithModel({
    required this.ahmad,
    required this.bukari,
    required this.muslim,
    required this.tirmidhi,
    required this.elnasaee,
    required this.abudawood,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    List<Hadith> parseList(List data) =>
        data.map((e) => Hadith.fromJson(e)).toList();

    return HadithModel(
      ahmad: parseList(json['ahmad']),
      bukari: parseList(json['bukhari']),
      muslim: parseList(json['muslim']),
      tirmidhi: parseList(json['tirmidhi']),
      elnasaee: parseList(json['elnasaee']),
      abudawood: parseList(json['abudawood']),
    );
  }
}
