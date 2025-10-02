import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color selectedColor;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.primaryColor,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : primaryColor,
        ),
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: const Color(0xffE4EDE1),
      selectedColor: selectedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      showCheckmark: false,
    );
  }
}
