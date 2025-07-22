// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// import '../../../features/application/domain/entities/fetch_response.dart';
// import '../../../features/application/presentation/widgets/application_card.dart';

// class ListLoadingWidget extends StatelessWidget {
//   const ListLoadingWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Skeletonizer(
//       enabled: true,
// 			enableSwitchAnimation: true,
//       child: ListView.builder(
//         itemCount: 4,
//         physics: const NeverScrollableScrollPhysics(),
// 				 padding: EdgeInsets.symmetric(
//           vertical: Adaptive.h(.5),
//           horizontal: Adaptive.w(2),
//         ),
//         itemBuilder: (_, index) {
//           return ApplicationDetailsCard(data: FetchResponse.initial());
//         },
//       ),
//     );
//   }
// }
