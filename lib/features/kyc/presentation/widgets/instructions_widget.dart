import 'widgets.dart';

class InstructionsWidget extends StatelessWidget {
  const InstructionsWidget({super.key, required this.instruction});
  final String instruction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            Icons.circle,
            size: TSizes.iconXs,
            color: Get.isDarkMode ? TColors.light : TColors.primary,
          ),
        ),
        Expanded(flex: 8, child: Text(instruction, style: textTheme.bodyLarge)),
      ],
    );
  }
}
