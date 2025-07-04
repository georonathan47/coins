import 'widgets.dart';

class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({super.key});

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  final textTheme = Get.textTheme;
  final instance = KycController.instance;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: instance.personalDetailsFormKey.value,
        child: ScrollableWidget(
          padding: 8,
          physics: const BouncingScrollPhysics(),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: instance.fnameController.value,
              decoration: InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Iconsax.user),
                hintText: 'Enter your first name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TextFormField(
              controller: instance.lnameController.value,
              decoration: InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Iconsax.user),
                hintText: 'Enter your last name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TextFormField(
              controller: instance.emailController.value,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                hintText: 'Enter your email address',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                return null;
              },
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            // TextFormField(
            //   controller: instance.phoneController.value,
            //   decoration: InputDecoration(
            //     labelText: 'Phone Number',
            //     hintText: 'Enter your phone number',
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter your phone number';
            //     }
            //     return null;
            //   },
            // ),
            IntlPhoneField(
              showCursor: true,
              showCountryFlag: true,
              initialCountryCode: 'GH',
              disableLengthCheck: true,
              controller: instance.phoneController.value,
              dropdownIconPosition: IconPosition.trailing,
              flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Phone number',
                iconColor: TColors.primary,
                hintStyle: textTheme.bodyLarge,
                labelStyle: textTheme.titleMedium,
                hintText: 'Enter your phone number',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: TColors.light,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: TColors.light, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TextFormField(
              controller: instance.dobController.value,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'Select your date of birth',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  lastDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  initialDate: DateTime.now(),
                  builder: (context, child) => Theme(
                    data: Get.isDarkMode
                        ? ThemeData.dark().copyWith(
                            primaryColor: TColors.secondary,
                            cardColor: TColors.drawerBackgroundDark,
                            scaffoldBackgroundColor:
                                TColors.drawerBackgroundDark,
                            canvasColor: TColors.drawerBackgroundDark,
                            textTheme: TextTheme(
                              bodyMedium: textTheme.bodyMedium?.copyWith(
                                color: TColors.light,
                              ),
                              titleMedium: textTheme.titleMedium?.copyWith(
                                color: TColors.light,
                              ),
                            ),
                            colorScheme: ColorScheme.dark(
                              primary: TColors.secondary,
                            ),
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
                            colorScheme: ColorScheme.light(
                              primary: TColors.primary,
                            ),
                          ),
                    child: child!,
                  ),
                );
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
            SizedBox(height: TSizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text('Gender', style: textTheme.bodySmall),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<Gender>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Male'),
                        value: Gender.male,
                        groupValue: instance.selectedGender.value,
                        onChanged: (Gender? value) {
                          if (value != null) {
                            instance.selectedGender.value = value;
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<Gender>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Female'),
                        value: Gender.female,
                        groupValue: instance.selectedGender.value,
                        onChanged: (Gender? value) {
                          if (value != null) {
                            instance.selectedGender.value = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwSections * 5),
            // const Spacer(),
            ElevatedButton(
              onPressed: () => instance.validateUserDetails(),
              child: Text(
                'Accepted, Next',
                style: textTheme.titleMedium?.copyWith(
                  color: TColors.light,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () => Get.offAllNamed(Routers.index),
              child: Text(
                'Continue Later',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
