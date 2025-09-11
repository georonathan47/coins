import '../widgets.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final textTheme = Get.textTheme;
    return SliverAppBar(
      pinned: true,
      floating: true,
      centerTitle: true,
      expandedHeight: Get.height * 0.35,
      flexibleSpace: FlexibleSpaceBar(
        background: AnimatedGradientColoring(
          padding: 8,
          endColor: TColors.primary,
          startColor: TColors.secondary,
          child: SafeArea(
            child: GetBuilder<AuthController>(
              builder: (instance) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 20), // Space for app bar
                    // Profile Avatar with border
                    Stack(
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
                    SizedBox(height: 16),
                    // Name and Email
                    Text(
                      instance.currentUser.value.fullName,
                      style: textTheme.titleLarge?.copyWith(
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      instance.currentUser.value.email ?? 'N/A',
                      style: textTheme.bodySmall?.copyWith(
                        letterSpacing: 0.25,
                        color: Colors.white,
                      ),
                    ),
                    Visibility(
                      visible:
                          Get.find<KycLocalDatabase>().getStatus() !=
                          Future.value(KycStatus.approved),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          // Verify Account Button
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width / 5,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.find<AuthGuard>().checkKycAndExecute(
                                    () {},
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: isDark
                                      ? TColors.white
                                      : Color(0xFF4A6B7A),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor: isDark
                                      ? TColors.dark
                                      : TColors.white,
                                ),
                                child: Text('Verify Account'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
