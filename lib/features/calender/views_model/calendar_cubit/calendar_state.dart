part of 'calendar_cubit.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarChanged extends CalendarState {
  final bool isHijri;
  final DateTime selectedDate;

  CalendarChanged({required this.isHijri, required this.selectedDate});
}
