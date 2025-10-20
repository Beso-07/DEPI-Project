import 'package:depiproject/features/prayers_time/views_model/prayer_cubit/prayer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/core/helpers/date_helper.dart';

class GetNextPrayer extends StatelessWidget {
  const GetNextPrayer({
    super.key,
    this.color,
  });
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerCubit()..getPrayerTimes(),
      child: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoaded) {
            final text = DateHelper.getNextPrayer(state.prayerTime);
            return Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
