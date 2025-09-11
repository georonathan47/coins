import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';

class NavDrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final VoidCallback onTap;

  const NavDrawerItem({
    super.key,
    this.color,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: ListTile(
        onTap: onTap,
        tileColor: color?.withValues(alpha: 0.4),
        leading: Icon(
          icon,
          color: color ?? (isDark ? TColors.light : TColors.textPrimary),
        ),
        title: Text(
          text,
          style: textTheme.titleSmall?.copyWith(
            letterSpacing: .1,
            fontWeight: FontWeight.w400,
            color: color ?? (isDark ? TColors.light : TColors.textPrimary),
          ),
        ),
      ),
    );
  }
}
