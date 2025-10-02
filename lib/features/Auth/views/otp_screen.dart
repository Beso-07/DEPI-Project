// ignore_for_file: unused_local_variable

import 'package:depiproject/features/Auth/views/forget_pass_screen.dart';
import 'package:depiproject/features/Auth/widgets/CostomOtpTextFormField.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  GlobalKey<FormState> global = GlobalKey();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
        // Responsive 
    double h=MediaQuery.sizeOf(context).height;
    double w=MediaQuery.sizeOf(context).width;
    
    return  Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: global,
            child: Column(
             children: [
              
              GestureDetector(
                onTap: () {
                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ForgetPassScreen(),), (route) => false,);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(left: w*.03 , top: w*.1),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(91, 158, 158, 158),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ),
              ),
        
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:  EdgeInsets.only(top: w*.08 , right: w*.07),
                  child: Text("التحقق من الايميل الالكتروني" , style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                )),
        
        
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: w*.07 , vertical: h*.025),
                    child: Text(
                      "تم ارسال لينك الي الايميل الخاص بك ادخل الكود للتحق من الايميل" ,
                      textAlign: TextAlign.center,
                      maxLines: 2
                      ,
                       style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                    ),),
                  )),
        
                   SizedBox(height: h * .025),
                  
                     Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CostomOtpTextFormField(
                      h: h,
                      w: w,
                      otpControler: otp1,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    CostomOtpTextFormField(
                      h: h,
                      w: w,
                      otpControler: otp2,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                    CostomOtpTextFormField(
                      h: h,
                      w: w,
                      otpControler: otp3,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                    CostomOtpTextFormField(
                      h: h,
                      w: w,
                      otpControler: otp4,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                     CostomOtpTextFormField(
                      h: h,
                      w: w,
                      otpControler: otp5,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                   
                  ],
                ),
              ),
              

                  SizedBox(height: h * .035),

              // Login Button
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (global.currentState!.validate()) {
                     
                    }
                  },

                  child: Container(
                    height: 40,
                    width: w * .5,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 24, 118, 195),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "  تاكيد الكود",
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * .035),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "لم تتلقي اي بعد ؟",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ForgetPassScreen(),), (route) => false,);
                    },
                    child: Text(
                      textAlign: TextAlign.start,
                      "اعاده ارسال الايميل",
                      style: TextStyle(color:Color.fromARGB(255, 50, 111, 160), fontSize: 17),
                    ),
                  ),
                ],
              ),
             ],
                  )),
        ),
      ),
    );
  }
}