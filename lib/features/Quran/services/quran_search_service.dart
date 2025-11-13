import '../models/verse.dart';
import '../models/surah.dart';
import 'quran_data_service.dart';
import 'surah_index_service.dart';

/// Represents a search result containing verse information and its location
class SearchResult {
  final Verse verse;
  final Surah surah;
  final int pageNumber;
  final String highlightedText;
  
  const SearchResult({
    required this.verse,
    required this.surah,
    required this.pageNumber,
    required this.highlightedText,
  });
}

/// Service for searching through Quran text
class QuranSearchService {
  static List<Verse>? _cachedVerses;
  static List<Surah>? _cachedSurahs;
  static List<SurahPageInfo>? _cachedSurahIndex;
  
  /// Initialize the search service by loading data
  static Future<void> initialize() async {
    if (_cachedVerses == null || _cachedSurahs == null) {
      _cachedVerses = await QuranDataService.loadVerses();
      _cachedSurahs = await QuranDataService.loadSurahs();
      _cachedSurahIndex = await SurahIndexService.getAllSurahsWithPages();
    }
  }
  
  /// Search for verses containing the specified text
  static Future<List<SearchResult>> searchVerses(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }
    
    await initialize();
    
    final List<SearchResult> results = [];
    final String normalizedQuery = _normalizeArabicText(query.trim());
    
    for (final verse in _cachedVerses!) {
      final normalizedVerseText = _normalizeArabicText(verse.text);
      
      if (normalizedVerseText.contains(normalizedQuery)) {
        // Find the surah for this verse
        final surah = _cachedSurahs!.firstWhere(
          (s) => s.id == verse.chapter,
          orElse: () => Surah(
            id: verse.chapter,
            name: 'سورة ${verse.chapter}',
            transliteration: '',
            type: 'مكية',
            totalVerses: 0,
          ),
        );
        
        // Find the page number for this verse
        final pageNumber = _findPageForVerse(verse);
        
        // Create highlighted text
        final highlightedText = _highlightSearchTerm(verse.text, query);
        
        results.add(SearchResult(
          verse: verse,
          surah: surah,
          pageNumber: pageNumber,
          highlightedText: highlightedText,
        ));
      }
    }
    
    return results;
  }
  
  /// Search by surah name
  static Future<List<SearchResult>> searchBySurahName(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }
    
    await initialize();
    
    final List<SearchResult> results = [];
    final String normalizedQuery = _normalizeArabicText(query.trim());
    
    for (final surah in _cachedSurahs!) {
      final normalizedSurahName = _normalizeArabicText(surah.name);
      
      if (normalizedSurahName.contains(normalizedQuery)) {
        // Get first verse of this surah
        final firstVerse = _cachedVerses!.firstWhere(
          (v) => v.chapter == surah.id && v.verse == 1,
          orElse: () => _cachedVerses!.firstWhere((v) => v.chapter == surah.id),
        );
        
        final pageNumber = _findPageForVerse(firstVerse);
        
        results.add(SearchResult(
          verse: firstVerse,
          surah: surah,
          pageNumber: pageNumber,
          highlightedText: surah.name,
        ));
      }
    }
    
    return results;
  }
  
  /// Find the page number where a specific verse is located
  static int _findPageForVerse(Verse verse) {
    // For Al-Fatiha
    if (verse.chapter == 1) {
      return 0;
    }
    
    // For first 5 verses of Al-Baqarah
    if (verse.chapter == 2 && verse.verse <= 5) {
      return 1;
    }
    
    // For other verses, find the surah's starting page
    final surahInfo = _cachedSurahIndex?.firstWhere(
      (info) => info.surah.id == verse.chapter,
      orElse: () => SurahPageInfo(
        surah: Surah(id: verse.chapter, name: '', transliteration: '', type: '', totalVerses: 0),
        startPage: 2,
      ),
    );
    
    // Better estimation based on verse distribution
    final basePageNumber = surahInfo?.startPage ?? 2;
    
    // For Al-Baqarah remaining verses (after verse 5)
    if (verse.chapter == 2 && verse.verse > 5) {
      final remainingVerses = verse.verse - 5;
      final estimatedOffset = remainingVerses ~/ 12; // Roughly 12 verses per page for Baqarah
      return basePageNumber + estimatedOffset;
    }
    
    // For other surahs, estimate based on verse density
    final estimatedOffset = (verse.verse - 1) ~/ 15; // Roughly 15 verses per page
    final maxOffset = 10; // Don't go too far from surah start
    
    return basePageNumber + (estimatedOffset > maxOffset ? maxOffset : estimatedOffset);
  }
  
  /// Normalize Arabic text for better search matching
  static String _normalizeArabicText(String text) {
    return text
        // Normalize different forms of Alif
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا')
        // Normalize Ta Marbuta and Ya
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        // Remove all diacritics (harakat)
        .replaceAll(RegExp(r'[ًٌٍَُِّْٰٕٓٔ]'), '')
        // Remove extra spaces
        .replaceAll(RegExp(r'\s+'), ' ')
        .toLowerCase()
        .trim();
  }
  
  /// Highlight search term in text
  static String _highlightSearchTerm(String text, String searchTerm) {
    if (searchTerm.trim().isEmpty) return text;
    
    // Simple highlighting - in a real app you might use a more sophisticated approach
    final RegExp regex = RegExp(searchTerm.trim(), caseSensitive: false);
    return text.replaceAll(regex, '**$searchTerm**');
  }
  
  /// Clear cached data
  static void clearCache() {
    _cachedVerses = null;
    _cachedSurahs = null;
    _cachedSurahIndex = null;
  }
}