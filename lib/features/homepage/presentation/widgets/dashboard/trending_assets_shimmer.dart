import '../widgets.dart';

class TrendingAssetShimmer extends StatefulWidget {
  const TrendingAssetShimmer({super.key});

  @override
  State<TrendingAssetShimmer> createState() => _TaskItemState();
}

class _TaskItemState extends State<TrendingAssetShimmer> {
  final textTheme = Get.textTheme;
  @override
  Widget build(BuildContext context) {
    final size = Get;
    return ShimmerAnimation(
      child: Container(
        width: size.width * 0.45,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: TColors.primary,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(TImages.overlay),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 1),
              color: Colors.grey.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(TImages.logoWhite, width: 40),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '                     ',
                  style: textTheme.titleSmall?.copyWith(
                    color: TColors.light,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '           ',
                  style: textTheme.bodySmall?.copyWith(color: TColors.light),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
