import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/helpers/notification_helper.dart';
import 'package:depiproject/features/home/views/widgets/category_vector.dart';
import 'package:depiproject/features/home/views/widgets/custom_drawer.dart';
import 'package:depiproject/features/home/views/widgets/home_app_bar.dart';
import 'package:depiproject/features/home/views/widgets/pray_time.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          // ElevatedButton(
          //   onPressed: () async {
          //     // ShowLocalNotification().shownotificaton('local', 'notify');
          //   },
          //   child: const Text('Show Notification'),
          // ),
          SizedBox(
            height: height * .15,
          ),
          const CategoryVector()
        ],
      ),
    );
  }
}
