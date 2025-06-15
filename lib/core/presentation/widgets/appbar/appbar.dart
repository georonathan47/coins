import '../../../auth/presentation/widgets/widgets.dart';
import '../../animations/animated_appbar.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Custom appbar for achieving a desired design goal.
  /// - Set [title] for a custom title.
  /// - [showBackArrow] to toggle the visibility of the back arrow.
  /// - [leadingIcon] for a custom leading icon.
  /// - [leadingOnPressed] callback for the leading icon press event.
  /// - [actions] for adding a list of action widgets.
  /// - Horizontal padding of the appbar can be customized inside this widget.
  const TAppBar({super.key, this.title, this.actions, this.bottom, this.leading});

  final List<Widget>? actions;
  final Widget? title, leading;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      bottom: bottom,
      actions: actions,
      leading: leading,
      centerTitle: bottom != null,
      flexibleSpace: AnimatedGradientFlexibleSpace(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
