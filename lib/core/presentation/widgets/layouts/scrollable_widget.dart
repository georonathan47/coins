import 'package:flutter/material.dart';

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
      padding: EdgeInsets.all(padding ?? 20),
      physics: physics ?? const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
