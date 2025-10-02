import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem(
      {super.key, required this.title, required this.text, required this.img});
  final String title;
  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: 220,
        ),
        SizedBox(
          height: height * .05,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: height * .015,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
