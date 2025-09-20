class PrayerTimeModel {
  Data? data;

  PrayerTimeModel({this.data});

  PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Timings? timings;
  Date? date;

  Data({this.timings, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    timings =
        json['timings'] != null ? Timings.fromJson(json['timings']) : null;
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }
}

class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;

  Timings(
      {this.fajr, this.sunrise, this.dhuhr, this.asr, this.maghrib, this.isha});

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
  }
}

class Date {
  Hijri? hijri;
  Gregorian? gregorian;

  Date({this.hijri, this.gregorian});

  Date.fromJson(Map<String, dynamic> json) {
    hijri = json['hijri'] != null ? Hijri.fromJson(json['hijri']) : null;
    gregorian = json['gregorian'] != null
        ? Gregorian.fromJson(json['gregorian'])
        : null;
  }
}

class Hijri {
  String? date;
  String? day;
  String? month;
  String? year;

  Hijri({this.date, this.day, this.month, this.year});

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    month = json['month'] != null ? json['month']['en'] : null;
    year = json['year'];
  }
}

class Gregorian {
  String? date;
  String? day;
  String? month;
  String? year;

  Gregorian({this.date, this.day, this.month, this.year});

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    month = json['month'] != null ? json['month']['en'] : null;
    year = json['year'];
  }
}
