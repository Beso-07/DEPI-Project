import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget buildCard(
    {required String title,
    required String icon,
    required void Function() ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.kPercentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(AssetImage(icon), color: Colors.green, size: 40),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}
