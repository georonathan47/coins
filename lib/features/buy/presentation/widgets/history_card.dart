import '../../data/models/buy_history_model.dart';
import 'widgets.dart';

class BuyHistoryCard extends StatelessWidget {
  const BuyHistoryCard({super.key, required this.order});
  final BuyHistoryModel order;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.ecurrency.capitalize!, style: textTheme.titleMedium),
            const SizedBox(height: TSizes.spaceBtwItems / 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ',
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(order.orderId.capitalize!, style: textTheme.bodyLarge),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: ',
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  order.status.replaceAll('_', ' '),
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount: ',
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  TFormatter.formatCurrency(order.localCurrencyTotal),
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    order.timeCreated,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    order.paymentMode.replaceAll('_', ' ').capitalize!,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    order.localCurrency,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
