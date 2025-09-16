import 'package:flutter/material.dart';

class SocialOptions extends StatelessWidget {
  final String icon;
  final void Function() onTap;
  const SocialOptions({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white),
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            icon,
            width: 30,
          )),
    );
  }
}
