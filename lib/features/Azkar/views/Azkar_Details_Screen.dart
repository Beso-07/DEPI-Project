import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_cubit.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_state.dart';
import 'package:depiproject/features/Azkar/models/Azkar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:depiproject/core/constants/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class AzkarDetailsScreen extends StatelessWidget {
  final String title;
  final List<Zekr> list;

  const AzkarDetailsScreen({
    super.key,
    required this.title,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..getAzkar(),
      child: Scaffold(
        body: Column(
          children: [
            MainAppBar(title: title),
            list.isEmpty
                ? const Center(child: Text("لا توجد أذكار محفوظة"))
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final zekr = list[index];
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
                                      "${zekr.count} مرة",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lateef',
                                        color: AppColors.kPrimaryColor2,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        await Share.share(zekr.zekr,
                                            subject: 'ذكر من التطبيق 📿');
                                      },
                                      icon: const Icon(Icons.share,
                                          color: Colors.blueGrey),
                                    ),
                                    const SizedBox(width: 7),
                                    BlocBuilder<AzkarCubit, AzkarState>(
                                      builder: (context, state) {
                                        final cubit =
                                            context.watch<AzkarCubit>();
                                        final isSaved = cubit.isSaved(zekr);

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
                                            await cubit.toggleSave(zekr);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 7),
                                    IconButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                            ClipboardData(text: zekr.zekr));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
        ),
      ),
    );
  }
}
