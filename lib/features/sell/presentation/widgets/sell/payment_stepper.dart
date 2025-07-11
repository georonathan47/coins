import '../widgets.dart';

class PaymentStepper extends StatelessWidget {
  const PaymentStepper({super.key, required this.currency});
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    return SizedBox(
      height: Get.height,
      child: GetBuilder<SellController>(
        builder: (controller) => Stepper(
          elevation: 4,
          connectorThickness: .75,
          currentStep: controller.currentStep,
          onStepCancel: controller.onStepCancel,
          onStepTapped: controller.onStepTapped,
          physics: const ClampingScrollPhysics(),
          onStepContinue: controller.onStepContinue,
          connectorColor: MaterialStateProperty.all(TColors.secondary),
          controlsBuilder: (context, details) {
            final isLastStep = controller.currentStep == 3;
            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: Row(
                children: [
                  if (controller.currentStep != 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('BACK'),
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                    ),
                  ),
                ],
              ),
            );
          },
          steps: [
            Step(
              isActive: controller.currentStep >= 0,
              state: controller.currentStep > 0
                  ? StepState.complete
                  : StepState.indexed,
              title: Text(
                'Choose Recipient Account',
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Form(key: controller.formKeys[0], child: Recipient()),
            ),
            Step(
              isActive: controller.currentStep >= 1,
              state: controller.currentStep > 1
                  ? StepState.complete
                  : StepState.indexed,
              title: Text(
                'Review sell order summary'.capitalize!,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Form(key: controller.formKeys[1], child: SellSummary()),
            ),
            Step(
              isActive: controller.currentStep >= 2,
              state: controller.currentStep > 2
                  ? StepState.complete
                  : StepState.indexed,
              title: Text(
                'Instructions for sending funds:'.capitalize!,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Instructions(currency: currency),
            ),
            Step(
              isActive: controller.currentStep >= 3,
              state: controller.currentStep > 3
                  ? StepState.complete
                  : StepState.indexed,
              title: Text(
                'Transaction Confirmation'.capitalize!,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Card(
                child: Form(
                  key: controller.formKeys[3],
                  child: TransactionConfirmation(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
