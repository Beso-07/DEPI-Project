import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/Quran/models/quran_model.dart';
import 'package:depiproject/features/Quran/model_view/cubit/quran_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class QuranPage extends StatefulWidget {
  final Surah surah;

  const QuranPage({super.key, required this.surah});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<Verse> verses = [];
  bool isLoading = true;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadVerses();
  }

  Future<void> loadVerses() async {
    if (widget.surah.id != null) {
      final cubit = QuranCubit();
      final loadedVerses = await cubit.loadSurahVerses(widget.surah.id!);
      setState(() {
        verses = loadedVerses;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit(),
      child: Scaffold(
        body: Column(
          children: [
            MainAppBar(title: widget.surah.name ?? 'سورة'),

            if (!isLoading &&
                verses.isNotEmpty &&
                (verses.length / 10).ceil() > 1)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (pageController.hasClients) {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.green.shade800,
                      ),
                      child: const Text('السابقة'),
                    ),
                    Text(
                      widget.surah.totalVerses! < 10
                          ? '${widget.surah.totalVerses} آيات ${widget.surah.type} '
                          : '${widget.surah.totalVerses} آيه ${widget.surah.type} ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade600,
                      ),
                    ),
                    BlocBuilder<QuranCubit, QuranState>(
                      builder: (context, state) {
                        final cubit = context.watch<QuranCubit>();

                        final isSaved = cubit.isSaved(widget.surah);
                        return IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? Colors.green : Colors.grey,
                          ),
                          onPressed: () async {
                            await cubit.toggleSave(widget.surah);
                            setState(() {});
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (pageController.hasClients) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.green.shade800,
                      ),
                      child: const Text('التالية'),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 8),

            // Verses Section
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : verses.isEmpty
                      ? const Center(child: Text('لا توجد آيات متاحة'))
                      : PageView.builder(
                          controller: pageController,
                          itemCount:
                              (verses.length / 10).ceil(), // 10 verses per page
                          itemBuilder: (context, pageIndex) {
                            int startIndex = pageIndex * 10;
                            int endIndex = (startIndex + 10 > verses.length)
                                ? verses.length
                                : startIndex + 10;

                            List<Verse> pageVerses =
                                verses.sublist(startIndex, endIndex);

                            return Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  // Page Number
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'صفحة ${pageIndex + 1} من ${(verses.length / 10).ceil()}',
                                      style: TextStyle(
                                        color: Colors.green.shade800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Verses
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          // Add Basmala for first page (except At-Tawbah)
                                          if (pageIndex == 0 &&
                                              widget.surah.id != 9)
                                            Container(
                                              width: double.infinity,
                                              margin: const EdgeInsets.only(
                                                  bottom: 16),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        Colors.green.shade200),
                                              ),
                                              child: Text(
                                                'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                  fontFamily: 'Lateef',
                                                  fontSize: 28,
                                                  color: Colors.green.shade800,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                          // Verses
                                          ...pageVerses.map((verse) {
                                            return Container(
                                              width: double.infinity,
                                              margin: const EdgeInsets.only(
                                                  bottom: 16),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Verse Number
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.green.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Text(
                                                      '${verse.verse}',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .green.shade800,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),

                                                  // Verse Text
                                                  ListTile(
                                                    title: Text(
                                                      verse.text ?? '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: const TextStyle(
                                                        fontFamily: 'Lateef',
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.8,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.share,
                                                          color:
                                                              Colors.blueGrey),
                                                      onPressed: () async {
                                                        await Share.share(
                                                          verse.text ?? '',
                                                          subject:
                                                              'ايه من تطبيق تقوي 📿',
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
