class Surah {
  int? id;
  String? name;
  String? transliteration;
  String? type;
  int? totalVerses;
  int? pageStart;
  int? pageEnd;
  List<Verse>? verses;

  Surah({
    this.id,
    this.name,
    this.transliteration,
    this.type,
    this.totalVerses,
    this.pageStart,
    this.pageEnd,
    this.verses,
  });

  Surah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    transliteration = json['transliteration'];
    type = json['type'];
    totalVerses = json['totalVerses'];
    pageStart = json['pageStart'];
    pageEnd = json['pageEnd'];
    if (json['verses'] != null) {
      verses = <Verse>[];
      json['verses'].forEach((v) {
        verses!.add(Verse.fromJson(v));
      });
    }
  }
}

class Verse {
  int? chapter;
  int? verse;
  String? text;

  Verse({this.chapter, this.verse, this.text});

  Verse.fromJson(Map<String, dynamic> json) {
    chapter = json['chapter'];
    verse = json['verse'];
    text = json['text'];
  }
}