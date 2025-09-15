import 'package:flutter/material.dart';

class LoginVisitor extends StatelessWidget {
  final double? size;
  const LoginVisitor({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Text(
          "الدخول كزائر",
          style: TextStyle(
            color: Colors.green,
            fontSize: size ?? 36,
            fontFamily: 'Lateef',
            //decoration: TextDecoration.underline,
            decorationColor: Colors.green,
            decorationThickness: 4,
          ),
        ));
  }
}
