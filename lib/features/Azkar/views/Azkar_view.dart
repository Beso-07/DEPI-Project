import 'package:depiproject/features/Azkar/views/Azkar_Details_Screen.dart';
import 'package:flutter/material.dart';

class AzkarCategoriesView extends StatelessWidget {
  const AzkarCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"title": "أذكار الصباح", "icon": Icons.wb_sunny},
      {"title": "أذكار المساء", "icon": Icons.nights_stay},
      {"title": "أذكار النوم", "icon": Icons.bedtime},
      {"title": "أذكار الاستيقاظ", "icon": Icons.alarm},
      {"title": "أذكار بعد الصلاة", "icon": Icons.mosque},
      {"title": "تسابيح", "icon": Icons.favorite},
      {"title": "أدعية قرآنية", "icon": Icons.menu_book},
      {"title": "أدعية الأنبياء", "icon": Icons.person},
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
        title: const Text(
          "الأذكار",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final categorie = categories[index];

          return Card(
            color: Colors.green.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListTile(
                leading:
                    Icon(categorie["icon"] as IconData, color: Colors.grey),
                title: Text(
                  categorie["title"] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AzkarDetailsScreen(
                              title: categorie["title"] as String,
                              list: const [
                                "أصبحنا وأصبح الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير.",
                                "اللهم بك أصبحنا وبك أمسينا، وبك نحيا وبك نموت وإليك النشور.",
                                "باسمك اللهم أموت وأحيا.",
                                "اللهم قِني عذابك يوم تبعث عبادك."
                              ],
                            )),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
