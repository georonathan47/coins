import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class ScrollableWidget extends StatelessWidget {
  final double? padding;
  final List<Widget> children;
  final ScrollPhysics? physics;
  final CrossAxisAlignment? crossAxisAlignment;
  const ScrollableWidget({
    super.key,
    this.physics,
    this.padding,
    this.crossAxisAlignment,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding ?? 16),
      physics: physics ?? const NeverScrollableScrollPhysics(),
      child: Column(
        spacing: TSizes.spaceBtwItems,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
