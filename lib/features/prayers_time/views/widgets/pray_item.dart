import 'package:flutter/material.dart';

class PrayItem extends StatelessWidget {
  const PrayItem({super.key, required this.title, required this.time});
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.sunny),
          Text(
            time,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
