import '../widgets.dart';

class TransactionConfirmation extends StatefulWidget {
  const TransactionConfirmation({super.key});

  @override
  State<TransactionConfirmation> createState() =>
      TransactionConfirmationState();
}

class TransactionConfirmationState extends State<TransactionConfirmation> {
  final textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellController>(
      builder: (controller) {
        return ScrollableWidget(
          padding: 16,
          children: [
            Text(
              'Add transaction hash to complete this order!',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Name on Account', style: textTheme.titleSmall),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 4,
                  child: Text(
                    controller.currentUser.value.fullName.capitalize!,
                    style: textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Account Number', style: textTheme.titleSmall),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 4,
                  child: Text(
                    controller.currentUser.value.phoneNumber!.capitalize!,
                    style: textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Bank/Network Name', style: textTheme.titleSmall),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 4,
                  child: Text(
                    'ECO Bank',
                    style: textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Account Type', style: textTheme.titleSmall),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Business Account',
                    style: textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'After transferring the funds, copy the transaction hash from the external platform and paste it in the field below. Ensure that you paste the correct hash.',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            TextFormField(
              maxLength: 64,
              controller: controller.hash.value,
              validator: TValidator.validateTransactionHash,
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
              decoration: InputDecoration(
                labelText: 'Transaction Hash',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        );
      },
    );
  }
}
