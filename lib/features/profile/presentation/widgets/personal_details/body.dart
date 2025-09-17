import 'dart:io';

import '../widgets.dart';

class PersonalDetailsBody extends StatefulWidget {
  const PersonalDetailsBody({super.key});

  @override
  State<PersonalDetailsBody> createState() => _ProfileDetailsBodyState();
}

class _ProfileDetailsBodyState extends State<PersonalDetailsBody> {
  File? userPicture;
  late DateTime date;
  late String phoneNumber;
  late DateTime selectedDateTime;
  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return GetBuilder<ProfileController>(
      init: ProfileController.instance,
      builder: (instance) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: instance.editKey.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  autofillHints: const [AutofillHints.birthday],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    hintText: 'Enter your date of birth',
                    prefixIcon: const Icon(Icons.calendar_today),
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
                  onTap: () async {
                    DateTime? selectedDate = Platform.isIOS
                        ? await iosDatePicker(Get.context!)
                        : await materialDatePicker(Get.context!, textTheme);
                    if (selectedDate != null) {
                      instance.dobController.value.text =
                          '${selectedDate.toLocal()}'.split(' ')[0];
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (instance.editKey.value.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        final user = instance.currentUser.value.copyWith(
                          phoneNumber: phoneNumber,
                          // country: selectedCountry.value,
                          email: instance.emailController.value.text,
                          password: instance.passwordController.value.text,
                          lastname: instance.lastnameController.value.text,
                          firstname: instance.firstnameController.value.text,
                        );
                        // await instance.trySignup(user);
                        // Get.toNamed(Routers.regCaptcha, arguments: user);
                      } else {
                        THelperFunctions.showSnackBar(
                          title: 'Error',
                          bgColor: TColors.error,
                          message: 'Please fill in all required fields.',
                        );
                      }
                    },
                    child: Text(
                      'update'.capitalizeFirst!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<DateTime?> materialDatePicker(
    BuildContext context,
    TextTheme textTheme,
  ) async {
    return await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Get.isDarkMode
            ? ThemeData.dark().copyWith(
                primaryColor: TColors.secondary,
                cardColor: TColors.drawerBackgroundDark,
                scaffoldBackgroundColor: TColors.drawerBackgroundDark,
                canvasColor: TColors.drawerBackgroundDark,
                textTheme: TextTheme(
                  bodyMedium: textTheme.bodyMedium?.copyWith(
                    color: TColors.light,
                  ),
                  titleMedium: textTheme.titleMedium?.copyWith(
                    color: TColors.light,
                  ),
                ),
                colorScheme: ColorScheme.dark(primary: TColors.secondary),
              )
            : ThemeData.light().copyWith(
                primaryColor: TColors.primary,
                textTheme: TextTheme(
                  bodyMedium: textTheme.bodyMedium?.copyWith(
                    color: TColors.light,
                  ),
                  titleMedium: textTheme.titleMedium?.copyWith(
                    color: TColors.light,
                  ),
                ),
                colorScheme: ColorScheme.light(primary: TColors.primary),
              ),
        child: child!,
      ),
    );
  }

  Future<DateTime?> iosDatePicker(BuildContext context) async {
    DateTime? selectedDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              // Optional: Add a done button
              SizedBox(
                width: double.infinity,
                child: CupertinoNavigationBar(
                  backgroundColor: CupertinoColors.systemBackground.resolveFrom(
                    context,
                  ),
                  border: null,
                  middle: Text('Select Date of Birth'),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text('Done'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now().subtract(
                    const Duration(days: 5),
                  ),
                  minimumDate: DateTime(1960),
                  maximumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (newDateTime) {
                    selectedDate = newDateTime;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    return selectedDate;
  }
}
