import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Quran/models/quran_model.dart';
import 'package:depiproject/features/Quran/views/quran_page.dart';
import 'package:flutter/material.dart';


class sura_widget extends StatelessWidget {
  const sura_widget({
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
      child: Container(child:Stack(
        alignment: Alignment.center,
        children:[
         Image.asset(Imagespath.sura,height: 100,width: 100,),
         Image.asset(Imagespath.sura,height: 90,width: 90,),
      Text(suraName,style: TextStyle(
        fontFamily: 'Lateef',
        fontSize: 40
      
      ),)
      ])),
    );
  }
}