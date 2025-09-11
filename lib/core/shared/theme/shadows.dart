import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
    color: TColors.darkGrey.withOpacity(0.1),
  );
  static final horizontalProductShadow = BoxShadow(
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
    color: TColors.darkGrey.withOpacity(0.1),
  );
}
