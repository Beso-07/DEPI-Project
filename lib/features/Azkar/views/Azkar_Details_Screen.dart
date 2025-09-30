import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
        title: Text(title ?? "",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Lateef',
                fontSize: 36,
                color: Colors.green)),
        centerTitle: true,
      ),
      body: list == null || list!.isEmpty
          ? const Center(child: Text("لا يوجد أذكار"))
          : ListView.builder(
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
                          " {\"${zekr.zekr}\"}",
                          style: const TextStyle(
                            fontSize: 32,
                            fontFamily: 'Lateef',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "↺ ${zekr.count} مرات",
                              style: const TextStyle(
                                fontSize: 25,
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
                                    backgroundColor: AppColors.kPrimaryColor2,
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
    );
  }
}
