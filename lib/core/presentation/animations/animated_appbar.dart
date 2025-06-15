import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AnimatedGradientFlexibleSpace extends StatefulWidget {
  const AnimatedGradientFlexibleSpace({super.key, this.child});
  final Widget? child;
  @override
  AnimatedGradientFlexibleSpaceState createState() =>
      AnimatedGradientFlexibleSpaceState();
}

class AnimatedGradientFlexibleSpaceState
    extends State<AnimatedGradientFlexibleSpace>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation and repeat it infinitely
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  TColors.secondary,
                  TColors.accent,
                  _animation.value,
                )!,
                Color.lerp(
                  TColors.accent,
                  TColors.secondary,
                  _animation.value,
                )!,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
