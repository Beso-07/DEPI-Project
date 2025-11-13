import 'package:flutter/material.dart';


class AyahNumberWidget extends StatelessWidget {
  final int ayahNumber;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const AyahNumberWidget({
    super.key,
    required this.ayahNumber,
    this.size = 24.0,
    this.backgroundColor = const Color(0xFFF5F5DC),  
    this.textColor = const Color(0xFF2F4F4F), 
    this.borderColor = const Color(0xFF8B4513), 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$ayahNumber',
          style: TextStyle(
            fontSize: size * 0.5, 
            fontWeight: FontWeight.bold,
            color: textColor,
           
            fontFamily: 'Roboto',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


class AyahNumberSpan extends WidgetSpan {
  AyahNumberSpan({
    required int ayahNumber,
    double size = 20.0,
    Color backgroundColor = const Color(0xFFF5F5DC),
    Color textColor = const Color(0xFF2F4F4F),
    Color borderColor = const Color(0xFF8B4513),
  }) : super(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: AyahNumberWidget(
              ayahNumber: ayahNumber,
              size: size,
              backgroundColor: backgroundColor,
              textColor: textColor,
              borderColor: borderColor,
            ),
          ),
          alignment: PlaceholderAlignment.middle,
        );
}

class AyahNumberStyles {
  static AyahNumberSpan regular(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 20.0,
      );

  static AyahNumberSpan small(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 16.0,
      );

  static AyahNumberSpan large(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 28.0,
      );

  static AyahNumberSpan golden(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 22.0,
        backgroundColor: const Color(0xFFFFFDD0), 
        borderColor: const Color(0xFFDAA520), 
        textColor: const Color(0xFF8B4513), 
      );
}