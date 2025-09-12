import 'package:depiproject/views/auth/login_screen.dart';
import 'package:depiproject/views/splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(IslamicApp());
}

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
