import '../widgets.dart';

class LoginRow extends StatelessWidget {
  const LoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? ", style: textTheme.bodyLarge),
        TextButton(
          onPressed: () => Get.offNamed(Routers.login),
          child: Text(
            'Sign In',
            style: textTheme.titleMedium!.copyWith(
              letterSpacing: .75,
              color: TColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
