import 'package:flutter/material.dart';
import '../models/verse.dart';
import '../services/quran_data_service.dart';
import '../widgets/ayah_number_widget.dart';

class QuranPage {
  final List<Verse> verses;        
  final bool startsWithBasmalah;   
  final String? surahName;         
  
  const QuranPage({
    required this.verses,
    this.startsWithBasmalah = false,
    this.surahName,
  });
}


class QuranPaginationService {
  static const double _defaultFontSize = 24.0;
  static const String _defaultFontFamily = 'Amiri';
  static const double _lineHeight = 1.8; 
  
 
  static Future<List<QuranPage>> createPages({
    required double availableHeight,
    required double availableWidth,
    double fontSize = _defaultFontSize,
    String fontFamily = _defaultFontFamily,
    EdgeInsets padding = const EdgeInsets.all(16.0),
  }) async {
    final verses = await QuranDataService.loadVerses();
    final surahs = await QuranDataService.loadSurahs();
    
    
    final surahMap = {for (var surah in surahs) surah.id: surah};
    
    final List<QuranPage> pages = [];
    
    
    final fatihaVerses = verses.where((v) => v.chapter == 1).toList();
    pages.add(QuranPage(
      verses: fatihaVerses,
      startsWithBasmalah: true,
      surahName: 'الفاتحة',
    ));
    
    
    final baqarahFirst5 = verses.where((v) => v.chapter == 2 && v.verse <= 5).toList();
    pages.add(QuranPage(
      verses: baqarahFirst5,
      startsWithBasmalah: true,
      surahName: 'البقرة',
    ));
    
    final remainingVerses = verses.where((v) => 
      !(v.chapter == 1) && 
      !(v.chapter == 2 && v.verse <= 5) 
    ).toList();
    
    const int remainingPageCount = 600;
    final int totalRemainingVerses = remainingVerses.length;
    final double versesPerPage = totalRemainingVerses / remainingPageCount;
    
    for (int pageIndex = 0; pageIndex < remainingPageCount; pageIndex++) {
      final int startVerseIndex = (pageIndex * versesPerPage).floor();
      final int endVerseIndex = ((pageIndex + 1) * versesPerPage).floor();
      
      if (startVerseIndex >= totalRemainingVerses) {
        pages.add(QuranPage(verses: []));
        continue;
      }
      
      final int actualEndIndex = endVerseIndex > totalRemainingVerses ? totalRemainingVerses : endVerseIndex;
      final int actualStartIndex = startVerseIndex;
      
      final List<Verse> pageVerses = remainingVerses.sublist(
        actualStartIndex, 
        actualEndIndex == actualStartIndex ? actualStartIndex + 1 : actualEndIndex
      );
      
      if (pageVerses.isEmpty) {
        pages.add(QuranPage(verses: []));
        continue;
      }
      
      final firstVerse = pageVerses.first;
      final surah = surahMap[firstVerse.chapter];
      final bool startsWithBasmalah = firstVerse.verse == 1 && surah?.hasBasmalah == true;
      final String? surahName = firstVerse.verse == 1 ? surah?.name : null;
      
      pages.add(QuranPage(
        verses: pageVerses,
        startsWithBasmalah: startsWithBasmalah,
        surahName: surahName,
      ));
    }
    
    return pages;
  }
  
  static Widget buildPageContent({
    required QuranPage page,
    required double fontSize,
    String fontFamily = _defaultFontFamily,
    Color textColor = Colors.black87,
  }) {
    final List<Widget> children = [];
    
    if (page.surahName != null && page.verses.isNotEmpty && page.verses.first.verse == 1) {
      children.add(buildSurahHeader(page.surahName!, fontSize, fontFamily, textColor));
      children.add(const SizedBox(height: 20)); 
    }
    
    // Add basmalah if needed
    if (page.startsWithBasmalah) {
      children.add(buildBasmalah(fontSize, fontFamily, textColor));
      children.add(const SizedBox(height: 16)); 
    }
    
    
    children.add(_buildContinuousVerses(page.verses, fontSize, fontFamily, textColor));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
  

  static Widget _buildContinuousVerses(List<Verse> verses, double fontSize, String fontFamily, Color textColor) {
    if (verses.isEmpty) {
      return const SizedBox.shrink();
    }
    
    final List<InlineSpan> spans = [];
    int? currentSurah;
    
    for (int i = 0; i < verses.length; i++) {
      final verse = verses[i];
      
      
      if (currentSurah != null && verse.chapter != currentSurah) {
       
        spans.add(const TextSpan(text: '\n\n'));
        spans.add(_buildInlineSurahHeader(verse.chapter, fontSize, fontFamily, textColor));
        spans.add(const TextSpan(text: '\n'));
        
       
        if (verse.chapter != 9 && verse.verse == 1) {
          spans.add(_buildInlineBasmalah(fontSize, fontFamily, textColor));
          spans.add(const TextSpan(text: '\n'));
        }
      }
      
      currentSurah = verse.chapter;
      
     
      spans.add(
        TextSpan(
          text: verse.text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: textColor,
            height: _lineHeight,
          ),
        ),
      );
      
    
      spans.add(AyahNumberStyles.regular(verse.verse));
      
     
      if (i < verses.length - 1) {
        spans.add(const TextSpan(text: ' '));
      }
    }
    
    return RichText(
      text: TextSpan(children: spans),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
    );
  }
  

