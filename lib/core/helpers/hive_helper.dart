import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:depiproject/features/ahadith/models/hadith_model.dart';
import 'package:depiproject/features/Quran/models/quran_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const archivesBox = "archivesBox";
  static const azkarKey = "azkarKey";
  static const ahadithKey = "ahadithKey";
  static const quranKey = "quranKey";
  static const doaaKey = "doaaKey";

  static List<Zekr> azkar = [];
  static List<Hadith> ahadith = [];
  static List<Surah> quran = [];
  static List<Map<String, dynamic>> doaa = [];
  static late Box box;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ZekrAdapter());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(HadithAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SurahAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(VerseAdapter());
    }

    box = await Hive.openBox(archivesBox);
    await getMyNotes();
  }

  static bool isSaved({
    required List items,
    required dynamic item,
    required String key,
  }) {
    return items.any((e) {
      if (key == azkarKey) {
        return e.zekr == item.zekr && e.count == item.count;
      } else if (key == ahadithKey) {
        return e.id == item.id && e.hadithContent == item.hadithContent;
      } else if (key == quranKey) {
        return e.id == item.id && e.name == item.name;
      } else if (key == doaaKey) {
        return e['text'] == item['text'] && e['category'] == item['category'];
      } else {
        return false;
      }
    });
  }

  static Future<void> toggleSaved({
    required String key,
    required List items,
    required dynamic item,
  }) async {
    if (isSaved(items: items, item: item, key: key)) {
      items.removeWhere((e) {
        if (key == azkarKey) {
          return e.zekr == item.zekr && e.count == item.count;
        } else if (key == ahadithKey) {
          return e.id == item.id && e.hadithContent == item.hadithContent;
        } else if (key == quranKey) {
          return e.id == item.id && e.name == item.name;
        } else if (key == doaaKey) {
          return e['text'] == item['text'] && e['category'] == item['category'];
        } else {
          return false;
        }
      });
    } else {
      items.add(item);
    }

    await box.put(key, List.from(items));
    await getMyNotes();
  }

  static Future<void> getMyNotes() async {
    azkar = List<Zekr>.from(box.get(azkarKey, defaultValue: <Zekr>[]));
    ahadith = List<Hadith>.from(box.get(ahadithKey, defaultValue: <Hadith>[]));
    quran = List<Surah>.from(box.get(quranKey, defaultValue: <Surah>[]));

    doaa = (box.get(doaaKey, defaultValue: <Map<dynamic, dynamic>>[]) as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
