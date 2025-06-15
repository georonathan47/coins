import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, GetNavigation;

import '../constants/colors.dart';

class TDrawerTheme {
  TDrawerTheme._();

  static DrawerThemeData lightDrawerTheme = DrawerThemeData(
    elevation: 4,
    backgroundColor: TColors.primaryBackground,
    width: Get.context != null
        ? MediaQuery.sizeOf(Get.context!).width * .6
        : 300,
  );

  static DrawerThemeData darkDrawerTheme = DrawerThemeData(
    elevation: 4,
    backgroundColor: TColors.drawerBackgroundDark,
    width: Get.context != null
        ? MediaQuery.sizeOf(Get.context!).width * .6
        : 300,
  );
}
