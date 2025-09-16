import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem(
      {super.key, required this.title, required this.text, required this.img});
  final String title;
  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: 350,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .015,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
