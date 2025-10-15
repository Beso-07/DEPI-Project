import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/get_next_prayer.dart';
import 'package:depiproject/features/prayers_time/views_model/prayer_cubit/prayer_cubit.dart';
import 'package:depiproject/features/prayers_time/views/widgets/day_row.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/prayers_time/views/widgets/prayers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerView extends StatelessWidget {
  const PrayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => PrayerCubit()..getPrayerTimes(),
      child: Scaffold(
        body: Column(
          children: [
            const MainAppBar(
              title: 'مواقيت الصلاة',
            ),
            SizedBox(height: height * .05),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const GetNextPrayer(),
                SizedBox(height: height * .01),
                const DayRow(),
                const PrayersList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
