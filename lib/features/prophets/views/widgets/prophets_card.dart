import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/prophets/models/prophets_model.dart';
import 'package:depiproject/features/prophets/views/widgets/prophets_details_screen.dart';
import 'package:flutter/material.dart';

class ProphetCard extends StatelessWidget {
  final ProphetsModel prophet;

  const ProphetCard({super.key, required this.prophet});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.kPrimaryColor2.withOpacity(.6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProphetDetailsScreen(prophet: prophet),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Name + Meaning
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prophet.name == "محمد"
                          ? "${prophet.name} عليه الصلاة والسلام"
                          : "${prophet.name} عليه السلام",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      prophet.meaning,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
