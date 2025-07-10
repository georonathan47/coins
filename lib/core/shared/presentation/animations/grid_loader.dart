// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class GridLoadingWidget extends StatelessWidget {
//   const GridLoadingWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = Get;
//     return Skeletonizer(
//       enabled: true,
//       enableSwitchAnimation: true,
//       child: AnimationLimiter(
//         child: GridView.builder(
//           itemCount: 3,
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 250,
//             childAspectRatio: 0.775,
//             mainAxisSpacing: size.width * 0.095,
//             crossAxisSpacing: size.width * 0.05,
//           ),
//           itemBuilder: (_, index) {
//             return AnimationConfiguration.staggeredGrid(
//               position: index,
//               columnCount: size.width < 600 ? 1 : 2,
//               duration: const Duration(milliseconds: 375),
//               child: const ScaleAnimation(
//                 // child: ShopItem(product: Product.initial(), index: index),
//                 child: Card(),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
