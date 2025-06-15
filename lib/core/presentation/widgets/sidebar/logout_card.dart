import 'package:cached_network_image/cached_network_image.dart';

import '../../../auth/presentation/widgets/widgets.dart';
import '../../animations/animated_gradient_coloring.dart';

class LogoutCard extends StatefulWidget {
  const LogoutCard({super.key});

  @override
  State<LogoutCard> createState() => LogoutCardState();
}

class LogoutCardState extends State<LogoutCard> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final instance = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnimatedGradientColoring(
      startColor: TColors.accent,
      endColor: TColors.secondary,
      child: Container(
        width: double.infinity,
        height: size.height * 0.12,
        padding: const EdgeInsets.symmetric(
          horizontal: TSizes.spaceBtwInputFields / 4,
          vertical: TSizes.spaceBtwItems / 2,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: TColors.light, width: 2),
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: TColors.light.withOpacity(0.1),
                child: ClipOval(
                  child: CachedNetworkImage(
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    memCacheWidth: 120,
                    memCacheHeight: 120,
                    imageUrl: instance.currentUser.value.profilePicture ?? '',
                    placeholder: (ctx, url) => const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: TColors.light,
                    ),
                    errorWidget: (ctx, url, error) =>
                        Image.asset(TImages.logoWhite, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    instance.currentUser.value.fullName,
                    style: textTheme.titleMedium?.copyWith(
                      color: TColors.light,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: TSizes.xs),
                  Center(
                    child: Text(
                      instance.currentUser.value.email!.replaceRange(
                        3,
                        instance.currentUser.value.email!.indexOf('@'),
                        '****',
                      ),
                      style: textTheme.bodyMedium?.copyWith(
                        color: TColors.lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => instance.showLogoutDialog(),
              style: IconButton.styleFrom(
                backgroundColor: TColors.light.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                ),
              ),
              icon: Icon(
                Iconsax.logout,
                size: TSizes.iconLg,
                color: TColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
