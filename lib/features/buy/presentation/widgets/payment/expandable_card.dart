import 'package:flutter/material.dart';

class ExpandableCard extends StatelessWidget {
  final Widget child;
  final bool isExpanded;

  const ExpandableCard({
    super.key,
    required this.child,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      child: isExpanded
          ? Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(padding: const EdgeInsets.all(16.0), child: child),
            )
          : const SizedBox.shrink(),
    );
  }
}
