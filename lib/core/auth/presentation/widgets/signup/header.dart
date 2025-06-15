import '../../../../../flavors.dart';
import '../widgets.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // final instance = AuthController.instance;
    final textTheme = Get.textTheme;
    return Column(
      children: [
        const SizedBox(height: TSizes.defaultSpace),
        Text(
          'Register for free!'.capitalize!,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Create an account now and join the crypto revolution with ${F.title}.',
          textAlign: TextAlign.center,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
