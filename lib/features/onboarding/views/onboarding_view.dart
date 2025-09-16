import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/onboarding_data.dart';
import 'package:depiproject/features/Auth/views/login_screen.dart';
import 'package:depiproject/features/Auth/widgets/Button_custom.dart';
import 'package:depiproject/features/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            OnboardingItem(
              title: onBoardingData[index]["title"]!,
              text: onBoardingData[index]["text"]!,
              img: onBoardingData[index]["image"]!,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (dotIndex) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: Image.asset(
                    Imagespath.dot,
                    width: 10,
                    color: index == dotIndex ? Colors.green : Colors.grey,
                  ),
                );
              }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            CustomButton(
              title: index != 2 ? ' التالي' : ' ابدأ',
              onTap: () {
                setState(() {
                  if (index < onBoardingData.length - 1) {
                    index++;
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                });
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
          ],
        ),
      ),
    );
  }
}
