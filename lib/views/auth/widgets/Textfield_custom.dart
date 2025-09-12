import 'package:depiproject/constants/imagesPath.dart';
import 'package:flutter/material.dart';

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
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(.2)),
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword! ? obscureText : false,
              obscuringCharacter: "*",
              validator: widget.validator,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
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
                            ? const ImageIcon(
                                AssetImage(Imagespath.logo),
                              )
                            : const ImageIcon(
                                AssetImage(Imagespath.logo),
                              ),
                      ),
                border: InputBorder.none,
              ),
            )),
      ],
    );
  }
}
