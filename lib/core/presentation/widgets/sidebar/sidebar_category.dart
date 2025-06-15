import '../../../auth/presentation/widgets/widgets.dart';

class SidebarCategory extends StatelessWidget {
  const SidebarCategory({
    super.key,
    this.icon,
    required this.title,
    required this.children,
  });

  final String title;
  final IconData? icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    final isDark = Get.isDarkMode;
    return ExpansionTile(
      backgroundColor: TColors.accent,
      title: Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: TSizes.fontSizeLg,
          color: isDark ? TColors.light : TColors.textPrimary,
        ),
      ),
      leading: Icon(icon, color: isDark ? TColors.light : TColors.textPrimary),
      children: children,
    );
  }
}
