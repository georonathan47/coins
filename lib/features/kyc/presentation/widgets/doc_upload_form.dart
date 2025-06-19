import 'dart:io';

import 'widgets.dart';

class DocUploadForm extends StatefulWidget {
  const DocUploadForm({super.key});

  @override
  State<DocUploadForm> createState() => DocUploadFormState();
}

class DocUploadFormState extends State<DocUploadForm> {
  final textTheme = Get.textTheme;
  final instance = KycController.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: instance.docsFormKey.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField(
            isDense: true,
            items: instance.currentUser.value.country == 'Ghana'
                ? [
                    DropdownMenuItem(
                      value: 'NATIONAL_ID',
                      child: Text('National ID'),
                    ),
                    DropdownMenuItem(
                      value: 'PASSPORT',
                      child: Text('Passport'),
                    ),
                  ]
                : [
                    DropdownMenuItem(
                      value: 'PASSPORT',
                      child: Text('Passport'),
                    ),
                  ],
            onChanged: (value) {},
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              labelText: 'Network Fee Type',
              hintText: 'Select Document Type',
              prefixIcon: const Icon(Iconsax.money),
              contentPadding: const EdgeInsets.all(16),
              hintStyle: textTheme.bodyLarge?.copyWith(fontSize: 16),
              labelStyle: textTheme.bodyLarge?.copyWith(fontSize: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: instance.dobController.value,
            decoration: InputDecoration(
              labelText: 'Issued Date',
              hintText: 'Select issued date',
            ),
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                lastDate: DateTime.now(),
                firstDate: DateTime(1900),
                initialDate: DateTime.now(),
              );
              if (selectedDate != null) {
                instance.dobController.value.text = '${selectedDate.toLocal()}'
                    .split(' ')[0];
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select issued date on ID';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: instance.dobController.value,
            decoration: InputDecoration(
              labelText: 'Expiry Date',
              hintText: 'Select expiry date',
            ),
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                lastDate: DateTime.now(),
                firstDate: DateTime(1900),
                initialDate: DateTime.now(),
              );
              if (selectedDate != null) {
                instance.dobController.value.text = '${selectedDate.toLocal()}'
                    .split(' ')[0];
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select expiry date of ID';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            height: instance.frontImg.value.value.isEmpty
                ? Get.height * 0.2
                : Get.height * 0.25,
            child: GFBorder(
              strokeWidth: 2,
              type: GFBorderType.rRect,
              dashedLine: const [15, 10],
              radius: const Radius.circular(10),
              color: Get.isDarkMode
                  ? Colors.white54
                  : TColors.primary.withOpacity(0.65),
              child: Column(
                children: [
                  instance.frontImg.value.value.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Upload a front image',
                            style: textTheme.titleMedium,
                          ),
                        )
                      : const SizedBox.shrink(),
                  instance.frontImg.value.value.isEmpty
                      ? Text('JPG, PNG, GIF', style: textTheme.titleSmall)
                      : const SizedBox.shrink(),
                  instance.frontImg.value.value.isEmpty
                      ? const SizedBox(height: 20)
                      : const SizedBox.shrink(),
                  instance.frontImg.value.value.isEmpty
                      ? SizedBox(
                          width: Get.width / 4,
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await instance.openGallery();
                              if (result.isNotEmpty) {
                                setState(
                                  () => instance.frontImg.value.value = result,
                                );
                              }
                            },
                            child: Text(
                              'Choose File',
                              style: textTheme.labelLarge,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  ValueListenableBuilder(
                    valueListenable: instance.frontImg.value,
                    builder: (context, value, child) {
                      if (value.isNotEmpty) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(value),
                                fit: BoxFit.contain,
                                height: Get.height * 0.225,
                              ),
                            ),
                            Positioned(
                              left: Get.width * 0.55,
                              child: Card(
                                child: IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(
                                      () => instance.frontImg.value.value = '',
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: TSizes.spaceBtwInputFields),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            height: instance.backImg.value.value.isEmpty
                ? Get.height * 0.2
                : Get.height * 0.25,
            child: GFBorder(
              strokeWidth: 2,
              type: GFBorderType.rRect,
              dashedLine: const [15, 10],
              radius: const Radius.circular(10),
              color: Get.isDarkMode
                  ? Colors.white54
                  : TColors.primary.withOpacity(0.65),
              child: Column(
                children: [
                  instance.backImg.value.value.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Upload a back image',
                            style: textTheme.titleMedium,
                          ),
                        )
                      : const SizedBox.shrink(),
                  instance.backImg.value.value.isEmpty
                      ? Text('JPG, PNG, GIF', style: textTheme.titleSmall)
                      : const SizedBox.shrink(),
                  instance.backImg.value.value.isEmpty
                      ? const SizedBox(height: 20)
                      : const SizedBox.shrink(),
                  instance.backImg.value.value.isEmpty
                      ? SizedBox(
                          width: Get.width / 4,
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await instance.openGallery();
                              if (result.isNotEmpty) {
                                setState(
                                  () => instance.backImg.value.value = result,
                                );
                              }
                            },
                            child: Text(
                              'Choose File',
                              style: textTheme.labelLarge,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  ValueListenableBuilder(
                    valueListenable: instance.backImg.value,
                    builder: (context, value, child) {
                      if (value.isNotEmpty) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(value),
                                fit: BoxFit.contain,
                                height: Get.height * 0.225,
                              ),
                            ),
                            Positioned(
                              left: Get.width * 0.55,
                              child: Card(
                                child: IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(
                                      () => instance.backImg.value.value = '',
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: TSizes.spaceBtwSections),
          Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: TColors.accent.withOpacity(.1),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              height: Get.height / 2.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions to follow:',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  InstructionsWidget(
                    instruction:
                        'Ensure the document is clear and readable, with no blurriness or distortion.',
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  InstructionsWidget(
                    instruction:
                        'Submit the entire ID, capturing all corners and relevant information.',
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  InstructionsWidget(
                    instruction:
                        'Confirm that the ID is current, not expired, and within the accepted date range.',
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  InstructionsWidget(
                    instruction:
                        'The document should be in its original, unaltered state without any edits or modifications.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
