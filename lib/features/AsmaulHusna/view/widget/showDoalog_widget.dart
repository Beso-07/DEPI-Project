import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context,
    {required String title, required String text}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColors.kPrimaryColor2,
            ),
          ),
        ),
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.kPrimaryColor,
          ),
        ),
      );
    },
  );
}
