import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/home/widgets/custom_app_bar.dart';
import 'package:depiproject/features/home/widgets/pray_time.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor2,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            const CustomAppBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            const PrayTime()
          ],
        ),
      ),
    );
  }
}
