import 'package:depiproject/core/constants/assets.dart';
import 'package:flutter/material.dart';


class sura_widget extends StatelessWidget {
  const sura_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child:Stack(
      alignment: Alignment.center,
      children:[
       Image.asset(Imagespath.sura,height: 100,width: 100,),
       Image.asset(Imagespath.sura,height: 90,width: 90,),
    Text('سورة',style: TextStyle(
      fontFamily: 'Lateef',
      fontSize: 50
    
    ),)
    ]));
  }
}