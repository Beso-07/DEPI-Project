import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.text,
    required this.img,
    this.onTap,
  });
  final String text;
  final String img;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                color: AppColors.kPrimaryColor,
                width: 40,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
