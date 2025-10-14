import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_cubit.dart';
import 'package:depiproject/features/Azkar/model_view/cubit/azkar_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/constants/app_Bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzkarDetailsScreen extends StatelessWidget {
  final String title;
  final List list;

  const AzkarDetailsScreen(
      {super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..getAzkar(),
      child: Scaffold(
        appBar:
            appBarWidget(text: title, onPress: () => Navigator.pop(context)),
        body: list.isEmpty
            ? const Center(
                child: Text("لا يوجد أذكار",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lateef',
                        fontSize: 45,
                        color: Colors.green)))
            : ListView.builder(
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
                            zekr.zekr,
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
                              BlocBuilder<AzkarCubit, AzkarState>(
                                builder: (context, state) {
                                  final cubit = context.watch<AzkarCubit>();
                                  final isSaved = cubit.isSaved(zekr);

                                  return IconButton(
                                    icon: Icon(
                                      isSaved
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color:
                                          isSaved ? Colors.green : Colors.grey,
                                    ),
                                    onPressed: () async {
                                      await cubit.toggleSave(zekr);
                                    },
                                  );
                                },
                              ),
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
      ),
    );
  }
}
