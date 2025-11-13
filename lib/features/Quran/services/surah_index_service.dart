import '../models/surah.dart';
import 'quran_data_service.dart';
import 'quran_pagination_service.dart';

class SurahPageInfo {
  final Surah surah;
  final int startPage; 
  
  const SurahPageInfo({
    required this.surah,
    required this.startPage,
  });
}

class SurahIndexService {
  static List<SurahPageInfo>? _cachedSurahIndex;
  static double? _cachedHeight;
  static double? _cachedWidth;
 
  static Future<List<SurahPageInfo>> createSurahIndex({
    double? availableHeight,
    double? availableWidth,
  }) async {
    final height = availableHeight ?? 800.0;
    final width = availableWidth ?? 600.0;
    
 
    if (_cachedSurahIndex != null && 
        _cachedHeight == height && 
        _cachedWidth == width) {
      return _cachedSurahIndex!;
    }
    
    try {
      final surahs = await QuranDataService.loadSurahs();
      
      final double pageHeight = availableHeight ?? 800.0;
      final double pageWidth = availableWidth ?? 600.0;
      
      final pages = await QuranPaginationService.createPages(
        availableHeight: pageHeight,
        availableWidth: pageWidth,
      );
      
      final List<SurahPageInfo> surahIndex = [];
      final Set<int> recordedSurahs = {};
      
      for (int pageIndex = 0; pageIndex < pages.length; pageIndex++) {
        final page = pages[pageIndex];
        
        if (page.verses.isNotEmpty) {
          for (final verse in page.verses) {
            final surahId = verse.chapter;
            
            if (verse.verse == 1 && !recordedSurahs.contains(surahId)) {
              try {
                final surah = surahs.firstWhere((s) => s.id == surahId);
                surahIndex.add(SurahPageInfo(
                  surah: surah,
                  startPage: pageIndex,
                ));
                recordedSurahs.add(surahId);
              } catch (e) {
                surahIndex.add(SurahPageInfo(
                  surah: Surah(
                    id: surahId, 
                    name: 'سورة $surahId', 
                    transliteration: '', 
                    type: 'مكية', 
                    totalVerses: 0
                  ),
                  startPage: pageIndex,
                ));
                recordedSurahs.add(surahId);
              }
            }
          }
        }
      }
      
      surahIndex.sort((a, b) => a.surah.id.compareTo(b.surah.id));
      
      _cachedSurahIndex = surahIndex;
      _cachedHeight = height;
      _cachedWidth = width;
      return surahIndex;
      
    } catch (e) {
      print('Error creating surah index: $e');
      return await _createFallbackIndex();
    }
  }
  
  static Future<List<SurahPageInfo>> _createFallbackIndex() async {
    try {
      final surahs = await QuranDataService.loadSurahs();
      final List<SurahPageInfo> fallbackIndex = [];
      
      if (surahs.length >= 2) {
        fallbackIndex.add(SurahPageInfo(
          surah: surahs.firstWhere((s) => s.id == 1),
          startPage: 0,
        ));
        fallbackIndex.add(SurahPageInfo(
          surah: surahs.firstWhere((s) => s.id == 2),
          startPage: 1,
        ));
      }
      
      for (int i = 2; i < surahs.length && i < 20; i++) {
        fallbackIndex.add(SurahPageInfo(
          surah: surahs[i],
          startPage: 2 + ((i - 2) * 30), 
        ));
      }
      
      return fallbackIndex;
    } catch (e) {
      return [
        SurahPageInfo(
          surah: Surah(id: 1, name: 'الفاتحة', transliteration: 'Al-Fatihah', type: 'مكية', totalVerses: 7),
          startPage: 0,
        ),
        SurahPageInfo(
          surah: Surah(id: 2, name: 'البقرة', transliteration: 'Al-Baqarah', type: 'مدنية', totalVerses: 286),
          startPage: 1,
        ),
      ];
    }
  }
  
  static Future<List<SurahPageInfo>> getAllSurahsWithPages({
    double? availableHeight,
    double? availableWidth,
  }) async {
    return await createSurahIndex(
      availableHeight: availableHeight,
      availableWidth: availableWidth,
    );
  }
  
  static Future<int?> getPageForSurah(int surahId) async {
    final index = await createSurahIndex();
    for (final info in index) {
      if (info.surah.id == surahId) {
        return info.startPage;
      }
    }
    return null;
  }
  
  static void clearCache() {
    _cachedSurahIndex = null;
  }
  
  static Future<List<SurahPageInfo>> recreateIndex({
    double? pageHeight,
    double? pageWidth,
  }) async {
    clearCache();
    return await createSurahIndex();
  }
}