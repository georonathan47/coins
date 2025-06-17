import '../../../../../core/utils/extensions.dart';
import '../widgets.dart';

class TrendingAsset extends StatefulWidget {
  const TrendingAsset({super.key, required this.asset});
  final CoinData asset;

  @override
  State<TrendingAsset> createState() => _TaskItemState();
}

class _TaskItemState extends State<TrendingAsset> {
  final textTheme = Get.textTheme;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.45,
      padding: const EdgeInsets.all(8),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.asset.name.truncate(10),
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 18,
                    color: TColors.light,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  TFormatter.formatDollar(double.parse(widget.asset.price)),
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge?.copyWith(color: TColors.light),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
