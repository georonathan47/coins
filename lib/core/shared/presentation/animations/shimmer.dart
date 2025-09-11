import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../constants/colors.dart';

class ShimmerAnimation extends StatelessWidget {
  const ShimmerAnimation({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: TColors.grey,
      direction: ShimmerDirection.fromLeftToRight(),
      child: child!,
    );
  }
}
