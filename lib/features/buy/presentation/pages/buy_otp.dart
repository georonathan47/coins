
import '../widgets/widgets.dart';

class BuyOtp extends StatefulWidget {
  const BuyOtp({super.key});

  @override
  State<BuyOtp> createState() => BuyOtpState();
}

class BuyOtpState extends State<BuyOtp> {
  final textTheme = Get.textTheme;
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return FlavorBanner(
      child: Scaffold(
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // showDialog(
                //   context: context,
                //   builder: (context) =>
                //       const Center(child: CircularProgressIndicator()),
                // );
                // final request = VerifyOtpModel(
                //   otp: pinController.text,
                //   type: 'IN_APP',
                // );
                // await instance.verifyOtp(request);
                Get.offAllNamed(Routers.buySuccess);
              },
              child: Text(
                'Verify OTP',
                style: textTheme.titleMedium!.copyWith(
                  letterSpacing: 1.5,
                  color: TColors.light,
                ),
              ),
            ),
          ),
        ],
        appBar: TAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.15,
                child: Image.asset(TImages.logo),
              ),
              Text(
                F.title,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge,
              ),
              SizedBox(height: size.height * 0.08),
              Text(
                'Verify your identity'.capitalize!,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge,
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                'We sent a code to your email. Please check and enter the code to verify your identity.',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: size.height * 0.05),

              Pinput(
                length: 6,
                controller: pinController,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                defaultPinTheme: PinTheme(
                  width: size.height * 0.075,
                  height: size.height * 0.075,
                  textStyle: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Get.isDarkMode ? TColors.grey : TColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.025),
              Text("Didn't receive the code? ", style: textTheme.bodyLarge),
              SizedBox(height: size.height * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}
