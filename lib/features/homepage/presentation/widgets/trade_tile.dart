import 'widgets.dart';

/// Make sure not to add `Get.back()` as this
/// has already been added to the file
class TradeTile extends StatelessWidget {
  const TradeTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final textTheme = Get.textTheme;
    return Card(
      elevation: 4,
      shadowColor: TColors.darkerGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        height: Get.height * .0975,
        decoration: BoxDecoration(
          color: TColors.primary,
          backgroundBlendMode: BlendMode.darken,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: TColors.light, width: 0.5),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 4),
              color: TColors.darkerGrey.withOpacity(0.4),
            ),
          ],
        ),
        child: ListTile(
          tileColor: isDark ? TColors.secondary : TColors.transparent,
          onTap: () {
            Get.back();
            onTap();
          },
          leading: Icon(Iconsax.money, color: TColors.light, size: 40),
          title: Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              color: TColors.light,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: textTheme.bodyLarge?.copyWith(color: TColors.light),
          ),
        ),
      ),
    );
  }
}
