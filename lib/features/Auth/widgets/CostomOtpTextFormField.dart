import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CostomOtpTextFormField extends StatelessWidget {
  const CostomOtpTextFormField({
    super.key,
    required this.h,
    required this.w,
    required this.otpControler,
    required this.onChanged,
  });

  final double h;
  final double w;
  final TextEditingController otpControler;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h * .07,
      width: w * .15,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        controller: otpControler,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
