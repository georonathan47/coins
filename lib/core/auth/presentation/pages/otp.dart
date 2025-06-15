import '../../data/models/verify_otp_model.dart';
import '../widgets/widgets.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final instance = AuthController.instance;
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Verify Account',
            style: textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
        ),
        body: SafeArea(
          top: true,
          bottom: false,
          child: ScrollableWidget(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.375,
                child: Lottie.network(TImages.lottieImage),
              ),
              SizedBox(height: 2.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter 6-digit pin sent to:',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Text(
                      instance.emailController.value.text,
                      style: textTheme.titleMedium!.copyWith(
                        letterSpacing: .75,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Pinput(
                length: 6,
                controller: pinController,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                defaultPinTheme: PinTheme(
                  height: MediaQuery.sizeOf(context).height * 0.075,
                  textStyle: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: TColors.grey),
                  ),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                  final request = VerifyOtpModel(
                    otp: pinController.text,
                    type: 'EMAIL',
                  );
                  await instance.verifyOtp(request);
                },
                child: Text('Submit'),
              ),
              const SizedBox(height: 22),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Didn't receive code? ",
                    style: textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: 'Resend!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () async {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
