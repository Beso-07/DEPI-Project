class PrayerTimeModel {
  final Timings timings;
  final DateData date;
  PrayerTimeModel({
    required this.timings,
    required this.date,
  });
  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimeModel(
      timings: Timings.fromJson(json["timings"]),
      date: DateData.fromJson(json["date"]),
    );
  }
}

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });
  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json["Fajr"],
      sunrise: json["Sunrise"],
      dhuhr: json["Dhuhr"],
      asr: json["Asr"],
      maghrib: json["Maghrib"],
      isha: json["Isha"],
    );
  }
}

class DateData {
  final String readable;
  final Hijri hijri;
  final Gregorian gregorian;
  DateData({
    required this.readable,
    required this.hijri,
    required this.gregorian,
  });
  factory DateData.fromJson(Map<String, dynamic> json) {
    return DateData(
        readable: json["readable"],
        hijri: Hijri.fromJson(json['hijri']),
        gregorian: Gregorian.fromJson(json['gregorian']));
  }
}

class Hijri {
  final String date;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;

  Hijri(
      {required this.date,
      required this.day,
      required this.weekday,
      required this.month,
      required this.year});
  factory Hijri.fromJson(Map<String, dynamic> json) {
    return Hijri(
      date: json['date'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
    );
  }
}

class Weekday {
  final String en;
  final String ar;

  Weekday({required this.en, required this.ar});

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(en: json['en'], ar: json['ar']);
  }
}

class Month {
  final int number;
  final String en;
  final String ar;
  final int days;

  Month(
      {required this.number,
      required this.en,
      required this.ar,
      required this.days});
  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
        number: json['number'],
        en: json['en'],
        ar: json['ar'],
        days: json['days']);
  }
}

class Gregorian {
  final String date;
  final String day;
  final WeekdayG weekdayG;
  final MonthG monthG;
  final String year;

  Gregorian(
      {required this.date,
      required this.day,
      required this.weekdayG,
      required this.monthG,
      required this.year});
  factory Gregorian.fromJson(Map<String, dynamic> json) {
    return Gregorian(
      date: json['date'],
      day: json['day'],
      weekdayG: WeekdayG.fromJson(json['weekday']),
      monthG: MonthG.fromJson(json['month']),
      year: json['year'],
    );
  }
}

class WeekdayG {
  final String en;
  WeekdayG({required this.en});
  factory WeekdayG.fromJson(Map<String, dynamic> json) {
    return WeekdayG(en: json['en']);
  }
}

class MonthG {
  final int number;
  final String en;
  MonthG({required this.number, required this.en});
  factory MonthG.fromJson(Map<String, dynamic> json) {
    return MonthG(number: json['number'], en: json['en']);
  }
}
