import '../../data/models/auth_response.dart';

import '../widgets/widgets.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  num? remValue;
  final resendingToken = ValueNotifier(0);
  final verificationID = ValueNotifier('');
  final instance = AuthController.instance;
  final user = Get.arguments as AuthResponse;
  final size = MediaQuery.of(Get.context!).size;
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    remValue = 300.0;
    // TODO: Make the function below cleaner
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await GetHttpClient().get(
        user.userEmail!.isEmpty
            ? '${Env.loginUrl}/${user.userEmail}?userId=${user.userId}'
            : '${Env.sendOtpUrl}?userId=${user.userId}&otpType=EMAIL',
      );
      // check if the response is successful

      if (result.statusCode == 200) {
        // THelperFunctions.showSuccessToast('OTP Sent');
        THelperFunctions.showSnackBar(
          title: 'Success',
          bgColor: TColors.success,
          message: 'An OTP has been sent to your provided details!',
        );
      } else {
        // THelperFunctions.showErrorToast(otpResponse.body);
        Get.back();
      }
    });
  }

  final textTheme = Get.textTheme;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: textTheme.bodyLarge!.copyWith(
        fontSize: 24,
        color: TColors.accent,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: TColors.primary),
      ),
    );

    return PopScope(
      onPopInvoked: (value) async => false,
      child: FlavorBanner(
        child: Scaffold(
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            SizedBox(
              height: 50,
              width: size.width * 0.85,
              child: ValueListenableBuilder(
                valueListenable: verificationID,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: null,

                    // onPressed: widget.isEmail == true
                    //     ? () async {
                    //         showDialog(
                    //           context: context,
                    //           builder: (context) => const ProgressDialog(
                    //             displayMessage:
                    //                 'Verifying Email...\nPlease wait!',
                    //           ),
                    //         );
                    //         final config = await ApiConfigs.forEnvironment(
                    //           envVar,
                    //         );
                    //         if (pinController.text.isEmpty) {
                    //           THelperFunctions.showErrorToast(
                    //             'Please enter OTP',
                    //           );
                    //           return;
                    //         }
                    //         final completed = widget.user.copyWith(
                    //           otpCode: int.parse(pinController.text),
                    //           otpId: loginOtpId,
                    //         );
                    //         final verifyOtpResponse = await networkService.getData(
                    //           '${config.verifyMailUrl}?userId=${widget.user.userId}&otp=${completed.otpCode}',
                    //         );
                    //         await Future.delayed(const Duration(seconds: 2));
                    //         //
                    //         if (verifyOtpResponse!.statusCode >= 200 &&
                    //             verifyOtpResponse.statusCode < 300) {
                    //           Navigator.of(context, rootNavigator: true).pop();
                    //           Navigator.pushReplacement(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) =>
                    //                   OtpPage(user: completed, isEmail: false),
                    //             ),
                    //           );
                    //         } else {
                    //           Navigator.of(context, rootNavigator: true).pop();

                    //           THelperFunctions.showErrorToast(
                    //             verifyOtpResponse.body,
                    //           );
                    //         }
                    //       }
                    //     : () async {
                    //         showDialog(
                    //           context: context,
                    //           builder: (context) => const ProgressDialog(
                    //             displayMessage:
                    //                 'Verifying Phone Number...\nPlease wait!',
                    //           ),
                    //         );
                    //         final config = await ApiConfigs.forEnvironment(
                    //           envVar,
                    //         );
                    //         if (pinController.text.isEmpty) {
                    //           THelperFunctions.showErrorToast(
                    //             'Please enter OTP',
                    //           );
                    //           return;
                    //         }

                    //         final completed = widget.user.copyWith(
                    //           otpCode: int.parse(pinController.text),
                    //           otpId: loginOtpId,
                    //         );

                    //         Response?
                    //         verifyOtpResponse = await networkService.getData(
                    //           '${config.verifyOtpUrl}?userId=${completed.userId}&otp=${completed.otpCode}&otpType=EMAIL&activateAccount=true',
                    //         );
                    //         await Future.delayed(const Duration(seconds: 2));
                    //         if (verifyOtpResponse!.statusCode == 200) {
                    //           //

                    //           THelperFunctions.showSuccessToast(
                    //             "You have been successfully registered!",
                    //           );

                    //           Navigator.of(context, rootNavigator: true).pop();
                    //           Navigator.pushReplacementNamed(
                    //             context,
                    //             Routes.index,
                    //           );
                    //         } else {
                    //           TLoggerHelper.info(
                    //             'Verify OTP Response: ${verifyOtpResponse.statusCode}',
                    //           );
                    //           THelperFunctions.showErrorToast(
                    //             verifyOtpResponse.body,
                    //           );

                    //           Navigator.of(context, rootNavigator: true).pop();
                    //         }
                    //       },
                    child: Text(
                      'verify otp'.toUpperCase(),
                      style: textTheme.titleLarge!.copyWith(
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Verify Your Identity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  // widget.isEmail == true &&
                  //         widget.user.email != "user@gmail.com"
                  //     ? 'We sent an OTP to ${widget.user.email.replaceRange(3, widget.user.email.indexOf('@'), "********")}. Please check and enter the code to verify your identity.'
                  //     : 'We sent an OTP to ${widget.user.phoneNumber}. Please check and enter the code to verify your identity',
                  "",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!.copyWith(letterSpacing: 1.5),
                ),
                SizedBox(height: size.height * 0.005),
                SizedBox(
                  height: size.height * 0.375,
                  child: LottieBuilder.network(TImages.lottieImage),
                ),
                SizedBox(height: size.height * 0.025),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  controller: pinController,
                  validator: (s) {
                    return s!.isNotEmpty ? null : 'Please enter OTP';
                  },
                  onSubmitted: (s) {
                    setState(() => pinController.text = s);
                  },
                ),
                SizedBox(height: size.height * 0.025),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: remValue, end: 0),
                    duration: const Duration(seconds: 300),
                    builder: (context, value, child) {
                      final remainingSeconds = double.parse(
                        value.toString(),
                      ).toInt();
                      final seconds = remainingSeconds % 60;
                      final minutes = remainingSeconds ~/ 60;

                      return ValueListenableBuilder(
                        valueListenable: resendingToken,
                        builder: (context, lastValue, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't get the code?",
                                style: textTheme.bodyMedium,
                              ),
                              // TextButton(
                              //   onPressed: (minutes == 0 && seconds == 0)
                              //       ? () async {
                              //           if (value == 0) {
                              //             /// Call resend OTP endpoint
                              //             final config =
                              //                 await ApiConfigs.forEnvironment(
                              //                   envVar,
                              //                 );

                              //             final otpResponse =
                              //                 await networkService.getData(
                              //                   widget.isEmail == true
                              //                       ? '${config.loginUrl}/${widget.user.email}?userId=${widget.user.userId}'
                              //                       : '${config.sendOtpUrl}?userId=${widget.user.userId}&phoneNumber=${widget.user.phoneNumber}',
                              //                 );
                              //             // check if the response is successful
                              //             TLoggerHelper.trace(
                              //               '${config.loginUrl}/${widget.user.email}?userId=${widget.user.userId}',
                              //             );
                              //             TLoggerHelper.trace(
                              //               '${config.sendOtpUrl}?userId=${widget.user.userId}&phoneNumber=${widget.user.phoneNumber}',
                              //             );
                              //             if (otpResponse!.statusCode == 200) {
                              //               var decodedResponse = jsonDecode(
                              //                 otpResponse.body,
                              //               );
                              //               setState(() {
                              //                 loginOtpId =
                              //                     decodedResponse['otpId'];
                              //                 TLoggerHelper.info(
                              //                   'login OTP ID: $loginOtpId',
                              //                 );
                              //               });

                              //               THelperFunctions.showSuccessToast(
                              //                 'OTP Sent',
                              //               );
                              //               setState(() => remValue = 300);
                              //             } else {
                              //               TLoggerHelper.error(
                              //                 otpResponse.body,
                              //               );
                              //               THelperFunctions.showErrorToast(
                              //                 otpResponse.body,
                              //               );
                              //               Navigator.pop(context);
                              //             }
                              //           }
                              //         }
                              //       : null,
                              //   child: Text(
                              //     "Resend",
                              //     style: textTheme.bodyMedium!.copyWith(
                              //       decoration: TextDecoration.underline,
                              //       color: (minutes == 0 && seconds == 0)
                              //           ? Colors.blue
                              //           : Colors.black,
                              //     ),
                              //   ),
                              // ),
                              Text(
                                "in ${minutes.toString().padLeft(2, '0')}"
                                ":${seconds.toString().padLeft(2, '0')}",
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
