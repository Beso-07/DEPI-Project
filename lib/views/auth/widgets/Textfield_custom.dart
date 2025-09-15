import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatefulWidget {
  final bool? isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String lable;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    required this.controller,
    required this.lable,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword! ? obscureText : false,
          obscuringCharacter: "*",
          validator: widget.validator,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            enabledBorder: myBorder(),
            focusedBorder: myBorder(),
            errorBorder: myBorder(),
            hintText: widget.lable,
            hintTextDirection: TextDirection.rtl,
            prefixIcon: !widget.isPassword!
                ? null
                : InkWell(
                    onTap: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                    child: obscureText
                        ? const Icon(
                            FontAwesomeIcons.eyeSlash,
                            size: 22,
                          )
                        : const Icon(
                            FontAwesomeIcons.eye,
                            size: 22,
                          ),
                  ),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder myBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    );
  }
}
