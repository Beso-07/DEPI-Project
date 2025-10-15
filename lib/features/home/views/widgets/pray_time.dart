import 'package:depiproject/core/helpers/date_helper.dart';
import 'package:depiproject/core/widgets/get_next_prayer.dart';
import 'package:flutter/material.dart';

class PrayTime extends StatelessWidget {
  const PrayTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "السَّلاَمُ عَلَيْكُمْ",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .01),
          Text("${DateHelper.getWeekDay()} ${DateHelper.getHijriDate()}",
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          Text(DateHelper.getGregorianDate(),
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          const GetNextPrayer(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
