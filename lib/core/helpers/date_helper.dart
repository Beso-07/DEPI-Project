import 'package:depiproject/features/prayers_time/models/prayer_time_model.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class DateHelper {
  static const Map<int, String> hijriMonths = {
    1: "محرم",
    2: "صفر",
    3: "ربيع الأول",
    4: "ربيع الآخر",
    5: "جمادى الأولى",
    6: "جمادى الآخرة",
    7: "رجب",
    8: "شعبان",
    9: "رمضان",
    10: "شوال",
    11: "ذو القعدة",
    12: "ذو الحجة",
  };

  static String getHijriDate() {
    final hijri = HijriCalendar.now();
    final monthName = hijriMonths[hijri.hMonth] ?? "";
    return "${hijri.hDay} $monthName ${hijri.hYear} هـ";
  }

  static String getGregorianDate() {
    final now = DateTime.now();
    final day = DateFormat.d('ar').format(now);
    final month = DateFormat.MMMM('ar').format(now);
    final year = DateFormat.y('ar').format(now);
    return "$day $month $year م";
  }

  static String getWeekDay() {
    final now = DateTime.now();
    return DateFormat.EEEE('ar').format(now);
  }

  static String getNextPrayer(PrayerTimeModel model) {
    final now = DateTime.now();

    DateTime parseTime(String time) {
      final parts = time.split(' ');
      final hm = parts[0].split(':');
      int hour = int.parse(hm[0]);
      final minute = int.parse(hm[1]);
      final period = parts[1];

      if (period == "م" && hour != 12) {
        hour += 12;
      } else if (period == "ص" && hour == 12) {
        hour = 0;
      }

      return DateTime(now.year, now.month, now.day, hour, minute);
    }

    final times = {
      "الفجر": parseTime(model.fajr),
      "الظهر": parseTime(model.dhuhr),
      "العصر": parseTime(model.asr),
      "المغرب": parseTime(model.maghrib),
      "العشاء": parseTime(model.isha),
    };

    for (final entry in times.entries) {
      if (now.isBefore(entry.value)) {
        final diff = entry.value.difference(now);

        final hours = diff.inHours;
        final minutes = diff.inMinutes.remainder(60);

        String timeText;

        if (hours > 0) {
          if (minutes > 0) {
            timeText = "$hours ساعة و$minutes دقيقة";
          } else {
            timeText = "$hours ساعة";
          }
        } else {
          timeText = "$minutes دقيقة";
        }

        return "باقي على أذان ${entry.key} $timeText";
      }
    }

    final tomorrowFajr = parseTime(model.fajr).add(const Duration(days: 1));
    final diff = tomorrowFajr.difference(now);

    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);

    String timeText;

    if (hours > 0) {
      if (minutes > 0) {
        timeText = "$hours ساعة و$minutes دقيقة";
      } else {
        timeText = "$hours ساعة";
      }
    } else {
      timeText = "$minutes دقيقة";
    }

    return "باقي على أذان الفجر $timeText";
  }
}
