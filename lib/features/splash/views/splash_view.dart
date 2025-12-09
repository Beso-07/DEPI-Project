import 'package:depiproject/core/constants/app_string.dart';
import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => 
            // HiveHelper.isOnboardingSeen
            //     ? const HomeView()
                const OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppString.appNameAR,
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Image.asset(Imagespath.logo2, width: 90, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
