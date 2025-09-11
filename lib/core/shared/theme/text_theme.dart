import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

/// Custom Class for Light & Dark Text Themes
class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat().copyWith(
      fontSize: 68.0,
      color: TColors.dark,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.montserrat().copyWith(
      fontSize: 42.0,
      color: TColors.dark,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.montserrat().copyWith(
      fontSize: 26.0,
      color: TColors.dark,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.nunitoSans().copyWith(
      fontSize: 26.0,
      color: TColors.dark,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.nunitoSans().copyWith(
      fontSize: 22.0,
      color: TColors.dark,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.nunitoSans().copyWith(
      fontSize: 16.0,
      color: TColors.dark,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.sourceSans3().copyWith(
      fontSize: 16.0,
      color: TColors.dark,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.sourceSans3().copyWith(
      fontSize: 16.0,
      color: TColors.dark,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.sourceSans3().copyWith(
      fontSize: 14.0,
      color: TColors.dark,
      fontWeight: FontWeight.w300,
    ),
    labelLarge: GoogleFonts.raleway().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: TColors.dark,
    ),
    labelMedium: GoogleFonts.raleway().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: TColors.dark.withOpacity(0.5),
    ),
    labelSmall: GoogleFonts.raleway().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: TColors.dark.withOpacity(0.5),
    ),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.raleway().copyWith(
      fontSize: 68.0,
      color: TColors.light,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.raleway().copyWith(
      fontSize: 42.0,
      color: TColors.light,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.raleway().copyWith(
      fontSize: 26.0,
      color: TColors.light,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.raleway().copyWith(
      fontSize: 26.0,
      color: TColors.light,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.raleway().copyWith(
      fontSize: 22.0,
      color: TColors.light,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.raleway().copyWith(
      fontSize: 16.0,
      color: TColors.light,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.raleway().copyWith(
      fontSize: 16.0,
      color: TColors.light,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.raleway().copyWith(
      fontSize: 16.0,
      color: TColors.light,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.raleway().copyWith(
      fontSize: 14.0,
      color: TColors.light,
      fontWeight: FontWeight.w300,
    ),
    labelLarge: GoogleFonts.raleway().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: TColors.light,
    ),
    labelMedium: GoogleFonts.raleway().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: TColors.light.withOpacity(0.5),
    ),
    labelSmall: GoogleFonts.raleway().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: TColors.light.withOpacity(0.5),
    ),
  );
}
