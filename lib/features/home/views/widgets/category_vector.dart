import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Azkar/views/azkar_view.dart';
import 'package:depiproject/features/Quran/views/quran_content.dart';
import 'package:depiproject/features/ahadith/view/rawi_name_view.dart';
import 'package:depiproject/features/calender/views/calender_view.dart';
import 'package:depiproject/features/home/views/widgets/category_item.dart';
import 'package:depiproject/features/prayers_time/views/prayer_view.dart';
import 'package:depiproject/features/qiblah/views/qiblah_view.dart';
import 'package:depiproject/features/tasbeh/model_view/cubit/tasabeh_cubit.dart'
    show TasabehCubit;
import 'package:depiproject/features/tasbeh/view/tasbeh.dart' show Tasbeh;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                              builder: (context) => const QuranContent()),
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
                          MaterialPageRoute(
                              builder: (context) => const PrayerView()),
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
                      text: 'احاديث',
                      img: Imagespath.hadith,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RawiNameView()),
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
                      text: 'التسبيح',
                      img: Imagespath.sebha,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => TasabehCubit(),
                              child: Tasbeh(),
                            ),
                          ),
                        );
                      }),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'القبلة',
                      img: Imagespath.qibla,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QiblahView()),
                        );
                      }),
                  const VerticalDivider(color: Colors.grey),
                  CategoryItem(
                      text: 'التقويم',
                      img: Imagespath.timing,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CalenderView();
                        }));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
