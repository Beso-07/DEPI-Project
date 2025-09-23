import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/prayer_time/model_view/prayer_time_cubit/prayer_time_cubit.dart';
import 'package:depiproject/features/prayer_time/models/prayer_time_model/prayer_time_model.dart';
import 'package:depiproject/features/prayer_time/views/widgets/main_app_bar.dart';
import 'package:depiproject/features/prayer_time/views/widgets/pray_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerTimeView extends StatelessWidget {
  const PrayerTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => PrayerTimeCubit()..getPrayerTimes(),
      child: Scaffold(
        body: BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
          builder: (context, state) {
            if (state is PrayerTimeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PrayerTimeSuccess) {
              final model = state.prayerTimeModel;
              return Column(
                children: [
                  const MainAppBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.kPrayerTimeColor),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'مصر - القاهرة',
                            style: TextStyle(fontSize: 26),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.location_on_outlined)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    model.date.hijri.weekday.ar,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.kPrimaryColor),
                  ),
                  SizedBox(height: height * .03),
                  //Dates
                  DayRow(model: model),
                  SizedBox(height: height * .05),
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        PrayItem(
                          title: 'الفجر',
                          time: model.timings.fajr,
                        ),
                        const Divider(),
                        PrayItem(
                          title: 'الظهر',
                          time: model.timings.dhuhr,
                        ),
                        const Divider(),
                        PrayItem(
                          title: 'العصر',
                          time: model.timings.asr,
                        ),
                        const Divider(),
                        PrayItem(
                          title: 'المغرب',
                          time: model.timings.maghrib,
                        ),
                        const Divider(),
                        PrayItem(
                          title: 'العشاء',
                          time: model.timings.isha,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is PrayerTimeFailure) {
              return Center(child: Text(state.errMessage));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class DayRow extends StatelessWidget {
  const DayRow({
    super.key,
    required this.model,
  });

  final PrayerTimeModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.kPrayerTimeColor),
          child: Text(
            "${model.date.hijri.day} ${model.date.hijri.month.ar} ${model.date.hijri.year}",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.kPrayerTimeColor),
          child: Text(
            "${model.date.gregorian.day} ${model.date.gregorian.monthG.en} ${model.date.gregorian.year}" ??
                "",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
