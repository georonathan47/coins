import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/shared/constants/colors.dart';
import 'flavors.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return (kDebugMode &&
                (F.appFlavor == Flavor.qa || F.appFlavor == Flavor.dev) ||
            kReleaseMode &&
                (F.appFlavor == Flavor.qa || F.appFlavor == Flavor.dev))
        ? Banner(
            message: F.name.toUpperCase(),
            textDirection: TextDirection.ltr,
            location: BannerLocation.bottomEnd,
            color: F.name.contains('dev') ? TColors.error : TColors.warning,
            textStyle: textTheme.titleSmall!.copyWith(
              fontSize: 20,
              letterSpacing: 1.0,
              color: TColors.white,
              fontWeight: FontWeight.bold,
            ),
            child: child,
          )
        : child;
  }
}
