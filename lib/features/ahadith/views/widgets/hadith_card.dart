import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';

class HadithCard extends StatelessWidget {
  const HadithCard({
    super.key,
    required this.num,
    required this.content,
    required this.name,
    required this.count
  });
  final int num;
  final String content;
  final String name;
  final int count;

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return  Expanded(
     child: SingleChildScrollView(
       child: Column( 
       children: [
        Row(
                    children: [
                      Text("رواه $name",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),
                      const Spacer(),
                      Text(count.toString(), style: const TextStyle(color: Color.fromARGB(255, 126, 124, 124),
                      fontWeight: FontWeight.w900,
                       ),
                       ),
                      SizedBox(height: height * 0.01,), 
                      const Text("حديث",style: TextStyle(color: Color.fromARGB(255, 126, 124, 124),
                      fontWeight: FontWeight.w900,
                      ),),
            
                    ],
                   ),
                   SizedBox(height: height * 0.02,),
                    Container(
                      height: height * 0.33,
                      width: Width,
                      decoration: BoxDecoration(
                         color: AppColors.kPrimaryColor3,
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                         )
                      ),
        
                       child:  Padding(
                         padding: const EdgeInsets.all(4),
                         child: Column(
                           children: [
                             Container(
                              height: height * 0.06,
                              width: Width,
                              decoration: BoxDecoration(
                                color: AppColors.kPrayerTimeColor,
                                borderRadius: BorderRadius.circular(10)
                             
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(" حديث رقم ",style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w800
                                    ),),
                                    const SizedBox(width: 5,),
                                    Stack(
                                      children: [
                                        
                                        Image.asset(Imagespath.ayah,height: 50,
                                        
                                        fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 8,
                                          top: 5,
                                          child:  Text(num.toString(),style: const TextStyle(fontWeight: FontWeight.w900,
                                        color: AppColors.kPrimaryColor2),),
                                        )
                                       
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.bookmark_border,color:AppColors.kPrimaryColor2,),
                                    const SizedBox(width: 10,),
                                     const Icon(Icons.copy,color:AppColors.kPrimaryColor2,),
                                    
                                  ],
                                 ),
                                 
                              ),
                               
                             ),
                              SizedBox(height: height * 0.02,),
                              Expanded(
                                
                                child: Text(content,
                                style: const TextStyle(color: AppColors.kPrimaryColor2,
                                fontWeight: FontWeight.w900),
                               
                                ),
                              ),
                              
                           ],
                         ),
                       ),
                     ),
       
       
       ]
                    
       
       ),
     ) 
      
    );
  }
}