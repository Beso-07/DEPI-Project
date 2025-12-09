import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/home/views/widgets/category_vector.dart';
import 'package:depiproject/features/home/views/widgets/custom_drawer.dart';
import 'package:depiproject/features/home/views/widgets/home_app_bar.dart';
import 'package:depiproject/features/home/views/widgets/pray_time.dart';
import 'package:depiproject/features/prayers_time/views_model/prayer_cubit/prayer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => PrayerCubit()..getPrayerTimes(),
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor2,
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 24),
              child: HomeAppBar(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: PrayTime(),
            ),
            SizedBox(
              height: height * .15,
            ),
            const CategoryVector()
          ],
        ),
      ),
    );
  }
}

// RefreshIndicator(
//           onRefresh: () async {
//             await Future.delayed(const Duration(seconds: 1), () {
//               setState(() {});
//             });
//           },
//           child: ListView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16, right: 16, top: 24),
//                   child: HomeAppBar(),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * .01,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: PrayTime(),
//                 ),
//                 SizedBox(
//                   height: height * .15,
//                 ),
//               ]),
//         )
