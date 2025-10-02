import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depiproject/features/Azkar/views/Azkar_Details_Screen.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_cubit.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_state.dart';

class AzkarCategoriesView extends StatelessWidget {
  const AzkarCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"title": "أذكار الصباح", "key": "morning", "icon": Icons.wb_sunny},
      {"title": "أذكار المساء", "key": "evening", "icon": Icons.nights_stay},
      {"title": "أذكار النوم", "key": "sleep", "icon": Icons.bedtime},
      {"title": "أذكار الاستيقاظ", "key": "wakeUp", "icon": Icons.alarm},
      {"title": "أذكار بعد الصلاة", "key": "afterPrayer", "icon": Icons.mosque},
      {"title": "أدعية قرآنية", "key": "quranicDua", "icon": Icons.menu_book},
      {"title": "أدعية الأنبياء", "key": "prophetsDua", "icon": Icons.person},
    ];

    return BlocProvider(
      create: (_) => AzkarCubit()..getAzkar(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
          title: const Text("الأذكار",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  fontFamily: 'Lateef',
                  color: Colors.green)),
          centerTitle: true,
        ),
        body: BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            if (state is AzkarLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AzkarError) {
              return Center(child: Text("خطأ: ${state.message}"));
            } else if (state is AzkarSuccess) {
              final azkar = state.azkar;

              return ListView.builder(
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
                        leading: Icon(categorie["icon"] as IconData,
                            color: Colors.grey),
                        title: Text(categorie["title"] as String,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          List<Zekr> list;
                          switch (categorie["key"]) {
                            case "morning":
                              list = azkar.morning;
                              break;
                            case "evening":
                              list = azkar.evening;
                              break;
                            case "sleep":
                              list = azkar.sleep;
                              break;
                            case "wakeUp":
                              list = azkar.wakeUp;
                              break;
                            case "afterPrayer":
                              list = azkar.afterPrayer;
                              break;
                            case "quranicDua":
                              list = azkar.quranicDua;
                              break;
                            case "prophetsDua":
                              list = azkar.prophetsDua;
                              break;
                            default:
                              list = [];
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AzkarDetailsScreen(
                                title: categorie["title"] as String,
                                list: list,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
