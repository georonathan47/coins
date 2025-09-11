import 'bank/bank_form.dart';
import 'widgets.dart';

class PayAccountsModalSheet extends StatelessWidget {
  const PayAccountsModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return AnimatedGradientColoring(
      padding: 8,
      endColor: TColors.primary,
      startColor: TColors.secondary,
      child: SizedBox(
        width: double.infinity,
        height: Get.height / 1.25,
        child: ScrollableWidget(
          padding: 8,
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              'Add New PayAccount',
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(color: TColors.light),
            ),
            Form(child: AddAccountForm()),
          ],
        ),
      ),
    );
  }
}
