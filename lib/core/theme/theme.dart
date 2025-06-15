import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'appbar_theme.dart';
import 'bottom_sheet_theme.dart';
import 'checkbox_theme.dart';
import 'chip_theme.dart';
import 'drawer_theme.dart';
import 'elevated_button_theme.dart';
import 'outlined_button_theme.dart';
import 'text_field_theme.dart';
import 'text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.grey,
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    drawerTheme: TDrawerTheme.lightDrawerTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    scaffoldBackgroundColor: TColors.primaryBackground,
    cardTheme: const CardThemeData(color: TColors.white),
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    disabledColor: TColors.grey,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    drawerTheme: TDrawerTheme.darkDrawerTheme,
    scaffoldBackgroundColor: TColors.darkerGrey,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    cardTheme: const CardThemeData(color: TColors.darkGray),
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}

// final customDatePickerTheme = ThemeData(
//   primarySwatch: Colors.red,
//   indicatorColor: TColors.accent,
//   highlightColor: TColors.secondary,
//   dialogTheme: const DialogThemeData(
//     backgroundColor: TColors.primaryBackground,
//   ),
// );
