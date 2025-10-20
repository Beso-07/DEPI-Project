import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/Quran/views/widgets/sura_widget.dart';
import 'package:depiproject/features/Quran/model_view/cubit/quran_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranContent extends StatefulWidget {
  const QuranContent({super.key});

  @override
  State<QuranContent> createState() => _QuranContentState();
}

class _QuranContentState extends State<QuranContent> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..loadQuranData(),
      child: Scaffold(
        body: Column(
          children: [
            const MainAppBar(title: 'القران الكريم'),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                controller: searchController,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  hintText: 'ابحث عن اسم السورة...',
                  hintStyle:
                      const TextStyle(fontFamily: 'Lateef', fontSize: 18),
                  suffixIcon: const Icon(Icons.search),
                  prefixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                ),
              ),
            ),

            // Search Results Info
            if (searchQuery.isNotEmpty)
              BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  if (state is QuranLoaded) {
                    final filteredCount = state.surahs.where((surah) {
                      final surahName = surah.name?.toLowerCase() ?? '';
                      final transliteration =
                          surah.transliteration?.toLowerCase() ?? '';
                      final surahId = surah.id?.toString() ?? '';
                      final query = searchQuery.toLowerCase();
                      return surahName.contains(query) ||
                          transliteration.contains(query) ||
                          surahId.contains(query);
                    }).length;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Text(
                        'تم العثور على $filteredCount سورة',
                        style: TextStyle(
                          fontFamily: 'Lateef',
                          fontSize: 16,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

            Expanded(
              child: BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  if (state is QuranLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is QuranError) {
                    return Center(child: Text('حدث خطأ: ${state.message}'));
                  } else if (state is QuranLoaded) {
                    // Filter surahs based on search query
                    final filteredSurahs = searchQuery.isEmpty
                        ? state.surahs
                        : state.surahs.where((surah) {
                            final surahName = surah.name?.toLowerCase() ?? '';
                            final transliteration =
                                surah.transliteration?.toLowerCase() ?? '';
                            final surahId = surah.id?.toString() ?? '';
                            final query = searchQuery.toLowerCase();

                            return surahName.contains(query) ||
                                transliteration.contains(query) ||
                                surahId.contains(query);
                          }).toList();

                    if (filteredSurahs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'لا توجد نتائج للبحث عن "$searchQuery"',
                              style: const TextStyle(
                                fontFamily: 'Lateef',
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: filteredSurahs.length,
                      itemBuilder: (context, index) => SuraWidget(
                        suraName: filteredSurahs[index].name ?? 'سورة',
                        surah: filteredSurahs[index],
                      ),
                    );
                  } else {
                    return const Center(child: Text('لا توجد بيانات'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
