import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Quran/models/quran_model.dart';
import 'package:depiproject/features/Quran/views/quran_page.dart';
import 'package:flutter/material.dart';

class SuraWidget extends StatelessWidget {
  const SuraWidget({
    super.key,
    required this.suraName,
    required this.surah,
  });

  final String suraName;
  final Surah surah;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranPage(surah: surah),
          ),
        );
      },
      child: Stack(alignment: Alignment.center, children: [
        Image.asset(
          Imagespath.sura,
          height: 100,
          width: 110,
        ),
        Text(
          suraName,
          style: const TextStyle(
              fontFamily: 'Lateef',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        )
      ]),
    );
  }
}
