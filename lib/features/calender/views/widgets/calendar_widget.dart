import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/calender/views_model/calendar_cubit/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_hijri_calendar/islamic_hijri_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final cubit = context.read<CalendarCubit>();
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: cubit.isHijri
                ? const HijriTable()
                : GregorianTable(cubit: cubit),
          ),
        );
      },
    );
  }
}

class HijriTable extends StatelessWidget {
  const HijriTable({super.key});

  @override
  Widget build(BuildContext context) {
    return IslamicHijriCalendar(
      isHijriView: true,
      highlightBorder: AppColors.kPrimaryColor2,
      defaultBorder: Theme.of(context).colorScheme.onBackground.withOpacity(.1),
      highlightTextColor: Theme.of(context).colorScheme.background,
      defaultTextColor: Theme.of(context).colorScheme.onBackground,
      defaultBackColor: Theme.of(context).colorScheme.background,
      adjustmentValue: 0,
      isGoogleFont: true,
      fontFamilyName: "Lato",
      isDisablePreviousNextMonthDates: true,
    );
  }
}

class GregorianTable extends StatelessWidget {
  const GregorianTable({super.key, required this.cubit});
  final CalendarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: cubit.selectedDate,
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(cubit.selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        cubit.changeDate(selectedDay);
      },
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.black),
        weekendStyle: TextStyle(color: Colors.black),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.green.shade100,
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
