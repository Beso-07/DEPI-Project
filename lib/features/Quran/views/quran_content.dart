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

class _QuranContentState extends State<QuranContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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
        backgroundColor: Colors.white,
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

            SizedBox(height: searchQuery.isNotEmpty ? 8 : 0),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lateef',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Lateef',
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                tabs: const [
                  Tab(text: 'حزب'),
                  Tab(text: 'جزء'),
                  Tab(text: 'سورة'),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(controller: _tabController, children: [
              const Text('حزب'),
              const Text('جزء'),
              BlocBuilder<QuranCubit, QuranState>(
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
              )
            ]))
          ],
        ),
      ),
    );
  }
}

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           leading: InkWell(
//               onTap: () => Navigator.pop(context),
//               child: Icon(Icons.arrow_back)),
//           title: Text(
//             'القران الكريم',
//             style: TextStyle(fontFamily: 'Lateef', fontSize: 35),
//           ),
//           actions: [
//             Icon(Icons.settings),
//             SizedBox(width: 10),
//           ]),
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.all(16),
//             child: TextField(
//               textDirection: TextDirection.ltr, // لجعل النص يبدأ من اليسار
//               textAlign: TextAlign.left,
//               decoration: InputDecoration(
//                 hint: Text('search',
//                     style: TextStyle(fontFamily: 'Lateef', fontSize: 25),
//                     textAlign: TextAlign.left),
//                 suffixIcon: Icon(Icons.search),
//                 border: InputBorder.none,
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(18),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: TabBar(
//               controller: _tabController,
//               indicator: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               indicatorSize: TabBarIndicatorSize.tab,
//               dividerColor: Colors.transparent,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.grey[600],
//               labelStyle: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Lateef',
//               ),
//               unselectedLabelStyle: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.normal,
//                 fontFamily: 'Lateef',
//               ),
//               labelPadding: EdgeInsets.symmetric(horizontal: 4),
//               tabs: [
//                 Tab(text: 'حزب'),
//                 Tab(text: 'جزء'),
//                 Tab(text: 'سورة'),
//               ],
//             ),
//           ),
//           Expanded(
//               child: TabBarView(controller: _tabController, children: [
//             Container(child: Text('حزب')),
//             Container(child: Text('جزء')),
//             GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 5,
//               ),
//               itemCount: 114,
//               itemBuilder: (context, index) => sura_widget(),
//             )
//           ]))
//         ],
//       ),
//     );
//   }
// }
