import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/home/widgets/hadith_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RawiAhadithView extends StatelessWidget {
  const RawiAhadithView({super.key});

  @override
  Widget build(BuildContext context) {
   final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      
      child: Scaffold(
       
          appBar: HadithAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Container(
              height: height ,
              width: Width * 0.9,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                       
                      ),
                      hintText: 'ابحث عن حديث',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                       suffixIcon:const Padding(
                         padding: EdgeInsetsDirectional.only(end: 10),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search, color:AppColors.kPrimaryColor2),
                            SizedBox(width: 5,),
                             Icon(Icons.filter_list, color:AppColors.kPrimaryColor2),
                          ],
                         ),
                       )
                    ),
                  ),
                 SizedBox(height: height * 0.04,),
                 Expanded(
                     child:  ListView.separated(
                     shrinkWrap: true,
                     itemCount:10 ,
                     separatorBuilder: (BuildContext context, int index) { 
                    return SizedBox(height: height * 0.02,);
                     }, itemBuilder: (BuildContext context, int index) { 
                    return  const HadithCard(num: 1, content: """
                       قال رجل للنبي ﷺ :
                       " يا رسول الله، من أحقُّ النَّاسِ بحسن صحابتي؟
                       قالَ: أُمُّكَ. قَالَ: ثُمَّ مَن؟ قَالَ: ثُمَّ أُمُّكَ. قَالَ: ثُمَّ مَن؟
                       قال : ثمَّ أُمُّكَ. قَالَ: ثُمَّ مَن؟ قال: ثم أبوك."
                       
                         (رواه البخاري)
                       """, name: 'احمد بن حنبل', count: 1763,);
                 },
               )
              
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

