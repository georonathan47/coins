import 'package:cached_network_image/cached_network_image.dart';

import 'widgets.dart';

class HistoryCardShimmer extends StatelessWidget {
  const HistoryCardShimmer({super.key});

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerAnimation(
                    child: Text('', style: textTheme.titleLarge),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  ShimmerAnimation(
                    child: Row(
                      children: [
                        Text('', style: textTheme.titleMedium),
                        Text('', style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  ShimmerAnimation(
                    child: Row(
                      children: [
                        Text('', style: textTheme.titleMedium),
                        Text('', style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  ShimmerAnimation(
                    child: Row(
                      children: [
                        Text('', style: textTheme.titleMedium),
                        Text('', style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  ShimmerAnimation(
                    child: Row(
                      children: [
                        Text('', style: textTheme.titleMedium),
                        Text('', style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            ShimmerAnimation(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: '',
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).height * 0.075,
                  height: MediaQuery.sizeOf(context).height * 0.075,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_outlined,
                    color: TColors.accent,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
