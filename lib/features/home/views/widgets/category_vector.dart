import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Azkar/views/Azkar_view.dart';
import 'package:depiproject/features/ahadith/views/rawi_name_view.dart';
import 'package:depiproject/features/home/views/widgets/category_item.dart';
import 'package:depiproject/features/prayers_time/views/prayer_view.dart';
import 'package:flutter/material.dart';

import '../../../Quran/views/quran_content.dart';

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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuranContent()),
                        );
                      }),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'الأذكار',
                      img: Imagespath.azkar,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AzkarCategoriesView()),
                        );
                      }),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'مواقيت الصلاة',
                      img: Imagespath.prayer,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrayerView()),
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
                      text: 'احاديث', img: Imagespath.hadith, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RawiNameView()),
                        );

                      }),
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
