import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Apple-inspired Premium Dark Palette
  static const Color background = Color(0xFF0E0E0E);
  static const Color surface = Color(0xFF161617);
  static const Color card = Color(0xFF1D1D1F);

  static const Color primary = Color(0xFFF5F5F7);
  static const Color secondary = Color(0xFFA1A1A6);
  static const Color accent = Color(0xFFA855F7); // Purple Accent

  static const Color glassBorder = Color(0x33A1A1A6);
  static const Color shadowColor = Color(0x66000000);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      tertiary: accent,
      surface: surface,
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: primary,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: primary,
          letterSpacing: -0.5,
        ),
        bodyLarge: TextStyle(fontSize: 18, color: secondary, height: 1.5),
      ),
    ),
  );

  static BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white.withValues(alpha: 0.05),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: glassBorder),
  );
}
