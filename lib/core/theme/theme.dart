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
    brightness: Brightness.light,
    disabledColor: TColors.grey,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    drawerTheme: TDrawerTheme.lightDrawerTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    scaffoldBackgroundColor: TColors.primaryBackground,
    cardTheme: const CardThemeData(color: TColors.light),
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      strokeWidth: 5,
      linearMinHeight: 35,
      color: TColors.secondary,
      linearTrackColor: TColors.darkGrey.withOpacity(0.3),
    ),
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
    cardTheme: const CardThemeData(color: TColors.darkerGrey),
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      strokeWidth: 5,
      linearMinHeight: 35,
      color: TColors.secondary,
      linearTrackColor: TColors.grey.withOpacity(0.3),
    ),
  );
}
