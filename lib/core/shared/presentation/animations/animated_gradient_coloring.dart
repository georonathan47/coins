import 'package:flutter/material.dart';

class AnimatedGradientColoring extends StatefulWidget {
  const AnimatedGradientColoring({
    super.key,
    required this.startColor,
    required this.endColor,
    this.child,
    this.padding,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  });

  final Color startColor;
  final Color endColor;
  final double? padding;
  final Widget? child;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  @override
  AnimatedGradientColoringState createState() =>
      AnimatedGradientColoringState();
}

class AnimatedGradientColoringState extends State<AnimatedGradientColoring>
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
          padding: EdgeInsets.all(widget.padding ?? 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: widget.gradientBegin,
              end: widget.gradientEnd,
              colors: [
                Color.lerp(
                  widget.startColor,
                  widget.endColor,
                  _animation.value,
                )!,
                Color.lerp(
                  widget.endColor,
                  widget.startColor,
                  _animation.value,
                )!,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
      // child: widget.child,
    );
  }
}
