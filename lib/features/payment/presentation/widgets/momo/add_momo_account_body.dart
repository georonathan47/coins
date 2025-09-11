// import '../widgets.dart';
// import 'momo_form.dart';

// class AddMomoAccountBody extends StatelessWidget {
//   const AddMomoAccountBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Get.textTheme;
//     return GetBuilder<PayAccountsController>(
//       builder: (instance) {
//         return ScrollableWidget(
//           padding: 8,
//           children: [
//             Container(
//               height: Get.height / 5.25,
//               padding: EdgeInsets.all(TSizes.md),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(TSizes.md),
//                 color: TColors.error.withAlpha(100),
//               ),
//               child: ScrollableWidget(
//                 padding: 0,
//                 children: [
//                   Text(
//                     'Please ensure that the momo account details you provide are in your name, your control and matches the identification details you provided during your KYC verification. We are not responsible for liabilities therein.',
//                     style: textTheme.bodyMedium?.copyWith(fontSize: 14),
//                   ),
//                   RichText(
//                     text: TextSpan(
//                       text: 'Tap here',
//                       style: textTheme.bodyMedium?.copyWith(
//                         color: TColors.accent,
//                         fontWeight: FontWeight.bold,
//                         decorationColor: TColors.accent,
//                         decoration: TextDecoration.underline,
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         // ToDo: Implement navigation to Terms of Service
//                         ..onTap = () {},
//                       children: [
//                         TextSpan(
//                           text: ' to read our Terms of Service.',
//                           style: textTheme.bodyMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const MomoForm(),
//             SizedBox(height: TSizes.spaceBtwItems),
//             ElevatedButton(
//               onPressed: () async {
//                 showDialog(
//                   context: context,
//                   builder: (_) => Center(
//                     child: Container(
//                       padding: const EdgeInsets.all(20),
//                       margin: const EdgeInsets.symmetric(horizontal: 40),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const CircularProgressIndicator(),
//                           const SizedBox(height: 16),
//                           Text('Loading...', style: textTheme.bodyMedium),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//                 await instance.addAccount();
//               },
//               child: Text('Add Mobile Account'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
