import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.illustration,
    required this.title,
    required this.text,
  });

  final String? illustration, title, text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: SvgPicture.asset(illustration!, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title!,
          textAlign: TextAlign.center,
          style: textTheme.titleLarge!.copyWith(
            letterSpacing: .5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text!,
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(
              letterSpacing: .5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
