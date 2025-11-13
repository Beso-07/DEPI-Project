import 'package:flutter/material.dart';

/// A decorative circular widget that displays ayah numbers
/// Designed to look like traditional Quran ayah number markings
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
    this.backgroundColor = const Color(0xFFF5F5DC), // Beige color like traditional mushaf
    this.textColor = const Color(0xFF2F4F4F), // Dark slate gray
    this.borderColor = const Color(0xFF8B4513), // Saddle brown
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
        // Add subtle shadow for depth
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
            fontSize: size * 0.5, // Font size relative to circle size
            fontWeight: FontWeight.bold,
            color: textColor,
            // Use a font that displays Arabic-Indic numerals well
            fontFamily: 'Roboto',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// A widget span version of AyahNumberWidget for use within RichText
/// This allows embedding the ayah number directly in the text flow
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

/// Utility class for creating ayah number widgets with different styles
class AyahNumberStyles {
  /// Default style for regular text
  static AyahNumberSpan regular(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 20.0,
      );

  /// Smaller style for compact layouts
  static AyahNumberSpan small(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 16.0,
      );

  /// Larger style for emphasis
  static AyahNumberSpan large(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 28.0,
      );

  /// Style with golden colors for special occasions
  static AyahNumberSpan golden(int ayahNumber) => AyahNumberSpan(
        ayahNumber: ayahNumber,
        size: 22.0,
        backgroundColor: const Color(0xFFFFFDD0), // Cream color
        borderColor: const Color(0xFFDAA520), // Golden rod
        textColor: const Color(0xFF8B4513), // Saddle brown
      );
}