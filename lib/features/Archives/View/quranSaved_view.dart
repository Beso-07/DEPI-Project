import 'package:flutter/material.dart';
import 'package:depiproject/features/Quran/views/widgets/sura_widget.dart';
import 'package:depiproject/features/Quran/models/quran_model.dart';
import 'package:depiproject/features/Quran/views/quran_page.dart';

class SavedSurahsScreen extends StatelessWidget {
  final List<Surah> list;

  const SavedSurahsScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "السور المحفوظة",
          style: TextStyle(
            fontFamily: 'Lateef',
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: list.isEmpty
          ? const Center(
              child: Text(
                "لا توجد سور محفوظة بعد",
                style: TextStyle(fontSize: 22, color: Colors.black54),
              ),
            )
          : GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // عدد الأعمدة
                crossAxisSpacing: 7,
                mainAxisSpacing: 5,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final surah = list[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuranPage(surah: surah),
                      ),
                    );
                  },
                  child: SuraWidget(
                    suraName: surah.name ?? 'سورة',
                    surah: surah,
                  ),
                );
              },
            ),
    );
  }
}
