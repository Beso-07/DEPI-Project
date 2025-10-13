import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/Azkar/models/azkar_model.dart';
import 'package:depiproject/features/Azkar/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/features/Azkar/views/azkar_Details_Screen.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_cubit.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AzkarCategoriesView extends StatelessWidget {
  const AzkarCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AzkarCubit()..getAzkar(),
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        //   ],
        //   title: const Text("الأذكار",
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 36,
        //           fontFamily: 'Lateef',
        //           color: Colors.green)),
        //   centerTitle: true,
        // ),
        body: Column(
          children: [
            const MainAppBar(title: 'الأزكار'),
            BlocBuilder<AzkarCubit, AzkarState>(
              builder: (context, state) {
                if (state is AzkarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AzkarError) {
                  return Center(child: Text("خطأ: ${state.message}"));
                } else if (state is AzkarSuccess) {
                  final azkar = state.azkar;
                  final categories = [
                    Category(
                        title: "أذكار الصباح",
                        list: azkar.morning,
                        icon: Icons.wb_sunny),
                    Category(
                        title: "أذكار المساء",
                        list: azkar.evening,
                        icon: Icons.nights_stay),
                    Category(
                        title: "أذكار النوم",
                        list: azkar.sleep,
                        icon: Icons.bedtime),
                    Category(
                        title: "أذكار الاستيقاظ",
                        list: azkar.wakeUp,
                        icon: Icons.alarm),
                    Category(
                        title: "أذكار بعد الصلاة",
                        list: azkar.afterPrayer,
                        icon: FontAwesomeIcons.mosque),
                    Category(
                        title: "أدعية قرآنية",
                        list: azkar.quranicDua,
                        icon: Icons.menu_book),
                    Category(
                        title: "أدعية الأنبياء",
                        list: azkar.prophetsDua,
                        icon: Icons.person),
                  ];
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final categorie = categories[index];
                        return Card(
                          color: Colors.green.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: ListTile(
                              leading: Icon(categorie.icon, color: Colors.grey),
                              title: Text(categorie.title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                              trailing:
                                  const Icon(Icons.chevron_right_outlined),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AzkarDetailsScreen(
                                      title: categorie.title,
                                      list: categorie.list as List<Zekr>,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
