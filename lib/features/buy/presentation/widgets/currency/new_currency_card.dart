import '../widgets.dart';

class NewCurrencyCard extends StatelessWidget {
  const NewCurrencyCard({super.key, required this.coinData});
  final CoinData coinData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get screen dimensions
        final screenWidth = MediaQuery.of(context).size.width;

        // Define breakpoints
        final isSmallScreen = screenWidth < 360;
        final isMediumScreen = screenWidth >= 360 && screenWidth < 414;
        final isExtraLargeScreen = screenWidth >= 480;

        // Responsive values
        final cardPadding = isSmallScreen
            ? 12.0
            : (isMediumScreen ? 16.0 : 20.0);
        final iconSize = isSmallScreen ? 50.0 : (isMediumScreen ? 55.0 : 60.0);
        final iconContentSize = isSmallScreen
            ? 32.0
            : (isMediumScreen ? 36.0 : 40.0);
        final spacingSmall = isSmallScreen
            ? 8.0
            : (isMediumScreen ? 10.0 : 12.0);
        final spacingMedium = isSmallScreen
            ? 12.0
            : (isMediumScreen ? 14.0 : 16.0);
        final spacingLarge = isSmallScreen
            ? 16.0
            : (isMediumScreen ? 18.0 : 20.0);
        final buttonHeight = isSmallScreen
            ? 42.0
            : (isMediumScreen ? 45.0 : 48.0);
        final borderRadius = isSmallScreen
            ? 12.0
            : (isMediumScreen ? 14.0 : 16.0);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Card(
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.1),
            margin: EdgeInsets.only(
              bottom: isSmallScreen ? 12 : 16,
              left: isSmallScreen ? 8 : 0,
              right: isSmallScreen ? 8 : 0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: isSmallScreen ? 140 : 160,
                maxWidth: isExtraLargeScreen ? 600 : double.infinity,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top Row - Icon, Name, and Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Coin Icon with enhanced styling
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Container(
                              width: iconSize,
                              height: iconSize,
                              decoration: const BoxDecoration(
                                // color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: coinData.icon.contains('.svg')
                                  ? SvgPicture.network(
                                      coinData.icon,
                                      width: iconContentSize,
                                      height: iconContentSize,
                                      fit: BoxFit.scaleDown,
                                    )
                                  : CachedNetworkImage(
                                      width: iconContentSize,
                                      height: iconContentSize,
                                      fit: BoxFit.scaleDown,
                                      imageUrl: coinData.icon,
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(width: spacingMedium),

                        // Coin Info - Flexible layout
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Name and Symbol Row
                              if (isSmallScreen) ...[
                                // Stack layout for small screens
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      coinData.name,
                                      style: textTheme.titleMedium?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        // color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        coinData.symbol,
                                        style: textTheme.bodySmall?.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                // Side by side for larger screens
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Text(
                                        coinData.name,
                                        style: textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: isMediumScreen ? 18 : 20,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMediumScreen ? 10 : 12,
                                        vertical: isMediumScreen ? 4 : 6,
                                      ),
                                      decoration: BoxDecoration(
                                        // color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        coinData.symbol,
                                        style: textTheme.bodySmall?.copyWith(
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: isMediumScreen ? 12 : 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],

                              SizedBox(height: spacingSmall),

                              // Price and Percentage Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Price - Flexible sizing
                                  Flexible(
                                    flex: isSmallScreen ? 2 : 3,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        TFormatter.formatDollar(
                                          double.parse(coinData.price),
                                        ),
                                        style: textTheme.headlineSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: isSmallScreen
                                                  ? 16
                                                  : (isMediumScreen ? 18 : 20),
                                            ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: spacingSmall),

                                  // Percentage Change with responsive styling
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen
                                          ? 8
                                          : (isMediumScreen ? 10 : 12),
                                      vertical: isSmallScreen
                                          ? 4
                                          : (isMediumScreen ? 5 : 6),
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          coinData.percentageChange.startsWith(
                                            '-',
                                          )
                                          ? TColors.error.withOpacity(0.1)
                                          : TColors.secondary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                        isSmallScreen ? 16 : 20,
                                      ),
                                      border: Border.all(
                                        color:
                                            coinData.percentageChange
                                                .startsWith('-')
                                            ? TColors.error.withOpacity(0.3)
                                            : TColors.secondary.withOpacity(
                                                0.3,
                                              ),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          coinData.percentageChange.startsWith(
                                                '-',
                                              )
                                              ? Icons.trending_down
                                              : Icons.trending_up,
                                          size: isSmallScreen ? 14 : 16,
                                          color:
                                              coinData.percentageChange
                                                  .startsWith('-')
                                              ? TColors.error
                                              : TColors.secondary,
                                        ),
                                        SizedBox(width: isSmallScreen ? 2 : 4),
                                        Text(
                                          coinData.percentageChange,
                                          style: textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isSmallScreen ? 11 : 12,
                                            color:
                                                coinData.percentageChange
                                                    .startsWith('-')
                                                ? TColors.error
                                                : TColors.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spacingLarge),

                    // Action Buttons Row with responsive layout
                    if (isSmallScreen) ...[
                      // Stacked buttons for very small screens
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: buttonHeight,
                            child: _buildBuyButton(
                              context,
                              textTheme,
                              borderRadius,
                            ),
                          ),
                          SizedBox(height: spacingSmall),
                          SizedBox(
                            width: double.infinity,
                            height: buttonHeight,
                            child: _buildSellButton(
                              context,
                              textTheme,
                              borderRadius,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Side by side buttons for larger screens
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: buttonHeight,
                              child: _buildBuyButton(
                                context,
                                textTheme,
                                borderRadius,
                              ),
                            ),
                          ),
                          SizedBox(width: spacingMedium),
                          Expanded(
                            child: SizedBox(
                              height: buttonHeight,
                              child: _buildSellButton(
                                context,
                                textTheme,
                                borderRadius,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    // Helper method for Buy Button
  }

  Widget _buildBuyButton(
    BuildContext context,
    TextTheme? textTheme,
    double borderRadius,
  ) {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text('Loading...', style: textTheme?.bodyMedium),
                ],
              ),
            ),
          ),
        );
        final result = await Get.find<DashboardController>().fetchCurrencies();
        final currency = result.firstWhere(
          (element) => element.currencyName == coinData.name,
        );
        Get.back();
        Get.toNamed(
          Routers.buy,
          arguments: {'coinData': coinData, 'currency': currency},
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 2,
        foregroundColor: Colors.white,
        backgroundColor: TColors.primary,
        shadowColor: TColors.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius * 0.75),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.buy_crypto,
            size: MediaQuery.of(context).size.width < 360 ? 18 : 20,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            'Buy',
            style: textTheme?.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width < 360 ? 13 : 14,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for Sell Button
  Widget _buildSellButton(
    BuildContext context,
    TextTheme? textTheme,
    double borderRadius,
  ) {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text('Loading...', style: textTheme?.bodyMedium),
                ],
              ),
            ),
          ),
        );
        final result = await Get.find<DashboardController>().fetchCurrencies();
        final currency = result.firstWhere(
          (element) => element.currencyName == coinData.name,
        );
        Get.back();
        Get.toNamed(
          Routers.sell,
          arguments: {'coinData': coinData, 'currency': currency},
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: TColors.error,
        foregroundColor: TColors.white,
        shadowColor: TColors.error.withOpacity(0.2),
        side: BorderSide(color: TColors.error, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius * 0.75),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.trade,
            size: MediaQuery.of(context).size.width < 360 ? 18 : 20,
            color: TColors.white,
          ),
          const SizedBox(width: 8),
          Text(
            'Sell',
            style: textTheme?.titleSmall?.copyWith(
              color: TColors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width < 360 ? 13 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
