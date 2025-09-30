import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AzkarDetailsScreen extends StatelessWidget {
  final String? title;
  final List<String>? list;

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
        title: Text(
          title ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
            fontFamily: 'Lateef',
            color: Colors.green,
          ),
        ),
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
                  elevation: 4,
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // النص
                        Text(
                          "[\"$zekr\"]",
                          style: const TextStyle(
                            fontSize: 31,
                            fontFamily: 'Lateef',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),
                        const Divider(),

                        // التكرار + الأزرار
                        Row(
                          children: [
                            const Text(
                              "مرة واحدة",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lateef',
                                color: AppColors.kPrimaryColor2,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                // حفظ
                              },
                              icon: const Icon(
                                Icons.bookmark_border,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // نسخ
                              },
                              icon: const Icon(
                                Icons.copy_all_rounded,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
