import 'package:hive/hive.dart';

part 'azkar_model.g.dart';

@HiveType(typeId: 0)
class Zekr extends HiveObject {
  @HiveField(0)
  final String zekr;

  @HiveField(1)
  final int count;

  Zekr({required this.zekr, required this.count});

  factory Zekr.fromJson(Map<String, dynamic> json) =>
      Zekr(zekr: json['zekr'], count: json['count']);
}

class AzkarModel {
  final List<Zekr> morning;
  final List<Zekr> evening;
  final List<Zekr> sleep;
  final List<Zekr> wakeUp;
  final List<Zekr> afterPrayer;
  final List<Zekr> quranicDua;
  final List<Zekr> prophetsDua;

  AzkarModel({
    required this.morning,
    required this.evening,
    required this.sleep,
    required this.wakeUp,
    required this.afterPrayer,
    required this.quranicDua,
    required this.prophetsDua,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    List<Zekr> parseList(List data) =>
        data.map((e) => Zekr.fromJson(e)).toList();

    return AzkarModel(
      morning: parseList(json['morning']),
      evening: parseList(json['evening']),
      sleep: parseList(json['sleep']),
      wakeUp: parseList(json['wakeUp']),
      afterPrayer: parseList(json['afterPrayer']),
      quranicDua: parseList(json['quranicDua']),
      prophetsDua: parseList(json['prophetsDua']),
    );
  }
}
