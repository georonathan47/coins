import 'package:flutter/material.dart';

class AnimatedColoring extends StatefulWidget {
  const AnimatedColoring({
    super.key,
    required this.color,
    this.child,
    this.padding,
  });
  final Color color;
  final double? padding;
  final Widget? child;

  @override
  AnimatedColoringState createState() => AnimatedColoringState();
}

class AnimatedColoringState extends State<AnimatedColoring>
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
          padding: EdgeInsets.all(widget.padding ?? 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.color.withOpacity(0.35),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  widget.color,
                  widget.color.withOpacity(0.25),
                  _animation.value,
                )!,
                Color.lerp(
                  widget.color,
                  widget.color.withOpacity(0.25),
                  _animation.value,
                )!,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
