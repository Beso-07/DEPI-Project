import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea (
        child: Center(
          child: InkWell(
            // onTap: () {
            //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OnboargingScreen()));
            //   setState(() { });
            // },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/photo.png',fit: BoxFit.cover,),
            ),
          ),
        ),
      ),);
  }
}

