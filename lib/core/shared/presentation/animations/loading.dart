// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import '../../constants/colors.dart';
// import '../../constants/image_strings.dart';
// import '../../helpers/helper_functions.dart';

// class CustomLoadingIndicator extends StatefulWidget {
//   const CustomLoadingIndicator({super.key});

//   @override
//   State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
// }

// class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = THelperFunctions.isDarkMode(context);
//     return Center(
//       child: SizedBox(
//         width: 75.w,
//         height: 75.w, // Keeping height the same as width for a square
//         child: AvatarGlow(
//           glowCount: 1,
//           glowColor: TColors.accent,
//           child: SizedBox(
//             width: 4.w,
//             height: 4.w, // Keeping height the same as width for a square
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 AnimatedBuilder(
//                   animation: _controller!,
//                   builder: (_, child) {
//                     return Transform.rotate(
//                       angle: _controller!.value * 2 * pi,
//                       child: child,
//                     );
//                   },
//                   child: Image.asset(
//                     TImages.medicalPattern,
//                     color: isDark ? TColors.softGrey : TColors.primary,
//                   ),
//                 ),
//                 Image.asset(
//                   TImages.appLogo,
//                   height: 8.h,
//                   cacheWidth: 176,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
