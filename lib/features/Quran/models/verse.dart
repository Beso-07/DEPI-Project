class Verse {
  final int chapter;     
  final int verse;        
  final String text;      
  final String? surahName; 

  const Verse({
    required this.chapter,
    required this.verse,
    required this.text,
    this.surahName,
  });

  int get surahNumber => chapter;
  int get verseNumber => verse;

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      chapter: json['chapter'] as int,
      verse: json['verse'] as int,
      text: json['text'] as String,
      surahName: json['surahName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter': chapter,
      'verse': verse,
      'text': text,
      if (surahName != null) 'surahName': surahName,
    };
  }

  @override
  String toString() {
    return 'Verse{chapter: $chapter, verse: $verse, text: $text, surahName: $surahName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Verse &&
        other.chapter == chapter &&
        other.verse == verse &&
        other.text == text &&
        other.surahName == surahName;
  }

  @override
  int get hashCode => chapter.hashCode ^ verse.hashCode ^ text.hashCode ^ surahName.hashCode;
}