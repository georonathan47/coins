import 'widgets.dart';

class KYCInformatics extends StatelessWidget {
  const KYCInformatics({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });
  final String title, message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Icon(
            icon,
            size: TSizes.iconLg,
            color: Get.isDarkMode ? TColors.light : TColors.primary,
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium!.copyWith(
                  fontSize: 18,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                message,
                style: textTheme.titleSmall!.copyWith(
                  letterSpacing: .75,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