  static TextSpan _buildInlineSurahHeader(int surahNumber, double fontSize, String fontFamily, Color textColor) {
    
    final Map<int, String> surahNames = {
      1: 'الفاتحة', 2: 'البقرة', 3: 'آل عمران', 4: 'النساء', 5: 'المائدة',
      6: 'الأنعام', 7: 'الأعراف', 8: 'الأنفال', 9: 'التوبة', 10: 'يونس',
      11: 'هود', 12: 'يوسف', 13: 'الرعد', 14: 'إبراهيم', 15: 'الحجر',
      16: 'النحل', 17: 'الإسراء', 18: 'الكهف', 19: 'مريم', 20: 'طه',
      21: 'الأنبياء', 22: 'الحج', 23: 'المؤمنون', 24: 'النور', 25: 'الفرقان',
      26: 'الشعراء', 27: 'النمل', 28: 'القصص', 29: 'العنكبوت', 30: 'الروم',
      31: 'لقمان', 32: 'السجدة', 33: 'الأحزاب', 34: 'سبأ', 35: 'فاطر',
      36: 'يس', 37: 'الصافات', 38: 'ص', 39: 'الزمر', 40: 'غافر',
      41: 'فصلت', 42: 'الشورى', 43: 'الزخرف', 44: 'الدخان', 45: 'الجاثية',
      46: 'الأحقاف', 47: 'محمد', 48: 'الفتح', 49: 'الحجرات', 50: 'ق',
      51: 'الذاريات', 52: 'الطور', 53: 'النجم', 54: 'القمر', 55: 'الرحمن',
      56: 'الواقعة', 57: 'الحديد', 58: 'المجادلة', 59: 'الحشر', 60: 'الممتحنة',
      61: 'الصف', 62: 'الجمعة', 63: 'المنافقون', 64: 'التغابن', 65: 'الطلاق',
      66: 'التحريم', 67: 'الملك', 68: 'القلم', 69: 'الحاقة', 70: 'المعارج',
      71: 'نوح', 72: 'الجن', 73: 'المزمل', 74: 'المدثر', 75: 'القيامة',
      76: 'الإنسان', 77: 'المرسلات', 78: 'النبأ', 79: 'النازعات', 80: 'عبس',
      81: 'التكوير', 82: 'الانفطار', 83: 'المطففين', 84: 'الانشقاق', 85: 'البروج',
      86: 'الطارق', 87: 'الأعلى', 88: 'الغاشية', 89: 'الفجر', 90: 'البلد',
      91: 'الشمس', 92: 'الليل', 93: 'الضحى', 94: 'الشرح', 95: 'التين',
      96: 'العلق', 97: 'القدر', 98: 'البينة', 99: 'الزلزلة', 100: 'العاديات',
      101: 'القارعة', 102: 'التكاثر', 103: 'العصر', 104: 'الهمزة', 105: 'الفيل',
      106: 'قريش', 107: 'الماعون', 108: 'الكوثر', 109: 'الكافرون', 110: 'النصر',
      111: 'المسد', 112: 'الإخلاص', 113: 'الفلق', 114: 'الناس'
    };
    
    final String surahName = surahNames[surahNumber] ?? 'سورة رقم $surahNumber';
    
    return TextSpan(
      text: '﴿ $surahName ﴾',
      style: TextStyle(
        fontSize: fontSize * 1.2,
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        color: textColor,
        backgroundColor: const Color(0xFF8B4513).withValues(alpha: 0.1),
      ),
    );
  }
  
  /// Builds an inline basmalah
  static TextSpan _buildInlineBasmalah(double fontSize, String fontFamily, Color textColor) {
    return TextSpan(
      text: QuranDataService.basmalah,
      style: TextStyle(
        fontSize: fontSize * 1.1,
        fontFamily: fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
        backgroundColor: const Color(0xFFF5F5DC).withValues(alpha: 0.2),
      ),
    );
  }
  
  /// Builds a decorative header box for surah names
  static Widget buildSurahHeader(String surahName, double fontSize, String fontFamily, Color textColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8B4513).withValues(alpha: 0.15), // Slightly darker brown
            const Color(0xFF2F4F4F).withValues(alpha: 0.15), // Slightly darker slate gray
            const Color(0xFFDAA520).withValues(alpha: 0.1),  // Gold accent
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF8B4513).withValues(alpha: 0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
          BoxShadow(
            color: const Color(0xFFDAA520).withValues(alpha: 0.1),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Decorative line above
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF8B4513).withValues(alpha: 0.6),
                  const Color(0xFFDAA520).withValues(alpha: 0.8),
                  const Color(0xFF8B4513).withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            surahName,
            style: TextStyle(
              fontSize: fontSize * 1.4,
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          // Decorative line below
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF8B4513).withValues(alpha: 0.6),
                  const Color(0xFFDAA520).withValues(alpha: 0.8),
                  const Color(0xFF8B4513).withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
  

  
  /// Builds the basmalah widget
  static Widget buildBasmalah(double fontSize, String fontFamily, Color textColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5DC).withValues(alpha: 0.3), // Very light beige
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF8B4513).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        QuranDataService.basmalah,
        style: TextStyle(
          fontSize: fontSize * 1.15,
          fontFamily: fontFamily,
          color: textColor,
          height: _lineHeight,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
    );
  }
  
}