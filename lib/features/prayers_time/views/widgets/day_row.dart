import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class DayRow extends StatelessWidget {
  const DayRow({super.key});

  @override
  Widget build(BuildContext context) {
    final gregorian = DateHelper.getGregorianDate();
    final hijri = DateHelper.getHijriDate();
    final weekday = DateHelper.getWeekDay();

    return Column(
      children: [
        Text(
          weekday,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DateBox(text: hijri),
            DateBox(text: gregorian),
          ],
        ),
      ],
    );
  }
}

class DateBox extends StatelessWidget {
  const DateBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.kPrayerTimeColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black),
      ),
    );
  }
}
