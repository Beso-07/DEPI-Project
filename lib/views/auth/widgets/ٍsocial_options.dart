import 'package:flutter/material.dart';

class SocialOptions extends StatelessWidget {
  final String icon;
  final void Function() action;
  const SocialOptions({super.key, required this.icon, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white),
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            icon,
            width: 50,
          )),
    );
  }
}
