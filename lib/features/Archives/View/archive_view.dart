// main_archive_view.dart
import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/helpers/hive_helper.dart';

import 'package:depiproject/features/Azkar/views/azkar_Details_Screen.dart';
import 'package:flutter/material.dart';
import 'package:depiproject/features/Archives/View/widget/build_card.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "المحفوظات",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Lateef',
              fontSize: 45,
              color: Colors.green),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ستجد كل ما حفظته هنا",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                children: [
                  buildCard(
                    title: "أدعية",
                    icon: Imagespath.doaa,
                    ontap: () {},
                  ),
                  buildCard(
                    title: "سور",
                    icon: Imagespath.quran,
                    ontap: () {},
                  ),
                  buildCard(
                    title: "أحاديث",
                    icon: Imagespath.hadith,
                    ontap: () {},
                  ),
                  buildCard(
                    title: "أذكار",
                    icon: Imagespath.azkar,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AzkarDetailsScreen(
                                  title: "أذكار",
                                  list: HiveHelper.azkar,
                                )),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
