import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/extensions.dart';
import '../widgets.dart';

class TrendingAsset extends StatefulWidget {
  const TrendingAsset({super.key, required this.asset});
  final CoinData asset;

  @override
  State<TrendingAsset> createState() => TrendingAssetState();
}

class TrendingAssetState extends State<TrendingAsset> {
  final textTheme = Get.textTheme;
  @override
  Widget build(BuildContext context) {
    final size = Get;
    return Container(
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
          // Image.asset(TImages.logoWhite, width: 40),
          widget.asset.icon.contains('.svg')
              ? SvgPicture.network(
                  widget.asset.icon,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )
              : CachedNetworkImage(
                  imageUrl: widget.asset.icon,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),

          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Text(
                    widget.asset.name.truncate(10),
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 18,
                      color: TColors.light,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Text(
                    TFormatter.formatDollar(double.parse(widget.asset.price)),
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge?.copyWith(color: TColors.light),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
