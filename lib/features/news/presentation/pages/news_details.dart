import '../../../../core/shared/formatters/formatter.dart';
import '../../domain/entities/news.dart';
import '../controller/news_controller.dart';
import '../widgets/widget.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    final news = Get.arguments as News;

    return FlavorBanner(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Hero Image with Gradient Overlay
            SliverAppBar(
              expandedHeight: Get.height * 0.4,
              floating: false,
              pinned: true,
              stretch: true,
              elevation: 0,
              backgroundColor: TColors.primary,
              automaticallyImplyLeading: false,
              leading: Container(
                margin: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: TColors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: TColors.white,
                    size: TSizes.iconMd,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
              actions: [
                GetBuilder<NewsController>(
                  builder: (instance) {
                    return Container(
                      margin: const EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                        color: TColors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(
                          TSizes.borderRadiusMd,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.share,
                          color: TColors.white,
                          size: TSizes.iconMd,
                        ),
                        onPressed: () => instance.share(),
                      ),
                    );
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: news.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: TColors.grey,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: TColors.grey,
                        child: Icon(
                          Icons.broken_image,
                          size: TSizes.iconLg,
                          color: TColors.darkGrey,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            TColors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Article Content
            SliverToBoxAdapter(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Headline Section
                    Container(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.headline,
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),

                          // Meta Information Row
                          Row(
                            children: [
                              Icon(Icons.access_time, size: TSizes.iconSm),
                              const SizedBox(width: TSizes.xs),
                              Text(
                                TFormatter.formatDateString(news.datePosted),
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: TSizes.md),
                              Icon(Icons.source, size: TSizes.iconSm),
                              const SizedBox(width: TSizes.xs),
                              Expanded(
                                child: Text(
                                  news.source,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: TColors.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Crypto Assets Tags
                    Visibility(
                      visible: news.cryptoAssets.isNotEmpty,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.defaultSpace,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Related Crypto Assets',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: TSizes.sm),
                            Wrap(
                              spacing: TSizes.sm,
                              runSpacing: TSizes.sm,
                              children: news.cryptoAssets.map((asset) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: TSizes.md,
                                    vertical: TSizes.sm,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? TColors.light.withOpacity(0.1)
                                        : TColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(
                                      TSizes.borderRadiusLg,
                                    ),
                                    border: Border.all(
                                      color: Get.isDarkMode
                                          ? TColors.light.withOpacity(0.3)
                                          : TColors.primary.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    asset.toUpperCase(),
                                    style: textTheme.bodySmall?.copyWith(
                                      color: Get.isDarkMode
                                          ? TColors.light
                                          : TColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: TSizes.spaceBtwSections),
                          ],
                        ),
                      ),
                    ),

                    // Divider
                    const Divider(
                      color: TColors.borderPrimary,
                      thickness: 1,
                      indent: TSizes.defaultSpace,
                      endIndent: TSizes.defaultSpace,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Article Content
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Article',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Text(
                            news.content,
                            style: textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                              fontSize: TSizes.fontSizeLg,
                              letterSpacing: 0.2,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections * 2),
                        ],
                      ),
                    ),

                    // Bottom Action Section
                    // Container(
                    //   padding: const EdgeInsets.all(TSizes.defaultSpace),
                    //   decoration: BoxDecoration(
                    //     color: TColors.light,
                    //     border: Border(
                    //       top: BorderSide(
                    //         color: TColors.borderPrimary,
                    //         width: 1,
                    //       ),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: ElevatedButton.icon(
                    //           onPressed: () {
                    //             // TODO: Implement bookmark functionality
                    //           },
                    //           icon: const Icon(Icons.bookmark_border),
                    //           label: const Text('Save Article'),
                    //           style: ElevatedButton.styleFrom(
                    //             backgroundColor: TColors.primary,
                    //             foregroundColor: TColors.white,
                    //             padding: const EdgeInsets.symmetric(
                    //               vertical: TSizes.md,
                    //             ),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(
                    //                 TSizes.borderRadiusMd,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(width: TSizes.md),
                    //       OutlinedButton.icon(
                    //         onPressed: () {
                    //           // TODO: Implement share functionality
                    //         },
                    //         icon: const Icon(Icons.share),
                    //         label: const Text('Share'),
                    //         style: OutlinedButton.styleFrom(
                    //           foregroundColor: TColors.primary,
                    //           side: BorderSide(color: TColors.primary),
                    //           padding: const EdgeInsets.symmetric(
                    //             horizontal: TSizes.lg,
                    //             vertical: TSizes.md,
                    //           ),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(
                    //               TSizes.borderRadiusMd,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
