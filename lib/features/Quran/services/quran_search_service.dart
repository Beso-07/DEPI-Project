import '../models/verse.dart';
import '../models/surah.dart';
import 'quran_data_service.dart';
import 'surah_index_service.dart';

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

class QuranSearchService {
  static List<Verse>? _cachedVerses;
  static List<Surah>? _cachedSurahs;
  static List<SurahPageInfo>? _cachedSurahIndex;
  
  static Future<void> initialize() async {
    if (_cachedVerses == null || _cachedSurahs == null) {
      _cachedVerses = await QuranDataService.loadVerses();
      _cachedSurahs = await QuranDataService.loadSurahs();
      _cachedSurahIndex = await SurahIndexService.getAllSurahsWithPages();
    }
  }
  
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
        
        final pageNumber = _findPageForVerse(verse);
        
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
  
  static int _findPageForVerse(Verse verse) {
    if (verse.chapter == 1) {
      return 0;
    }
    
    if (verse.chapter == 2 && verse.verse <= 5) {
      return 1;
    }
    
    final surahInfo = _cachedSurahIndex?.firstWhere(
      (info) => info.surah.id == verse.chapter,
      orElse: () => SurahPageInfo(
        surah: Surah(id: verse.chapter, name: '', transliteration: '', type: '', totalVerses: 0),
        startPage: 2,
      ),
    );
    
    final basePageNumber = surahInfo?.startPage ?? 2;
    
    if (verse.chapter == 2 && verse.verse > 5) {
      final remainingVerses = verse.verse - 5;
      final estimatedOffset = remainingVerses ~/ 12; 
      return basePageNumber + estimatedOffset;
    }
    
    final estimatedOffset = (verse.verse - 1) ~/ 15; 
    final maxOffset = 10; 
    
    return basePageNumber + (estimatedOffset > maxOffset ? maxOffset : estimatedOffset);
  }
  
  static String _normalizeArabicText(String text) {
    return text
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll(RegExp(r'[ًٌٍَُِّْٰٕٓٔ]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .toLowerCase()
        .trim();
  }
  
  static String _highlightSearchTerm(String text, String searchTerm) {
    if (searchTerm.trim().isEmpty) return text;
    
    final RegExp regex = RegExp(searchTerm.trim(), caseSensitive: false);
    return text.replaceAll(regex, '**$searchTerm**');
  }
  
  static void clearCache() {
    _cachedVerses = null;
    _cachedSurahs = null;
    _cachedSurahIndex = null;
  }
}