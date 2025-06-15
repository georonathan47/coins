import '../widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final instance = AuthController.instance;
  final shouldShow = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Form(
      key: instance.loginKey.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoginHeader(),
          const SizedBox(height: 40),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            controller: instance.emailController.value,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            validator: TValidator.validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: shouldShow,
            builder: (context, value, child) {
              return TextFormField(
                obscureText: value,
                controller: instance.passwordController.value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      shouldShow.value = !value;
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              );
            },
          ),
          const SizedBox(height: 16),
          RememberMe(),
          // const SizedBox(height: 16),
          // Container(
          //   color: TColors.accent,
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   height: MediaQuery.of(context).size.height * 0.075,
          //   child: FutureBuilder(
          //     future: getCaptcha(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return const Center(child: Text('Captcha Loaded'));
          //       } else if (snapshot.connectionState ==
          //           ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator());
          //       } else {
          //         return const Center(child: Text('Error'));
          //       }
          //     },
          //   ),
          // ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                if (!instance.loginKey.value.currentState!.validate()) {
                  THelperFunctions.showSnackBar(
                    title: 'Error',
                    bgColor: TColors.error,
                    message: 'Please fill in all required fields.',
                  );
                  return;
                }
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return const Center(child: CircularProgressIndicator());
                //   },
                // );
                // await instance.tryLogin();
                Get.toNamed(Routers.captcha);
              },
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[400])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('OR', style: textTheme.titleLarge),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SignupSocials(
                  label: 'Google',
                  icon: Icons.g_mobiledata,
                  color: TColors.secondary,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SignupSocials(
                  label: 'Apple',
                  icon: Icons.apple,
                  color: TColors.secondary,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SignupRow(),
        ],
      ),
    );
  }
}
