import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Archives/View/quranSaved_view.dart';
import 'package:depiproject/features/Archives/View/saved_doaa_screen.dart';
import 'package:depiproject/features/Archives/model_view/cubit/archive_cubit.dart';
import 'package:depiproject/features/Archives/model_view/cubit/archive_state.dart';
import 'package:depiproject/features/Azkar/views/azkar_Details_Screen.dart';
import 'package:depiproject/features/ahadith/view/ahadith_details.dart';
import 'package:depiproject/features/Archives/View/widget/build_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchiveCubit()..loadArchives(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "المحفوظات",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Lateef',
              fontSize: 26,
            ),
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
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: BlocBuilder<ArchiveCubit, ArchiveState>(
                  builder: (context, state) {
                    if (state is ArchiveLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ArchiveLoaded) {
                      return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                        children: [
                          buildCard(
                            title: "أدعية",
                            icon: Imagespath.doaa,
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SavedDoaaScreen(),
                                ),
                              );
                            },
                          ),
                          buildCard(
                            title: "سور",
                            icon: Imagespath.quran,
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SavedSurahsScreen(
                                    list: state.quran,
                                  ),
                                ),
                              );
                            },
                          ),
                          buildCard(
                            title: "أحاديث",
                            icon: Imagespath.hadith,
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RawiAhadithView(
                                    title: "أحاديث",
                                    list: state.ahadith,
                                  ),
                                ),
                              );
                            },
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
                                    list: state.azkar,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('حدث خطأ أثناء تحميل المحفوظات'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
