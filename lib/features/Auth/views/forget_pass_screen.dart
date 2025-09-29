// ignore_for_file: unused_local_variable, sort_child_properties_last, body_might_complete_normally_nullable

import 'package:depiproject/features/Auth/views/login_screen.dart';
import 'package:depiproject/features/Auth/views/otp_screen.dart';
import 'package:flutter/material.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  TextEditingController email = TextEditingController();
  GlobalKey<FormState> global = GlobalKey();

  @override
  Widget build(BuildContext context) {

    // Responsive 
    double h=MediaQuery.sizeOf(context).height;
    double w=MediaQuery.sizeOf(context).width;

    
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: global,
            child: Column(
             children: [
              
              GestureDetector(
                  onTap: () {
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
                    ////////////////////////
                },
                child: Align(
                  alignment: AlignmentGeometry.topLeft,
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
                alignment: AlignmentGeometry.topRight,
                child: Padding(
                  padding:  EdgeInsets.only(top: w*.08 , right: w*.07),
                  child: Text("اعاده تعيين كلمه المرور" , style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                )),
        
        
                Align(
                  alignment: AlignmentGeometry.topRight,
                  child: Padding(
                    padding:  EdgeInsets.only(right:w*.07 , top: w*.02 ),
                    child: Text("ادخل الايميل لتستطيع استعاده كلمه المرور" , style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                    ),),
                  )),
        
                   SizedBox(height: h * .025),
        
                // Email TextFormField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "يجب ادخال الايميل الالكتروني ";
                      }
                      if (!value.contains("@")) {
                        return "الايميل يجب ان يكون مثل example@gmail.com";
                      }
                    },
                    // inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 207, 205, 205)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 207, 205, 205)),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      label: Text(" الايميل الالكتروني"),
                      labelStyle: TextStyle(
                        color:Colors.grey,
                        fontSize: 18,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color:Colors.grey,
                      ),
                    ),
                  ),
                ),

                  SizedBox(height: h * .035),

              // Login Button
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (global.currentState!.validate()) {
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OtpScreen(),), (route) => false,);
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
                        " اعاده الارسال",
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
             ],
                  )),
        ),
      ),
    );
  }
}