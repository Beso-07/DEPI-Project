import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/tasbeh/model_view/cubit/tasabeh_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasbehView extends StatelessWidget {
  TasbehView({super.key});

  final List<String> azkarList = [
    'اَسْتَغْفِرُ اللَّهَ',
    'سُبْحَانَ اللَّهِ',
    'الْحَمْدُ لِلَّهِ',
    'اللَّهُ أَكْبَرُ',
    'لَا إِلٰهَ إِلَّا اللَّهُ',
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، سُبْحَانَ اللَّهِ الْعَظِيمِ',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => TasabehCubit(),
      child: Scaffold(body: BlocBuilder<TasabehCubit, TasabehState>(
        builder: (context, state) {
          final cubit = context.read<TasabehCubit>();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const MainAppBar(title: "العداد "),
                SizedBox(
                  height: height * 0.05,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    """استخدم العداد لتتبع تسبيحاتك وذكر الله فى اى وقت """,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: "lateef",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Column(
                  children: [
                    Text(
                      cubit.currentZeker,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                      style:
                          const TextStyle(fontFamily: "lateef", fontSize: 32),
                    ),
                    SizedBox(
                      width: Width * 0.02,
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                        color: AppColors.kPrimaryColor2,
                      ),
                      onSelected: (value) {
                        // cubit.currentZeker = value;
                        // cubit.counter = 0;
                        cubit.showZeker(
                          value,
                        );
                        cubit.resetCount();
                      },
                      itemBuilder: (context) {
                        return azkarList.map((zikr) {
                          return PopupMenuItem<String>(
                            value: zikr,
                            child: Text(
                              zikr,
                              style: const TextStyle(
                                fontFamily: "lateef",
                                fontSize: 22,
                              ),
                            ),
                          );
                        }).toList();
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      cubit.counter.toString(),
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        // counter++;
                        cubit.showcount();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      backgroundColor: AppColors.kPrimaryColor2,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.kPrimaryColor2)),
                  height: height * 0.04,
                  width: Width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => {
                          // counter = 0,
                          cubit.resetCount()
                        },
                        child: const Text(
                          "اعادة ضبط ",
                          style: TextStyle(
                              color: AppColors.kPrimaryColor2,
                              fontWeight: FontWeight.w900),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
