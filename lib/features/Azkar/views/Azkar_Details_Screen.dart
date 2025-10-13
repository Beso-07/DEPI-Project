import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:depiproject/features/Azkar/models/azkar_model.dart';
import 'package:depiproject/core/constants/colors.dart';

class AzkarDetailsScreen extends StatelessWidget {
  final String? title;
  final List<Zekr>? list;

  const AzkarDetailsScreen({
    super.key,
    this.title,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        MainAppBar(title: title ?? ""),
        list == null || list!.isEmpty
            ? const Center(child: Text("لا يوجد أذكار"))
            : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    final zekr = list![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      color: Colors.green.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "\"${zekr.zekr}\"",
                              style: const TextStyle(
                                fontSize: 22,
                                fontFamily: 'Lateef',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Text(
                                  zekr.count < 10
                                      ? " ${zekr.count} مرات"
                                      : " ${zekr.count} مرة",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Lateef',
                                    color: AppColors.kPrimaryColor2,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.bookmark_border,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: zekr.zekr));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("تم نسخ الذكر ✅"),
                                        backgroundColor:
                                            AppColors.kPrimaryColor2,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy_all_rounded,
                                      color: Colors.blueGrey),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    ));
  }
}
