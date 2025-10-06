import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/tasbeh/model_view/cubit/tasabeh_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasbeh extends StatelessWidget {
  Tasbeh({super.key});
  int counter = 0;
  String curretZeker = 'اَسْتَغْفِرُ اللَّهَ';
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
    final cubit = context.read<TasabehCubit>();
    return Scaffold(body: BlocBuilder<TasabehCubit, TasabehState>(
      builder: (context, state) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const MainAppBar(title: "العداد "),
                SizedBox(
                  height: height * 0.05,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      """استخدم العداد لتتبع تسبيحاتك وذكر الله فى اى وقت """,
                      style: TextStyle(
                          fontFamily: "lateef", fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          curretZeker,
                          style: const TextStyle(
                              fontFamily: "lateef", fontSize: 50),
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
                            curretZeker = value;
                            counter = 0;
                            cubit.showZeker(value, curretZeker);
                            cubit.resetCount(counter);
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
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      counter.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        counter++;
                        cubit.showcount(counter);
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
                        onTap: () => {counter = 0, cubit.resetCount(counter)},
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
          ),
        );
      },
    ));
  }
}
