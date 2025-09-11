import 'package:depiproject/constants/imagesPath.dart';
import 'package:depiproject/constants/onboarding_data.dart';
import 'package:depiproject/views/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(Imagespath.onboarding, fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnboardingItem(
                title: onBoardingData[currentPage]["title"]!,
                text: onBoardingData[currentPage]["text"]!,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  setState(() {
                    if (currentPage < onBoardingData.length - 1) {
                      currentPage++;
                    } else {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginView()),
                      // );
                    }
                  });
                },
                child: Text(
                  currentPage == onBoardingData.length - 1 ? "ابدأ" : "التالي",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
