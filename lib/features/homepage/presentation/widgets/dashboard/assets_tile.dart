import '../widgets.dart';

class AssetTile extends StatelessWidget {
  const AssetTile({
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
          // backgroundBlendMode: BlendMode.darken,
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
          leading: CircleAvatar(
            child: ClipOval(
              child: CachedNetworkImage(
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                memCacheWidth: 120,
                memCacheHeight: 120,
                imageUrl: 'https://picsum.photos/200/330',
                placeholder: (ctx, url) => const CircularProgressIndicator(),
                errorWidget: (ctx, url, error) =>
                    const Icon(Iconsax.buy_crypto),
              ),
            ),
          ),
          title: Text(
            title,
            style: textTheme.titleMedium?.copyWith(color: TColors.light),
          ),
          subtitle: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyLarge?.copyWith(color: TColors.light),
          ),
        ),
      ),
    );
  }
}
