import '../widgets.dart';

class PersonalDetailsHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const PersonalDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      centerTitle: true,
      expandedHeight: Get.height * 0.2,
      flexibleSpace: FlexibleSpaceBar(
        background: AnimatedGradientColoring(
          padding: 8,
          endColor: TColors.primary,
          startColor: TColors.secondary,
          child: SafeArea(
            child: GetBuilder<AuthController>(
              builder: (instance) {
                return Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 57,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=120&h=120&fit=crop&crop=face',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Color(0xFF4A6B7A),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
