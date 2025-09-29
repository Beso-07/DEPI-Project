import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/features/Quran/views/widgets/sura_widget.dart';
import 'package:flutter/material.dart';

class QuranContent extends StatefulWidget {
  const QuranContent({super.key});

  @override
  State<QuranContent> createState() => _QuranContentState();
}

class _QuranContentState extends State<QuranContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back)),
          title: Text(
            'القران الكريم',
            style: TextStyle(fontFamily: 'Lateef', fontSize: 35),
          ),
          actions: [
            Icon(Icons.settings),
            SizedBox(width: 10),
          ]),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
              textDirection: TextDirection.ltr, // لجعل النص يبدأ من اليسار
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hint: Text('search',
                    style: TextStyle(fontFamily: 'Lateef', fontSize: 25),
                    textAlign: TextAlign.left),
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(18),
            ),
          ),
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
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 114,
              itemBuilder: (context, index) => sura_widget(),
            )
          ]))
        ],
      ),
    );
  }
}
