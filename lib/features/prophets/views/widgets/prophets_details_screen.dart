import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:depiproject/features/prophets/models/prophets_model.dart';

class ProphetDetailsScreen extends StatelessWidget {
  final ProphetsModel prophet;

  const ProphetDetailsScreen({super.key, required this.prophet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppBar(title: prophet.name),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      prophet.meaning,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  prophet.details,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor2.withOpacity(.7),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    print('===========================');
                    print(prophet.url);
                  },
                  child: const Text(
                    "مشاهدة القصة",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Future<void> _launchUrl(String url) async {
//   final Uri uri = Uri.parse(url);
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   }
// }
