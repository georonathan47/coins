import 'package:flutter/material.dart';

class TColors {
  // App theme colors
  static const Color accent = Color(0xFF6495ED);
  static const Color primary = Color(0xFF254B59);
  static const Color secondary = Color(0xFF038C7F);
  static const Color transparent = Color(0x00000000);

  // Text colors
  static const Color textWhite = Colors.white;
  static const Color textPrimary = Color(0xFF112F3C);
  static const Color textSecondary = Color(0xFF6C757D);

  // Background colors
  static const Color dark = Color(0xFF333333);
  static const Color light = Color(0xFFF6F6F6);
  static const Color primaryBackground = Color(0xFFF8F7FD);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = TColors.black.withValues(alpha: 0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFFF28E13);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGray = Color(0xFF4D4D4D);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  //Sidebar Colors
  static const Color drawerActive = Color(0xFF9F2341);
  static const Color drawerHover = Color(0xFFDC4B6E);
  static const Color drawerNormal = Color(0xFFC73659);
  static const Color drawerBackgroundDark = darkerGrey;
}
