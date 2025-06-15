import 'dart:developer';

import '../widgets/widgets.dart';

class SignupCaptcha extends StatefulWidget {
  const SignupCaptcha({super.key});

  @override
  State<StatefulWidget> createState() => SignupCaptchaState();
}

class SignupCaptchaState extends State<SignupCaptcha> {
  final user = Get.arguments as User;
  final instance = AuthController.instance;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final controller = WebViewController()
      ..loadRequest(Uri.parse(Env.captchaUrl))
      ..setBackgroundColor(Colors.transparent)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Captcha',
        onMessageReceived: (message) async {
          instance.captchaMessage.value = message.message;
          log(instance.captchaMessage.value, name: 'Captcha Msg');
          showDialog(
            context: context,
            builder: (_) => Center(
              child: const CircularProgressIndicator(color: TColors.secondary),
            ),
          );
          final request = user.copyWith(
            captchaResponse: instance.captchaMessage.value,
          );
          await instance.trySignup(request);
        },
      );

    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          title: Text('CAPTCHA', style: textTheme.titleMedium),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.sizeOf(context).height * 0.075,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'One more step... Verify you are human',
                style: textTheme.bodyLarge,
              ),
            ),
          ),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
