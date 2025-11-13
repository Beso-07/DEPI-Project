import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/verse.dart';
import '../models/surah.dart';


class QuranDataService {
  static const String _quranDataPath = 'assets/json/quran.json';
  static const String _surahDataPath = 'assets/json/surahs.json';

  static List<Verse>? _cachedVerses;
  static List<Surah>? _cachedSurahs;

 
  static Future<List<Verse>> loadVerses() async {
    if (_cachedVerses != null) {
      return _cachedVerses!;
    }

    try {
      final String jsonString = await rootBundle.loadString(_quranDataPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      Map<int, String> surahMap = {};
      try {
        final String surahJsonString = await rootBundle.loadString(_surahDataPath);
        final List<dynamic> surahJsonData = json.decode(surahJsonString);
        
        for (var surahJson in surahJsonData) {
          if (surahJson is Map<String, dynamic>) {
            final int id = surahJson['id'] as int;
            final String name = surahJson['name'] as String;
            surahMap[id] = name;
          }
        }
      } catch (e) {
        print('Warning: Could not load surah names: $e');
      }

      final List<Verse> verses = [];

      jsonData.forEach((chapterKey, chapterVerses) {
        if (chapterVerses is List) {
          final int chapterNumber = int.parse(chapterKey);
          final String? surahName = surahMap[chapterNumber];
          
          for (var verseJson in chapterVerses) {
            if (verseJson is Map<String, dynamic>) {
              verseJson['surahName'] = surahName;
              verses.add(Verse.fromJson(verseJson));
            }
          }
        }
      });

      verses.sort((a, b) {
        if (a.chapter != b.chapter) {
          return a.chapter.compareTo(b.chapter);
        }
        return a.verse.compareTo(b.verse);
      });

      _cachedVerses = verses;
      return verses;
    } catch (e) {
      throw Exception('Failed to load Quran verses: $e');
    }
  }

  static Future<List<Surah>> loadSurahs() async {
    if (_cachedSurahs != null) {
      return _cachedSurahs!;
    }

    try {
      final String jsonString = await rootBundle.loadString(_surahDataPath);
      final List<dynamic> jsonData = json.decode(jsonString);

      final List<Surah> surahs = jsonData
          .map((surahJson) => Surah.fromJson(surahJson as Map<String, dynamic>))
          .toList();

      surahs.sort((a, b) => a.id.compareTo(b.id));

      _cachedSurahs = surahs;
      return surahs;
    } catch (e) {
      throw Exception('Failed to load Surah information: $e');
    }
  }

  static Future<List<Verse>> getVersesForSurah(int surahNumber) async {
    final verses = await loadVerses();
    return verses.where((verse) => verse.chapter == surahNumber).toList();
  }

  static Future<Surah?> getSurah(int surahNumber) async {
    final surahs = await loadSurahs();
    try {
      return surahs.firstWhere((surah) => surah.id == surahNumber);
    } catch (e) {
      return null; 
    }
  }

  static Future<int> getTotalVerseCount() async {
    final verses = await loadVerses();
    return verses.length;
  }

  static Future<int> getTotalSurahCount() async {
    final surahs = await loadSurahs();
    return surahs.length;
  }

  static void clearCache() {
    _cachedVerses = null;
    _cachedSurahs = null;
  }

  static const String basmalah = 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ';
}