import 'package:depiproject/constants/imagesPath.dart';
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
    Future.delayed(const Duration(seconds: 2), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const OnboardingView()),
      // );
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
            Text(
              'الذكر',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Lateef',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Image.asset(Imagespath.logo, width: 90, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
