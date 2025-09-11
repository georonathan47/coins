import 'widgets.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ProfileMenu(
          title: 'Personal Details',
          icon: Icons.person_outline,
          subtitle: 'Manage your personal information',
          onTap: () {},
        ),
        ProfileMenu(
          icon: Icons.security,
          title: 'Security Settings',
          subtitle: 'OTP and password options',
          onTap: () {},
        ),
        ProfileMenu(
          icon: Icons.notifications_none,
          title: 'Notification Preference Details',
          subtitle: 'Manage your notification preferences',
          onTap: () {},
        ),
        ProfileMenu(
          icon: Icons.language,
          title: 'Language and Currency',
          subtitle: 'Change app language and currency',
          onTap: () {},
        ),
        ProfileMenu(
          isDestructive: true,
          title: 'Delete Account',
          icon: Icons.delete_outline,
          subtitle: 'Suspend or deactivate account',
          onTap: () {},
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
