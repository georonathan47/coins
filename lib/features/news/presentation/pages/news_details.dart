import '../widgets/widget.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return FlavorBanner(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  collapsedHeight: Get.height / 9,
                  expandedHeight: Get.height / 5.5,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      color: Colors.black54,

                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'FlutterGigs Tip of the Week',
                        style: textTheme.titleSmall?.copyWith(
                          color: TColors.white,
                        ),
                      ),
                    ),
                    background: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: TImages.dummyNewsImg,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      return Card(
                        child: Container(
                          height: Get.height / 1.35,
                          padding: const EdgeInsetsDirectional.all(TSizes.md),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Center(
                              child: Text(
                                '${TTexts.infoInNews} \n\n ${TTexts.infoInNews}',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 1, // Generate 30 items
                  ),
                ),
              ],
            ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.015,
              child: IconButton(
                iconSize: 35,
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  blendMode: BlendMode.exclusion,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
