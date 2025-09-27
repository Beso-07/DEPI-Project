import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';

class RawiHadithCard extends StatelessWidget {
  const RawiHadithCard({
    super.key,
    required this.rawiName,
    required this.hadithCounts,
    required this.pageName
    
    
    });

    final List<String> rawiName;
    final List<int> hadithCounts;
    final  pageName ;

   

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;

    return  Padding(
          padding: const EdgeInsets.only(top:20,left: 10,right: 10),
          child: InkWell(
            onTap: (){
               Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageName),
      );
            },
            child: Container(
              height: height * 0.08,
              width: Width ,
              decoration: const BoxDecoration(
                color: AppColors.kPrayerTimeColor,
                borderRadius: BorderRadius.all(Radius.circular(20))
              
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Expanded(
                  child: Row(
                    children: [
                      Image.asset(Imagespath.story,color: AppColors.kPrimaryColor,),
                      SizedBox(width: Width * 0.03,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(rawiName.toString(),style: const TextStyle(color: AppColors.kPrimaryColor
                          ,fontWeight: FontWeight.w900,
                          fontFamily: " lateef-Bold"
                          ),),
                          const SizedBox(height: 5,),
                          Text("عدد الاحاديث: ${hadithCounts.toString()}",style: const TextStyle(
                            color: AppColors.kPrimaryColor2
                          ),)
                  
                        ],
                      )
                     
                    ],
                  ),
                ),
              ),
             
            ),
          ),
        );
      
      
  }
}

