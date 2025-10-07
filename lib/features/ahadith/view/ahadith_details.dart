import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/ahadith/models/hadith_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class RawiAhadithView extends StatelessWidget {
  final String? title;
  final List<Hadith>? list;

  const RawiAhadithView({
    super.key,
    this.title,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Container(
              width: Width * 0.9,
              child: Column(
                children: [
                  const MainAppBar(title: "احاديث "),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        hintText: 'ابحث عن حديث',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        suffixIcon: const Padding(
                          padding: EdgeInsetsDirectional.only(end: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search,
                                  color: AppColors.kPrimaryColor2),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.filter_list,
                                  color: AppColors.kPrimaryColor2),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          "رواه $title",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w900),
                        ),
                        const Spacer(),
                        const Text(
                          "100",
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 124, 124),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        const Text(
                          " حديث ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 124, 124),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  list == null || list!.isEmpty
                      ? const Center(child: Text("لا يوجد أحاديث"))
                      : ListView.separated(
                          padding: const EdgeInsets.all(12),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Hadith = list![index];

                            return Column(children: [
                              Container(
                                height: height * 0.33,
                                width: Width,
                                decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor3,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height * 0.06,
                                        width: Width,
                                        decoration: BoxDecoration(
                                            color: AppColors.kPrayerTimeColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                " حديث رقم ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Stack(
                                                children: [
                                                  Image.asset(
                                                    Imagespath.ayah,
                                                    height: 50,
                                                    width: 34,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Positioned(
                                                    right: 8,
                                                    top: 5,
                                                    child: Text(
                                                      Hadith.id.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: AppColors
                                                              .kPrimaryColor2),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons.bookmark_border,
                                                color: AppColors.kPrimaryColor2,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: Hadith
                                                              .hadithContent));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "تم نسخ الحديث ✅"),
                                                      backgroundColor: AppColors
                                                          .kPrimaryColor2,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.copy_all_rounded,
                                                  color:
                                                      AppColors.kPrimaryColor2,
                                                ),
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
                                          Hadith.hadithContent,
                                          style: const TextStyle(
                                              color: AppColors.kPrimaryColor2,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
