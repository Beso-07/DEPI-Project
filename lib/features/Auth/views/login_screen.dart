import 'package:depiproject/core/constants/app_string.dart';
import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Auth/views/signup_screen.dart';
import 'package:depiproject/features/Auth/widgets/Button_custom.dart';
import 'package:depiproject/features/Auth/widgets/Textfield_custom.dart';
import 'package:depiproject/features/Auth/widgets/line_widget.dart';
import 'package:depiproject/features/Auth/widgets/social_option.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                const Text(
                  "تسجيل الدخول ",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Column(
                  children: [
                    const Text(
                      AppString.appNameER,
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Lateef',
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Image.asset(Imagespath.logo2,
                        width: 50, color: Colors.green)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                CustomTextField(
                  controller: _nameTextController,
                  lable: "البرد الالكتروني ",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "! يجب ادخال اسمك ";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Text(
                          "نسيت كلمة المرور ؟",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lateef',
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                CustomButton(
                  title: "تسجيل الدخول",
                  onTap: () {
                    if (_key.currentState!.validate()) {}
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                const LineWidget(text: "تسجيل الدخول بوسطة"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialOptions(icon: Imagespath.facebook, onTap: () {}),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                    ),
                    SocialOptions(icon: Imagespath.google, onTap: () {}),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                          );
                        },
                        child: const Text("انشاء حساب جديد",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lateef',
                              decorationColor: Colors.green,
                              decorationThickness: 4,
                            ))),
                    const Text(
                      " ليس لديك حساب؟",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
