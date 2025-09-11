import '../widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom SliverAppBar for the profile header
          const ProfileHeader(),

          // Refer Friends Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: GetBuilder<ProfileController>(
                builder: (instance) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: const Icon(Icons.share, color: Colors.white),
                    title: const Text(
                      'Refer your friends',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text(
                      'Invite friends, earn rewards!',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.white70,
                    ),
                    onTap: () => instance.share(),
                  );
                },
              ),
            ),
          ),

          // Menu Items
          const ProfileMenuList(),
        ],
      ),
    );
  }
}
