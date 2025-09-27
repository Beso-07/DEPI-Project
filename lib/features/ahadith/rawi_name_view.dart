import 'dart:convert';

import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/ahadith/rawi_ahadith_view.dart';
import 'package:depiproject/features/home/widgets/rawi_hadith_card.dart';
import 'package:flutter/material.dart';

class RawiNameView extends StatelessWidget {
  const RawiNameView({super.key});

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    List<int> hadithCounts = [1763, 878, 3204, 4281, 88, 352];
    List<String> rawiNames = [
      "احمد بن حمبل",
      "الالبانى",
      "البخارى ",
      "صحيح مسلم",
      "ابو حنيفة النعمان",
      "الشافعى"
    ];  
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: HadithAppBar(),
          body: ListView.separated(
             itemCount: 6,
            itemBuilder:(context,index)=> RawiHadithCard( rawiName: [rawiNames[index]],
             hadithCounts: [hadithCounts[index]],
              pageName: const RawiAhadithView(),), 
            separatorBuilder: (context,index){
              return SizedBox(height: height * 0.01,);
            },
            )
          )
      
    );
  }
}

 AppBar HadithAppBar(){
  return AppBar(
            leading: const Padding(
              padding: EdgeInsetsDirectional.only(start: 10),
              child:   Icon(Icons.arrow_back_sharp, color: Colors.black,),
              ),
            title: const Padding(
              padding: EdgeInsetsDirectional.only(start: 90),
              child: Text("أحاديث", 
              style: TextStyle(color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
              ),),
            ),
            actions: const [
               Padding(
                padding: EdgeInsetsDirectional.only(end: 20),
                child: Icon(Icons.settings, color: Colors.black,),
              )
             
            ],
        );
}

