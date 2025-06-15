import '../widgets.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  late String phoneNumber;
  final selectedCountry = 'Ghana'.obs;
  final instance = AuthController.instance;
  final shouldShow = ValueNotifier<bool>(true);
  final shouldShowConfirm = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    // final textTheme = Get.textTheme;
    return Form(
      key: instance.signupKey.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SignupHeader(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: instance.firstnameController.value,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'First Name',
                    hintText: 'Enter your first name',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  validator: TValidator.validateName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: instance.lastnameController.value,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Last Name',
                    hintText: 'Enter your last name',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  validator: TValidator.validateName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          Obx(
            () => IntlPhoneField(
              initialCountryCode: 'GH',
              textInputAction: TextInputAction.done,
              validator: TValidator.validatePhoneNumber,
              controller: instance.phoneController.value,
              decoration: const InputDecoration(
                filled: true,
                hintText: '024 *** ****',
                labelText: 'Phone Number',
              ),
              style: TextStyle(fontSize: 16),
              onChanged: (phone) {
                phoneNumber = phone.completeNumber;
              },
              onCountryChanged: (country) {
                setState(() => selectedCountry.value = country.name);
              },
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: instance.emailController.value,
            autofillHints: const [AutofillHints.email],
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email_outlined),
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
            validator: TValidator.validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
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
                validator: TValidator.validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              );
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          ValueListenableBuilder(
            valueListenable: shouldShowConfirm,
            builder: (context, value, child) {
              return TextFormField(
                obscureText: value,
                controller: instance.confirmController.value,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      shouldShowConfirm.value = !value;
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
                validator: TValidator.validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              );
            },
          ),

          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                if (instance.signupKey.value.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );

                  final user = User.empty().copyWith(
                    phoneNumber: phoneNumber,
                    country: selectedCountry.value,
                    email: instance.emailController.value.text,
                    password: instance.passwordController.value.text,
                    lastname: instance.lastnameController.value.text,
                    firstname: instance.firstnameController.value.text,
                  );
                  // await instance.trySignup(user);
                  Get.toNamed(Routers.regCaptcha, arguments: user);
                } else {
                  THelperFunctions.showSnackBar(
                    title: 'Error',
                    bgColor: TColors.error,
                    message: 'Please fill in all required fields.',
                  );
                }
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwSections),
          LoginRow(),
        ],
      ),
    );
  }
}
