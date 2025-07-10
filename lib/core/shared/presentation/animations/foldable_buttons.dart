import '../../../auth/presentation/widgets/widgets.dart';

class FoldableOptions extends StatefulWidget {
  const FoldableOptions({super.key, required this.onTap});
  final List<VoidCallback> onTap;

  @override
  FoldableOptionsState createState() => FoldableOptionsState();
}

class FoldableOptionsState extends State<FoldableOptions>
    with SingleTickerProviderStateMixin {
  final List<IconData> options = [
    Icons.message_outlined,
    Icons.person_add_alt_1_outlined,
    Icons.question_answer_outlined,
    Icons.store_mall_directory_outlined,
    Icons.star_border_purple500_outlined,
  ];

  Animation<Alignment>? firstAnim;
  Animation<Alignment>? thirdAnim;
  Animation<Alignment>? fifthAnim;
  AnimationController? controller;
  Animation<Alignment>? secondAnim;
  Animation<Alignment>? fourthAnim;
  Animation<double>? verticalPadding;
  final duration = Duration(milliseconds: 190);

  Widget getItem(IconData source) {
    final size = 45.0;
    return InkWell(
      onTap: () {
        controller!.reverse();
        widget.onTap[options.indexOf(source)]();
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: TColors.secondary,
          // color: TColors.accent,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Icon(source, color: Colors.white.withOpacity(1.0), size: 25),
      ),
    );
  }

  Widget buildPrimaryItem(IconData source) {
    final size = 45.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: TColors.secondary,
        // color: TColors.accent,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: TColors.secondary.withOpacity(0.8),
            // color: TColors.accent.withOpacity(0.8),
            blurRadius: verticalPadding!.value,
          ),
        ],
      ),
      child: Icon(source, color: Colors.white.withOpacity(1), size: 25),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);

    final anim = CurvedAnimation(parent: controller!, curve: Curves.linear);
    firstAnim = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.topRight,
    ).animate(anim);
    secondAnim = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.topLeft,
    ).animate(anim);
    thirdAnim = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).animate(anim);
    fourthAnim = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.bottomLeft,
    ).animate(anim);
    fifthAnim = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.bottomRight,
    ).animate(anim);
    verticalPadding = Tween<double>(begin: 0, end: 26).animate(anim);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 210,
      margin: EdgeInsets.only(right: 15),
      child: AnimatedBuilder(
        animation: controller!,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: firstAnim!.value,
                child: getItem(options.elementAt(0)),
              ),
              Align(
                alignment: secondAnim!.value,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 37,
                    top: verticalPadding!.value,
                  ),
                  child: getItem(options.elementAt(1)),
                ),
              ),
              Align(
                alignment: thirdAnim!.value,
                child: getItem(options.elementAt(2)),
              ),
              Align(
                alignment: fourthAnim!.value,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 38,
                    bottom: verticalPadding!.value,
                  ),
                  child: getItem(options.elementAt(3)),
                ),
              ),
              Align(
                alignment: fifthAnim!.value,
                child: getItem(options.elementAt(4)),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    controller!.isCompleted
                        ? controller!.reverse()
                        : controller!.forward();
                  },
                  child: buildPrimaryItem(
                    controller!.isCompleted || controller!.isAnimating
                        ? Icons.close
                        : Icons.add,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
