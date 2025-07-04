import '../../../../features/homepage/presentation/widgets/widgets.dart';
import '../../../../features/kyc/presentation/controller/kyc_controller.dart';
import '../../../../flavors.dart';
import '../../../middleware/auth_guard.dart';
import '../../../utils/logger.dart';
import 'logout_card.dart';
import 'sidebar_category.dart';
import 'sidebar_header.dart';
import 'sidebar_menu_items.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final instance = KycController.instance;

  @override
  void initState() {
    super.initState();
    instance.checkSidebarStatus();
    TLoggerHelper.logEvent(
      'Sidebar initialized with KYC status: ${instance.statusResult.value}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Drawer(
        width: Get.width * 0.75,
        child: Column(
          children: [
            Expanded(
              child: ScrollableWidget(
                padding: 8,
                physics: const BouncingScrollPhysics(),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: TSizes.defaultSpace),
                  const NavDrawerHeader(),
                  SizedBox(height: TSizes.defaultSpace),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Account
                      SidebarCategory(
                        title: 'Account',
                        icon: Iconsax.user,
                        children: [
                          NavDrawerItem(
                            icon: Icons.person,
                            text: 'Verify Account',
                            onTap: () {
                              Get.back();

                              Get.find<AuthGuard>().checkKycAndExecute(() {});
                            },
                          ),
                          NavDrawerItem(
                            icon: Iconsax.money_2,
                            text: 'Payment Methods',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                          NavDrawerItem(
                            icon: Icons.settings_outlined,
                            text: 'Settings',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                        ],
                      ),

                      // Transactions
                      const SizedBox(height: TSizes.spaceBtwSections / 2),
                      SidebarCategory(
                        title: 'Transactions',
                        icon: Iconsax.transaction_minus,
                        children: [
                          NavDrawerItem(
                            icon: Icons.swap_horiz,
                            text: 'Trade',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                          NavDrawerItem(
                            icon: Icons.history,
                            text: 'Order History',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                        ],
                      ),

                      // Communication
                      const SizedBox(height: TSizes.spaceBtwSections / 2),
                      SidebarCategory(
                        title: 'Communication',
                        icon: Iconsax.message_notif,
                        children: [
                          NavDrawerItem(
                            icon: CupertinoIcons.bell,
                            text: 'Notifications',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                          NavDrawerItem(
                            icon: Iconsax.danger,
                            text: 'Report An Issue',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                        ],
                      ),

                      // Help & Support
                      const SizedBox(height: TSizes.spaceBtwSections / 2),
                      SidebarCategory(
                        title: 'Help & Support',
                        icon: Iconsax.message_question,
                        children: [
                          NavDrawerItem(
                            icon: CupertinoIcons.bell,
                            text: 'About Us',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                          NavDrawerItem(
                            icon: Iconsax.danger,
                            text: '${F.title} Academy',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                          NavDrawerItem(
                            icon: Icons.question_answer_outlined,
                            text: 'FAQs',
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const LogoutCard(),
          ],
        ),
      ),
    );
  }
}
