import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const archivesBox = "archivesBox";
  static const azkarKey = "azkarKey";
  static const ahadithKey = "ahadithKey";
  static const quranKey = "quranKey";

  static List<Zekr> azkar = [];
  static List<Hadith> ahadith = [];
  static List quran = [];
  static late Box box;

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ZekrAdapter());
    }

    box = await Hive.openBox(archivesBox);
  }

  static Future<void> addAzkar(Zekr zekr) async {
    azkar.add(zekr);
    await box.put(azkarKey, azkar);
  }

  static Future<void> addAhadith(Hadith hadith) async {
    ahadith.add(hadith);
    await box.put(ahadithKey, ahadith);
  }

  static bool isAzkarSaved(Zekr zekr) {
    return azkar.any((z) => z.zekr == zekr.zekr && z.count == zekr.count);
  }

  static Future<void> toggleAzkar(Zekr zekr) async {
    if (isAzkarSaved(zekr)) {
      azkar.removeWhere((z) => z.zekr == zekr.zekr && z.count == zekr.count);
    } else {
      azkar.add(zekr);
    }
    await box.put(azkarKey, azkar);
  }

  static Future<void> getMyNotes() async {
    azkar = List<Zekr>.from(box.get(azkarKey, defaultValue: <Zekr>[]));
    ahadith = List<Hadith>.from(box.get(ahadithKey, defaultValue: <Hadith>[]));
    quran = List.from(box.get(quranKey, defaultValue: []));
  }
}
