import 'package:hive/hive.dart';

part 'saved_verse.g.dart';

@HiveType(typeId: 10)
class SavedVerse extends HiveObject {
  @HiveField(0)
  final String verseText;

  @HiveField(1)
  final String surahName;

  @HiveField(2)
  final int surahNumber;

  @HiveField(3)
  final int verseNumber;

  @HiveField(4)
  final int pageNumber;

  @HiveField(5)
  final DateTime savedAt;

  SavedVerse({
    required this.verseText,
    required this.surahName,
    required this.surahNumber,
    required this.verseNumber,
    required this.pageNumber,
    required this.savedAt,
  });

  @override
  String toString() {
    return 'SavedVerse{verseText: $verseText, surahName: $surahName, surahNumber: $surahNumber, verseNumber: $verseNumber, pageNumber: $pageNumber, savedAt: $savedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedVerse &&
          runtimeType == other.runtimeType &&
          surahNumber == other.surahNumber &&
          verseNumber == other.verseNumber;

  @override
  int get hashCode => surahNumber.hashCode ^ verseNumber.hashCode;
}