import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.notifications_outlined, color: Colors.white, size: 30),
        Spacer(),
        Icon(Icons.account_circle, color: Colors.white, size: 30),
      ],
    );
  }
}
