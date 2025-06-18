import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../constants/svg_assets.dart';
import '../layouts/scrollable_widget.dart';

class FetchError extends StatelessWidget {
  const FetchError({super.key, this.title, required this.message});
  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Container(
      width: double.infinity,
      height: Get.height / 3,
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        shadowColor: TColors.dark,
        child: ScrollableWidget(
          children: [
            // ToDo: Change asset to match error
            SvgPicture.asset(SvgAssets.noAsset, width: Get.width * 0.4),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              title?.capitalize ??
                  "Oops... You've run into an issue".capitalize!,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              message,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
