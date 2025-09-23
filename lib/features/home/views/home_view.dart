import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/home/widgets/category_vector.dart';
import 'package:depiproject/features/home/widgets/custom_app_bar.dart';
import 'package:depiproject/features/home/widgets/pray_time.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor2,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 24),
            child: CustomAppBar(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PrayTime(),
          ),
          SizedBox(
            height: height * .05,
          ),
          const CategoryVector()
        ],
      ),
    );
  }
}
