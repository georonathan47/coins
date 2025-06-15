import 'dart:developer';

import '../widgets/widgets.dart';

class LoginCaptcha extends StatefulWidget {
  const LoginCaptcha({super.key});

  @override
  State<StatefulWidget> createState() => LoginCaptchaState();
}

class LoginCaptchaState extends State<LoginCaptcha> {
  @override
  Widget build(BuildContext context) {
    final instance = AuthController.instance;
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
          await instance.tryLogin();
        },
      );

    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          title: Text(
            'CAPTCHA',
            style: textTheme.titleMedium?.copyWith(color: TColors.light),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.sizeOf(context).height * 0.075,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'One more step... Verify you are human',
                style: textTheme.bodyLarge?.copyWith(color: TColors.light),
              ),
            ),
          ),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
