import 'dart:convert';
import 'package:depiproject/core/helpers/hive_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/features/Quran/models/quran_model.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  List<Surah> quranSurahs = [];

  Future<void> loadQuranData() async {
    emit(QuranLoading());
    try {
      final String surahsJsonString =
          await rootBundle.loadString('assets/json/surahs.json');
      final List<dynamic> surahsData = json.decode(surahsJsonString);

      quranSurahs = [];
      for (var surahData in surahsData) {
        try {
          quranSurahs.add(Surah.fromJson(surahData));
        } catch (e) {
          print('Error parsing surah ${surahData['id']}: $e');
        }
      }

      emit(QuranLoaded(quranSurahs, HiveHelper.quran));
    } catch (e) {
      print('Error loading Quran data: $e');
      emit(QuranError('فشل في تحميل بيانات القرآن الكريم: ${e.toString()}'));
    }
  }

  Future<List<Verse>> loadSurahVerses(int surahId) async {
    try {
      final String versesJsonString =
          await rootBundle.loadString('assets/json/quran.json');
      final Map<String, dynamic> versesData = json.decode(versesJsonString);

      List<Verse> verses = [];
      if (versesData.containsKey(surahId.toString())) {
        final List<dynamic> surahVerses = versesData[surahId.toString()];
        for (var verseData in surahVerses) {
          verses.add(Verse.fromJson(verseData));
        }
      }

      return verses;
    } catch (e) {
      print('Error loading verses for surah $surahId: $e');
      return [];
    }
  }

  bool isSaved(Surah surah) => HiveHelper.isSaved(
      items: HiveHelper.quran, item: surah, key: HiveHelper.quranKey);

  Future<void> toggleSave(Surah surah) async {
    await HiveHelper.toggleSaved(
      key: HiveHelper.quranKey,
      items: HiveHelper.quran,
      item: surah,
    );
    await HiveHelper.getMyNotes();
    if (state is QuranLoaded) {
      final current = state as QuranLoaded;
      emit(QuranLoaded(current.surahs, HiveHelper.quran));
    }
  }
}
