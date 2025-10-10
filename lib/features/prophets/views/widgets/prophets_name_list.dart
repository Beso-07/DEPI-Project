import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/prophets/models/prophets_model.dart';
import 'package:depiproject/features/prophets/views/widgets/show_prophet_details.dart';
import 'package:flutter/material.dart';

class ProphestNamelist extends StatelessWidget {
  const ProphestNamelist({
    super.key,
    required this.prophets,
  });

  final List<ProphetsModel> prophets;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: prophets.length,
      itemBuilder: (context, index) {
        final item = prophets[index];
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ShowProphetDetails(
                name: item.name,
                meaning: item.meaning,
                details: item.details,
              ),
            );
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
    );
  }
}
