import '../models/surah.dart';
import 'quran_data_service.dart';
import 'quran_pagination_service.dart';

/// Class to store information about where each surah starts in the pagination
class SurahPageInfo {
  final Surah surah;
  final int startPage; // Page number where this surah starts (0-based)
  
  const SurahPageInfo({
    required this.surah,
    required this.startPage,
  });
}

/// Service to provide information about surah locations in the paginated Quran
class SurahIndexService {
  static List<SurahPageInfo>? _cachedSurahIndex;
  static double? _cachedHeight;
  static double? _cachedWidth;
  
  /// Creates a mapping of surahs to their starting page numbers
  /// This uses the actual pagination service to get precise page locations
  static Future<List<SurahPageInfo>> createSurahIndex({
    double? availableHeight,
    double? availableWidth,
  }) async {
    final height = availableHeight ?? 800.0;
    final width = availableWidth ?? 600.0;
    
    // Check if we need to recreate the cache due to dimension changes
    if (_cachedSurahIndex != null && 
        _cachedHeight == height && 
        _cachedWidth == width) {
      return _cachedSurahIndex!;
    }
    
    try {
      final surahs = await QuranDataService.loadSurahs();
      
      // Create pages using the actual pagination service
      // Use provided dimensions or standard defaults
      final double pageHeight = availableHeight ?? 800.0;
      final double pageWidth = availableWidth ?? 600.0;
      
      final pages = await QuranPaginationService.createPages(
        availableHeight: pageHeight,
        availableWidth: pageWidth,
      );
      
      final List<SurahPageInfo> surahIndex = [];
      final Set<int> recordedSurahs = {};
      
      // Go through each page and find where each surah actually starts
      for (int pageIndex = 0; pageIndex < pages.length; pageIndex++) {
        final page = pages[pageIndex];
        
        if (page.verses.isNotEmpty) {
          // Look for verse 1 of any surah (actual surah beginnings)
          for (final verse in page.verses) {
            final surahId = verse.chapter;
            
            // If this is verse 1 of a surah and we haven't recorded this surah yet
            if (verse.verse == 1 && !recordedSurahs.contains(surahId)) {
              try {
                final surah = surahs.firstWhere((s) => s.id == surahId);
                surahIndex.add(SurahPageInfo(
                  surah: surah,
                  startPage: pageIndex,
                ));
                recordedSurahs.add(surahId);
              } catch (e) {
                // If surah not found in surahs list, create a basic one
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
      
      // Sort by surah ID to ensure proper order
      surahIndex.sort((a, b) => a.surah.id.compareTo(b.surah.id));
      
      // Cache the results with dimensions
      _cachedSurahIndex = surahIndex;
      _cachedHeight = height;
      _cachedWidth = width;
      return surahIndex;
      
    } catch (e) {
      print('Error creating surah index: $e');
      // Fallback to basic index if there's an error
      return await _createFallbackIndex();
    }
  }
  
  /// Creates a fallback index with basic page numbers
  static Future<List<SurahPageInfo>> _createFallbackIndex() async {
    try {
      final surahs = await QuranDataService.loadSurahs();
      final List<SurahPageInfo> fallbackIndex = [];
      
      // Add first few surahs with known positions
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
      
      // Add approximate positions for other surahs
      for (int i = 2; i < surahs.length && i < 20; i++) {
        fallbackIndex.add(SurahPageInfo(
          surah: surahs[i],
          startPage: 2 + ((i - 2) * 30), // Rough approximation
        ));
      }
      
      return fallbackIndex;
    } catch (e) {
      // Ultimate fallback with hardcoded values
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
  
  /// Gets all surah information with page numbers
  static Future<List<SurahPageInfo>> getAllSurahsWithPages({
    double? availableHeight,
    double? availableWidth,
  }) async {
    return await createSurahIndex(
      availableHeight: availableHeight,
      availableWidth: availableWidth,
    );
  }
  
  /// Finds the page number where a specific surah starts
  static Future<int?> getPageForSurah(int surahId) async {
    final index = await createSurahIndex();
    for (final info in index) {
      if (info.surah.id == surahId) {
        return info.startPage;
      }
    }
    return null;
  }
  
  /// Clears the cached index (useful for testing or refreshing)
  static void clearCache() {
    _cachedSurahIndex = null;
  }
  
  /// Forces recreation of the surah index with new dimensions
  static Future<List<SurahPageInfo>> recreateIndex({
    double? pageHeight,
    double? pageWidth,
  }) async {
    clearCache();
    return await createSurahIndex();
  }
}