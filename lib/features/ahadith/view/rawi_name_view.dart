
import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/ahadith/model_view/cubit/cubit/hadith_view_cubit.dart';
import 'package:depiproject/features/ahadith/model_view/cubit/cubit/hadith_view_state.dart';
import 'package:depiproject/features/ahadith/models/categories_model.dart';
import 'package:depiproject/features/ahadith/models/hadith_model.dart';
import 'package:depiproject/features/ahadith/view/ahadith_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RawiNameView extends StatelessWidget {
  const RawiNameView({super.key});

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => HadithCubit()..getHadith(),
        child: Scaffold(
            body: Column(
          children: [
            const MainAppBar(title: "احاديث "),
            Expanded(
              child: BlocBuilder<HadithCubit, HadithState>(
                builder: (context, state) {
                  if (state is HadithLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HadithError) {
                    return Center(child: Text("خطأ: ${state.message}"));
                  } else if (state is HadithSuccess) {
                    final hadith = state.hadith;
                    final categories = [
                      Categoryes(
                        title: """  أحمد بن حنبل""",
                        list: hadith.ahmad,
                      ),
                      Categoryes(
                        title: """ البخارى""",
                        list: hadith.bukari,
                      ),
                      Categoryes(
                        title: """ مسلم """,
                        list: hadith.muslim,
                      ),
                      Categoryes(
                        title: """ابو داود """,
                        list: hadith.abudawood,
                      ),
                      Categoryes(
                        title: """ النسائى """,
                        list: hadith.elnasaee,
                      ),
                      Categoryes(
                        title: """الترمذى""",
                        list: hadith.tirmidhi,
                      ),
                    ];
                    return ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final categorie = categories[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RawiAhadithView(
                                  title: categorie.title,
                                  list: categorie.list as List<Hadith>,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: height * 0.09,
                            width: Width,
                            decoration: const BoxDecoration(
                                color: AppColors.kPrayerTimeColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Imagespath.prophet,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: Width * 0.03,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          categorie.title,
                                          style: const TextStyle(
                                              color: AppColors.kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              fontFamily: "Lateef"),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "عدد الاحاديث: 100",
                                          style: TextStyle(
                                              color: AppColors.kPrimaryColor2),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        )),
      ),
      
    );
  }
}
