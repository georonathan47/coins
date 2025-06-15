import '../widgets.dart';

class SignupRow extends StatelessWidget {
  const SignupRow({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ", style: textTheme.bodyLarge),
        TextButton(
          onPressed: () => Get.offNamed(Routers.register),
          child: Text(
            'Sign Up',
            style: textTheme.titleMedium!.copyWith(color: TColors.secondary),
          ),
        ),
      ],
    );
  }
}
