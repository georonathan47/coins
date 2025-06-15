import '../widgets.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => RememberMeState();
}

class RememberMeState extends State<RememberMe> {
  final instance = AuthController.instance;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Obx(
              () => Checkbox(
                value: instance.rememberMe.value,
                onChanged: (value) {
                  instance.rememberMe.value = value ?? false;
                },
                activeColor: TColors.accent,
              ),
            ),
            const Text('Remember Me', style: TextStyle(fontSize: 16)),
          ],
        ),
        TextButton(
          onPressed: () {},
          // onPressed: () => Get.toNamed(Routers.reset),
          style: TextButton.styleFrom(foregroundColor: TColors.accent),
          child: Text(
            'Forgot Password?',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
