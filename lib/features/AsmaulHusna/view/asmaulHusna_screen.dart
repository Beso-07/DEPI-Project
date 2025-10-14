import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/AsmaulHusna/model_view/cubit/asmaulhusna_cubit.dart';
import 'package:depiproject/features/AsmaulHusna/model_view/cubit/asmaulhusna_state.dart';
import 'package:depiproject/features/AsmaulHusna/view/widget/show_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsmaulHusnaScreen extends StatelessWidget {
  const AsmaulHusnaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AsmaulHusnaCubit()..fetchAsmaulHusna(),
      child: Scaffold(
        body: Column(
          children: [
            const MainAppBar(title: 'أسماء الله الحسني'),
            BlocBuilder<AsmaulHusnaCubit, AsmaulHusnaState>(
              builder: (context, state) {
                if (state is AsmaulHusnaLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AsmaulHusnaSuccess) {
                  final names = state.names;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: names.length,
                        itemBuilder: (context, index) {
                          final item = names[index];
                          return InkWell(
                            onTap: () {
                              showAlertDialog(context,
                                  title: item.name, text: item.text);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: const DecorationImage(
                                  image: AssetImage(Imagespath.sura),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kPrimaryColor2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
