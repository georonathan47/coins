
import 'widgets.dart';

class ResetBody extends StatefulWidget {
  const ResetBody({super.key});

  @override
  State<ResetBody> createState() => _ResetBodyState();
}

class _ResetBodyState extends State<ResetBody> {
  final instance = AuthController.instance;
  final shouldShow = ValueNotifier<bool>(true);
  final shouldShowConfirm = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: instance.resetKey.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [TColors.accent, Color(0xFFF2A516)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_outline,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Want to change your password?',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Don't worry... We've got you covered! Just enter your new password below.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 40),
          ValueListenableBuilder(
            valueListenable: shouldShow,
            builder: (context, value, child) {
              return TextFormField(
                obscureText: value,
                controller: instance.passwordController.value,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter a strong password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: TColors.secondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      shouldShow.value = !value;
                    },
                    tooltip: value ? 'Show password' : 'Hide password',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: TColors.secondary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  helperText: 'Must be at least 8 characters long',
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
                  labelText: 'Confirm New Password',
                  hintText: 'Re-enter your password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: TColors.secondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      shouldShowConfirm.value = !value;
                    },
                    tooltip: value ? 'Show password' : 'Hide password',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: TColors.secondary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  helperText: 'Both passwords must match',
                ),
                validator: TValidator.validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              );
            },
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          ElevatedButton(
            onPressed: () async {
              if (instance.passwordController.value.text !=
                  instance.confirmController.value.text) {
                THelperFunctions.showSnackBar(
                  title: 'Password Mismatch',
                  bgColor: TColors.error,
                  message: 'The passwords do not match. Please try again.',
                );
                return;
              }
              if (instance.resetKey.value.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
                final request = ResetPassword(
                  userId: instance.currentUser.value.userId,
                  newPassword: instance.passwordController.value.text,
                );
                await instance.resetPassword(request);
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}
