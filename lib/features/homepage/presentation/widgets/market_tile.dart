import 'package:flutter_svg/svg.dart';

import 'widgets.dart';

class MarketCard extends StatefulWidget {
  const MarketCard({super.key, required this.data});
  final CoinData data;

  @override
  MarketCardState createState() => MarketCardState();
}

class MarketCardState extends State<MarketCard> {
  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final themeData = Theme.of(context);
    return Container(
      height: 10,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: themeData.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(-1, 4),
            color: themeData.shadowColor.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                IntrinsicWidth(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.data.icon.contains('svg')
                        ? SvgPicture.network(
                            widget.data.icon,
                            height: Get.height * 0.05,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.data.icon,
                            fit: BoxFit.cover,
                            width: Get.height * 0.05,
                            // height: Adaptive.h(10.sp),
                            filterQuality: FilterQuality.high,
                          ),
                  ),
                ),
                const Spacer(),
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text(
                          widget.data.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: themeData.textTheme.titleSmall!.copyWith(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: isDark ? TColors.textWhite : TColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.data.symbol,
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.titleSmall!.copyWith(
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: Get.height * 0.125),
              child: Sparkline(
                useCubicSmoothing: true,
                fillMode: FillMode.below,
                cubicSmoothingFactor: 0.2,
                data: widget.data.sparkline,
                lineColor: Get.isDarkMode ? Colors.white : TColors.primary,
                fillGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(int.parse(widget.data.color.replaceAll('#', '0xFF'))),
                    Color(int.parse(widget.data.color.replaceAll('#', '0xCF'))),
                    Color(int.parse(widget.data.color.replaceAll('#', '0xAF'))),
                    Color(int.parse(widget.data.color.replaceAll('#', '0x26'))),
                    Color(int.parse(widget.data.color.replaceAll('#', '0x1A'))),
                    Color(int.parse(widget.data.color.replaceAll('#', '0x0D'))),
                  ],
                ),
                gridLineColor: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Price: ',
              style: themeData.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: TFormatter.formatDollar(
                    double.parse(widget.data.price),
                  ),
                  style: themeData.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              widget.data.percentageChange.contains('-')
                  ? const Icon(FontAwesomeIcons.chevronDown, color: Colors.red)
                  : const Icon(FontAwesomeIcons.chevronUp, color: Colors.teal),
              const SizedBox(width: 4),
              Text(
                "${widget.data.percentageChange}%",
                textAlign: TextAlign.center,
                style: themeData.textTheme.titleMedium!.copyWith(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                  color: widget.data.percentageChange.contains('-')
                      ? Colors.red[400]!
                      : Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
