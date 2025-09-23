import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/home/widgets/category_item.dart';
import 'package:depiproject/features/prayer_time/views/prayer_time_view.dart';
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
            Expanded(
              child: Row(
                children: [
                  CategoryItem(
                      text: 'القران الكريم',
                      img: Imagespath.quran,
                      onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'الأذكار', img: Imagespath.azkar, onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'مواقيت الصلاة',
                      img: Imagespath.prayer,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrayerTimeView()),
                        );
                      }),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            // second row
            Expanded(
              child: Row(
                children: [
                  CategoryItem(
                      text: 'الأدعية', img: Imagespath.doaa, onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'احاديث', img: Imagespath.hadith, onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'قصص الأنبياء',
                      img: Imagespath.story,
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
                      text: 'التسبيح', img: Imagespath.sebha, onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القبلة', img: Imagespath.qibla, onTap: () {}),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'التقويم', img: Imagespath.timing, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
