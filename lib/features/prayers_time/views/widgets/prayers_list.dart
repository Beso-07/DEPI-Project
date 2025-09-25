import 'package:depiproject/features/prayers_time/views_model/prayer_cubit/prayer_cubit.dart';
import 'package:depiproject/features/prayers_time/views/widgets/pray_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayersList extends StatelessWidget {
  const PrayersList({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        left: width * .05,
        right: width * .05,
        top: height * .05,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoaded) {
            final model = state.prayerTime;
            return Column(
              children: [
                PrayItem(title: 'الفجر', time: model.fajr),
                const Divider(),
                PrayItem(title: 'الظهر', time: model.dhuhr),
                const Divider(),
                PrayItem(title: 'العصر', time: model.asr),
                const Divider(),
                PrayItem(title: 'المغرب', time: model.maghrib),
                const Divider(),
                PrayItem(title: 'العشاء', time: model.isha),
              ],
            );
          } else if (state is PrayerLoading) {
            return const Column(
              children: [
                PrayItem(title: 'الفجر', time: ""),
                Divider(),
                PrayItem(title: 'الظهر', time: ""),
                Divider(),
                PrayItem(title: 'العصر', time: ''),
                Divider(),
                PrayItem(title: 'المغرب', time: ''),
                Divider(),
                PrayItem(title: 'العشاء', time: ''),
              ],
            );
          } else {
            return const Column(
              children: [
                PrayItem(title: 'الفجر', time: ""),
                Divider(),
                PrayItem(title: 'الظهر', time: ""),
                Divider(),
                PrayItem(title: 'العصر', time: ''),
                Divider(),
                PrayItem(title: 'المغرب', time: ''),
                Divider(),
                PrayItem(title: 'العشاء', time: ''),
              ],
            );
          }
        },
      ),
    );
  }
}
