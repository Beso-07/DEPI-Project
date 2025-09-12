import 'package:depiproject/constants/imagesPath.dart';
import 'package:depiproject/views/auth/widgets/Login_visitor.dart';
import 'package:depiproject/views/auth/widgets/Textfield_custom.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "تسجيل الدخول ",
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Lateef',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 4, 238, 4),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Imagespath.onboarding), // الصورة
              fit: BoxFit.cover, // عشان تملأ الخلفية
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    "رتّل",
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Lateef',
                    ),
                  ),
                  Image.asset(Imagespath.logo,
                      width: 40, color: const Color.fromARGB(255, 0, 0, 0)),
                  const LoginVisitor()
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              widget("أو"),
              const SizedBox(height: 20),
              CustomTextField(controller: _nameTextController, lable: "اسمك"),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _passwordTextController,
                lable: "كلمة المرور",
                isPassword: true,
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "نسيت كلمة المرور ؟",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontFamily: 'Lateef',
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 7),
              widget("تسجيل الدخول يوسطة"),
              Expanded(
                  child: Row(
                children: [
                  Container(
                      child: const Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  )),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Row widget(String text) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey[180],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey[180],
          ),
        ),
      ],
    );
  }
}
