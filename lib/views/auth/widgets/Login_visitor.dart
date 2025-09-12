import 'package:flutter/material.dart';

class LoginVisitor extends StatelessWidget {
  const LoginVisitor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: const Text(
          "الدخول كزائر",
          style: TextStyle(
            color: Colors.green,
            fontSize: 36,
            fontFamily: 'Lateef',
            decoration: TextDecoration.underline,
            decorationColor: Colors.green,
            decorationThickness: 4,
          ),
        ));
  }
}
