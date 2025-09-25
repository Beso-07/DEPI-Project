import 'package:depiproject/core/constants/app_string.dart';
import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Auth/views/login_screen.dart';
import 'package:depiproject/features/Auth/widgets/custom_bitton.dart';
import 'package:depiproject/features/Auth/widgets/custom_textfield.dart';
import 'package:depiproject/features/Auth/widgets/line_widget.dart';
import 'package:depiproject/features/Auth/widgets/social_option.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController =
      TextEditingController();
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
                  "انشاء حساب جديد",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Column(
                  children: [
                    const Text(
                      AppString.appNameAR,
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
                  controller: _emailTextController,
                  lable: "البريد الالكتروني ",
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
                CustomTextField(
                  controller: _passwordConfirmTextController,
                  lable: "تأكيد كلمة المرور ",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "كلمة المرور يجب ان تطابق كلمة المرور السابقة";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                CustomButton(
                  title: "انشاء حساب ",
                  onTap: () {
                    if (_key.currentState!.validate()) {}
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                const LineWidget(text: "انشاء حساب بواسطة"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialOptions(icon: Imagespath.facebook, onTap: () {}),
                    SocialOptions(icon: Imagespath.google, onTap: () {}),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      " لديك حساب بالفعل؟",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text(" تسجيل الدخول ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lateef',
                              decorationColor: Colors.green,
                              decorationThickness: 4,
                            ))),
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
