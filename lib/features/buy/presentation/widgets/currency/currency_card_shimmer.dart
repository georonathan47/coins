import '../widgets.dart';

class CurrencyCardShimmer extends StatelessWidget {
  const CurrencyCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ShimmerAnimation(
              child: ClipOval(
                child: CircleAvatar(
                  // child: CachedNetworkImage(
                  //   imageUrl: '',
                  //   width: 60,
                  //   height: 60,
                  //   fit: BoxFit.cover,
                  //   color: TColors.secondary,
                  //   errorWidget: (ctx, url, error) => const Icon(Iconsax.money),
                  // ),
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerAnimation(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerAnimation(
                          child: Text('', style: textTheme.titleMedium),
                        ),
                        ShimmerAnimation(
                          child: Text(
                            '',
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  ShimmerAnimation(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerAnimation(
                          child: Text('', style: textTheme.titleSmall),
                        ),
                        ShimmerAnimation(
                          child: Text('', style: textTheme.titleSmall),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
