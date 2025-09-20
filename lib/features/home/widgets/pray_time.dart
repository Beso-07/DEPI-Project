import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PrayTime extends StatelessWidget {
  const PrayTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "السَّلاَمُ عَلَيْكُمْ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    const Text("الثلاثاء، ١٢ شعبان ١٤٤٥ هـ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                    const Text("١١ فبراير ٢٠٢٥ م",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                CircularPercentIndicator(
                  radius: 90,
                  backgroundColor: Colors.grey,
                  progressColor: AppColors.kPercentColor,
                  lineWidth: 4,
                  percent: .24,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "الفجر (ص)",
                        style: TextStyle(
                            color: AppColors.kPrimaryColor3,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .01),
                      const Text(
                        "04:49",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .01),
                      const Text(
                        "05:37:43 -",
                        style: TextStyle(
                            color: AppColors.kPrimaryColor3,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        
      
    
  }
}
