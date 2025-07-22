import '../../../../auth/presentation/widgets/widgets.dart';

class SidebarCategory extends StatelessWidget {
  const SidebarCategory({
    super.key,
    this.icon,
    this.bgColor,
    required this.title,
    required this.children,
  });

  final String title;
  final IconData? icon;
  final Color? bgColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    final isDark = Get.isDarkMode;
    return ExpansionTile(
      backgroundColor:
          bgColor ?? (Get.isDarkMode ? TColors.secondary : TColors.accent),
      title: Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: TSizes.fontSizeLg,
          color: isDark ? TColors.light : TColors.textPrimary,
        ),
      ),
      leading: Icon(icon, color: isDark ? TColors.light : TColors.textPrimary),
      children: children,
    );
  }
}
