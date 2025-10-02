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
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..loadQuranData(),
      child: Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     leading: InkWell(
      //         onTap: () => Navigator.pop(context),
      //         child: Icon(Icons.arrow_back)),
      //     title: Text(
      //       'القران الكريم',
      //       style: TextStyle(fontFamily: 'Lateef', fontSize: 35),
      //     ),
      //     actions: [
      //       Icon(Icons.settings),
      //       SizedBox(width: 10),
      //     ]),
      body: Column(
        children: [
          MainAppBar(title: 'القران الكريم'),
          Container(
            margin: EdgeInsets.all(16),
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
                hintText: 'ابحث عن اسم السورة...',
                hintStyle: TextStyle(fontFamily: 'Lateef', fontSize: 18),
                suffixIcon: Icon(Icons.search),
                prefixIcon: searchQuery.isNotEmpty 
                    ? IconButton(
                        icon: Icon(Icons.clear),
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
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          
          // Search Results Info
          if (searchQuery.isNotEmpty)
            BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                if (state is QuranLoaded) {
                  final filteredCount = state.surahs.where((surah) {
                    final surahName = surah.name?.toLowerCase() ?? '';
                    final transliteration = surah.transliteration?.toLowerCase() ?? '';
                    final surahId = surah.id?.toString() ?? '';
                    final query = searchQuery.toLowerCase();
                    return surahName.contains(query) || 
                           transliteration.contains(query) ||
                           surahId.contains(query);
                  }).length;
                  
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                return SizedBox.shrink();
              },
            ),
          
          SizedBox(height: searchQuery.isNotEmpty ? 8 : 0),
          
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              labelStyle: TextStyle(
              
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lateef',
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                fontFamily: 'Lateef',
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 4),
              tabs: [
                Tab(text: 'حزب'),
                Tab(text: 'جزء'),
                Tab(text: 'سورة'),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            Container(child: Text('حزب')),
            Container(child: Text('جزء')),
            BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                if (state is QuranLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is QuranError) {
                  return Center(child: Text('حدث خطأ: ${state.message}'));
                } else if (state is QuranLoaded) {
                  // Filter surahs based on search query
                  final filteredSurahs = searchQuery.isEmpty
                      ? state.surahs
                      : state.surahs.where((surah) {
                          final surahName = surah.name?.toLowerCase() ?? '';
                          final transliteration = surah.transliteration?.toLowerCase() ?? '';
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
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'لا توجد نتائج للبحث عن "$searchQuery"',
                            style: TextStyle(
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: filteredSurahs.length,
                    itemBuilder: (context, index) => sura_widget(
                      suraName: filteredSurahs[index].name ?? 'سورة',
                      surah: filteredSurahs[index],
                    ),
                  );
                } else {
                  return Center(child: Text('لا توجد بيانات'));
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
