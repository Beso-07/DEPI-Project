import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  bool isHijri = true; 
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> events = [
    {
      'title': 'ليلة النصف من شعبان',
      'date': DateTime(2025, 2, 15),
    },
    {
      'title': 'رمضان',
      'date': DateTime(2025, 3, 1),
    },
  ];

  void toggleCalendar(bool hijri) {
    isHijri = hijri;
    emit(CalendarChanged(isHijri: isHijri, selectedDate: selectedDate));
  }

  void changeDate(DateTime date) {
    selectedDate = date;
    emit(CalendarChanged(isHijri: isHijri, selectedDate: selectedDate));
  }

  String formatDate(DateTime date) {
    if (isHijri) {
      final hijri = HijriCalendar.fromDate(date);
      return "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ";
    } else {
      return DateFormat.yMMMMd('ar').format(date);
    }
  }

  List<Map<String, dynamic>> getUpcomingEvents() {
    return events.map((event) {
      final diff = event['date'].difference(DateTime.now()).inDays;
      return {
        'title': event['title'],
        'date': event['date'],
        'remaining': diff,
      };
    }).toList();
  }
}
