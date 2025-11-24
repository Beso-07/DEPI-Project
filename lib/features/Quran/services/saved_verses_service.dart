import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../models/saved_verse.dart';
import '../models/verse.dart';

class SavedVersesService {
  static const String _boxName = 'saved_verses';
  static Box<SavedVerse>? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SavedVerseAdapter());
    _box = await Hive.openBox<SavedVerse>(_boxName);
  }

  static Box<SavedVerse> get _savedVersesBox {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Hive box is not initialized. Call init() first.');
    }
    return _box!;
  }

  static Future<void> saveVerse({
    required String verseText,
    required String surahName,
    required int surahNumber,
    required int verseNumber,
    required int pageNumber,
  }) async {
    final savedVerse = SavedVerse(
      verseText: verseText,
      surahName: surahName,
      surahNumber: surahNumber,
      verseNumber: verseNumber,
      pageNumber: pageNumber,
      savedAt: DateTime.now(),
    );

    final key = '${surahNumber}_$verseNumber';
    await _savedVersesBox.put(key, savedVerse);
  }

  static Future<void> removeSavedVerse(int surahNumber, int verseNumber) async {
    final key = '${surahNumber}_$verseNumber';
    await _savedVersesBox.delete(key);
  }

  static bool isVerseSaved(int surahNumber, int verseNumber) {
    final key = '${surahNumber}_$verseNumber';
    return _savedVersesBox.containsKey(key);
  }

  static List<SavedVerse> getAllSavedVerses() {
    return _savedVersesBox.values.toList()
      ..sort((a, b) => b.savedAt.compareTo(a.savedAt)); 
  }

  static Future<void> clearAllSavedVerses() async {
    await _savedVersesBox.clear();
  }

  static Future<void> shareVerse({
    required String verseText,
    required String surahName,
    required int verseNumber,
  }) async {
    final shareText = '''
$verseText

سورة $surahName - آية $verseNumber

تم المشاركة من تطبيق القرآن الكريم
''';

    await Share.share(
      shareText,
      subject: 'آية من القرآن الكريم - سورة $surahName',
    );
  }

  // Get verse context from a Verse model
  static String getVerseContextFromModel(Verse verse) {
    return '''
${verse.text}

سورة ${verse.surahName ?? 'غير محدد'} - آية ${verse.verseNumber}

تم المشاركة من تطبيق القرآن الكريم
''';
  }

  // Share verse using Verse model
  static Future<void> shareVerseFromModel(Verse verse) async {
    await Share.share(
      getVerseContextFromModel(verse),
      subject: 'آية من القرآن الكريم - سورة ${verse.surahName ?? 'غير محدد'}',
    );
  }

  static Future<void> saveVerseFromModel(Verse verse, int currentPage) async {
    await saveVerse(
      verseText: verse.text,
      surahName: verse.surahName ?? 'غير محدد',
      surahNumber: verse.surahNumber,
      verseNumber: verse.verseNumber,
      pageNumber: currentPage,
    );
  }
}