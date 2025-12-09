import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/ahadith/model_view/cubit/cubit/hadith_view_cubit.dart';
import 'package:depiproject/features/ahadith/model_view/cubit/cubit/hadith_view_state.dart';
import 'package:depiproject/features/ahadith/models/hadith_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class RawiAhadithView extends StatelessWidget {
  final String? title;
  final List<Hadith>? list;
  final List<HadithModel>? hadiths;

  const RawiAhadithView({
    super.key,
    this.title,
    this.list,
    this.hadiths,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => HadithCubit()..getHadith(),
      child: Scaffold(
        body: Column(
          children: [
            const MainAppBar(title: 'أحاديث'),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "رواه $title",
            //       style: const TextStyle(
            //           color: Colors.black, fontWeight: FontWeight.w900),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: list!.length,
                itemBuilder: (BuildContext context, int index) {
                  final hadith = list![index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(children: [
                      IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor3,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: AppColors.kPrayerTimeColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          " حديث رقم ${hadith.id}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                await Share.share(
                                                    hadith.hadithContent,
                                                    subject:
                                                        ' حديث من التطبيق تقوي 📿');
                                              },
                                              icon: const Icon(Icons.share,
                                                  color: Colors.blueGrey),
                                            ),
                                            const SizedBox(width: 7),
                                            BlocBuilder<HadithCubit,
                                                HadithState>(
                                              builder: (context, state) {
                                                final cubit = context
                                                    .watch<HadithCubit>();
                                                final isSaved =
                                                    cubit.isSaved(hadith);

                                                return IconButton(
                                                  icon: Icon(
                                                    isSaved
                                                        ? Icons.bookmark
                                                        : Icons.bookmark_border,
                                                    color: isSaved
                                                        ? Colors.green
                                                        : Colors.grey,
                                                  ),
                                                  onPressed: () async {
                                                    await cubit
                                                        .toggleSave(hadith);
                                                  },
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        hadith.hadithContent));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("تم نسخ الحديث ✅"),
                                                    backgroundColor: AppColors
                                                        .kPrimaryColor2,
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.copy_all_rounded,
                                                color: AppColors.kPrimaryColor2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    hadith.hadithContent,
                                    style: const TextStyle(
                                        color: AppColors.kPrimaryColor2,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
