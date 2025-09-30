import 'package:depiproject/constants/imagesPath.dart';
import 'package:depiproject/views/auth/sign_screen.dart';
import 'package:depiproject/views/auth/widgets/%D9%8Dsocial_options.dart';

import 'package:depiproject/views/auth/widgets/Login_visitor.dart';
import 'package:depiproject/views/auth/widgets/Textfield_custom.dart';
import 'package:flutter/material.dart';

import '../../features/Auth/widgets/custom_bitton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final _key = GlobalKey<FormState>();
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
        child: Form(
          key: _key,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Imagespath.onboarding),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
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
                  widget("أو"),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _nameTextController,
                    lable: "اسمك",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "! يجب ادخال اسمك ";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: _passwordTextController,
                    lable: "كلمة المرور",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "كلمة المرور يجب أن تكون 6 أحرف أو أكثر";
                      }

                      return null;
                    },
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
                  const SizedBox(height: 15),
                  CustomButton(
                    title: "تسجيل الدخول",
                    onTap: () {
                      if (_key.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 18),
                  widget("تسجيل الدخول يوسطة"),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialOptions(
                        icon: Imagespath.facebook,
                        action: () {},
                      ),
                      SocialOptions(
                        icon: Imagespath.google,
                        action: () {},
                      ),
                      SocialOptions(
                        icon: Imagespath.apple,
                        action: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignScreen()),
                            );
                          },
                          child: const Text("انشاء حساب جديد",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.green,
                                fontFamily: 'Lateef',
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.green,
                                decorationThickness: 4,
                              ))),
                      const Text("ليس لديك حساب؟")
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
