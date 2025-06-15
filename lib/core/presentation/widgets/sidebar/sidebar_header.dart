import '../../../../flavors.dart';
import '../../../auth/presentation/widgets/widgets.dart';

class NavDrawerHeader extends StatelessWidget {
  const NavDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final textTheme = Get.textTheme;
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        top: TDeviceUtils.getAppBarHeight() / 2,
        right: 16,
        left: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            TImages.logo,
            height: size.height * 0.05,
            color: isDark ? TColors.light : TColors.primary,
          ),
          const SizedBox(width: TSizes.spaceBtwInputFields),
          Expanded(
            flex: 4,
            child: Text(
              F.title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                height: 1.5,
                color: isDark ? TColors.light : TColors.primary,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.close,
              size: TSizes.iconLg,
              color: isDark ? TColors.light : TColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
