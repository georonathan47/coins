import '../../../domain/entities/pay_account.dart';
import '../widgets.dart';

class AddAccountForm extends StatelessWidget {
  const AddAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return GetBuilder<PayAccountsController>(
      builder: (instance) {
        String? selectedType;
        String? selectedCountry;
        return Form(
          key: instance.addAccountFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ScrollableWidget(
            padding: 4,
            physics: const BouncingScrollPhysics(),
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Country',
                  border: OutlineInputBorder(),
                  labelStyle: textTheme.bodyLarge?.copyWith(
                    color: TColors.light,
                  ),
                ),
                items: instance.countryList.map((country) {
                  return DropdownMenuItem<String>(
                    value: country.countryName,
                    child: Text(
                      '${country.countryCurrency} ${country.countryName}',
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCountry = value;
                },
                // value: instance.selectedAccountType,
              ),
              SizedBox(
                height: Get.height / 10.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...instance.types.map(
                      (type) => Obx(
                        () => Card(
                          surfaceTintColor: Colors.white54,
                          child: Row(
                            children: [
                              Radio<bool>(
                                activeColor: TColors.secondary,
                                value: type == instance.types.first,
                                groupValue: instance.isBankAccount.value,
                                onChanged: (value) =>
                                    instance.setAccountType(value!),
                              ),
                              IntrinsicWidth(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    type,
                                    style: textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => instance.isBankAccount.value
                    ? TextFormField(
                        controller: instance.accountNumberController,
                        decoration: InputDecoration(
                          labelText: instance.isBankAccount.value
                              ? 'Account Number'
                              : 'Mobile Number',
                          border: OutlineInputBorder(),
                          labelStyle: textTheme.bodyLarge?.copyWith(
                            color: TColors.light,
                          ),
                        ),
                      )
                    : IntlPhoneField(
                        initialCountryCode: 'GH',
                        controller: instance.momoController,
                        textInputAction: TextInputAction.done,
                        validator: TValidator.validatePhoneNumber,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: '024 *** ****',
                          labelText: 'Phone Number',
                        ),
                        style: TextStyle(fontSize: 16),
                        onChanged: (phone) {
                          // Store phone number if needed
                        },
                      ),
              ),
              TextFormField(
                controller: instance.accountNameController,
                decoration: InputDecoration(
                  labelText: 'Name On Account',
                  border: OutlineInputBorder(),
                  labelStyle: textTheme.bodyLarge?.copyWith(
                    color: TColors.light,
                  ),
                ),
              ),
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Account Type',
                    border: OutlineInputBorder(),
                    labelStyle: textTheme.bodyLarge?.copyWith(
                      color: TColors.light,
                    ),
                  ),
                  items: instance.isBankAccount.value
                      ? instance.bankAccountTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type.toUpperCase(),
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: 16,
                                letterSpacing: 1.2,
                              ),
                            ),
                          );
                        }).toList()
                      : instance.momoAccountTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type.toUpperCase(),
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: 16,
                                letterSpacing: 1.2,
                              ),
                            ),
                          );
                        }).toList(),
                  onChanged: (value) {
                    selectedType = value;
                  },
                  // value: instance.selectedAccountType,
                ),
              ),
              Obx(
                () => TextFormField(
                  controller: instance.bankNameController,
                  decoration: InputDecoration(
                    labelText: instance.isBankAccount.value
                        ? 'Bank Name'
                        : 'Mobile Network',
                    border: OutlineInputBorder(),
                    labelStyle: textTheme.bodyLarge?.copyWith(
                      color: TColors.light,
                    ),
                  ),
                ),
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  labelStyle: textTheme.bodyLarge?.copyWith(
                    color: TColors.light,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ElevatedButton(
                onPressed: () async {
                  if (instance.addAccountFormKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (_) => Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                    final request = PayAccount.empty().copyWith(
                      activated: true,
                      country: selectedCountry,
                      paymentType: selectedType,
                      bankName: instance.bankNameController.text,
                      nameOnAccount: instance.accountNameController.text,
                      accountNumber: instance.accountNumberController.text,
                    );
                    await instance.addAccount(request);
                  }
                },
                child: const Text('Add PayAccount'),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        );
      },
    );
  }
}
