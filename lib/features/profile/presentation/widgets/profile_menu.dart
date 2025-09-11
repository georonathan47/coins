import '../widgets/widgets.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final textTheme = Get.textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDark ? TColors.dark : TColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withOpacity(0.1)
                : isDark
                ? TColors.secondary.withOpacity(0.1)
                : const Color(0xFF4A6B7A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 22,
            color: isDestructive
                ? Colors.red
                : isDark
                ? TColors.secondary
                : const Color(0xFF4A6B7A),
          ),
        ),
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontSize: 16,
            letterSpacing: 0.75,
            fontWeight: FontWeight.w600,
            color: isDestructive
                ? Colors.red
                : isDark
                ? Colors.white
                : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: isDark ? Colors.grey[400] : Colors.black54,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }
}
