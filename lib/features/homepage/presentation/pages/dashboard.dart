import '../../../../core/shared/presentation/widgets/sidebar/sidebar.dart';
import '../widgets/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(
                FontAwesomeIcons.alignLeft,
                color: isDark ? TColors.light : TColors.primary,
              ),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            color: isDark ? TColors.light : TColors.primary,
            icon: const AnimatedIcon(
              icon: AnimatedIcons.search_ellipsis,
              progress: AlwaysStoppedAnimation(0.0),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.bell),
            color: isDark ? TColors.light : TColors.primary,
          ),
        ],
      ),
      drawer: const Sidebar(),
      body: const DashboardBody(),
    );
  }
}
