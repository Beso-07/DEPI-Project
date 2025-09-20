import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/home/widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoryVector extends StatelessWidget {
  const CategoryVector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            // First row
            Expanded(
              child: Row(
                children: [
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            // second row
            Expanded(
              child: Row(
                children: [
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            // third row
            Expanded(
              child: Row(
                children: [
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.logo,
                      onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
