import '../../data/models/sell_history_model.dart';
import 'widgets.dart';

class SellHistoryCard extends StatelessWidget {
  const SellHistoryCard({super.key, required this.order});
  final SellHistoryModel order;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // spacing: TSizes.spaceBtwItems,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.ecurrency.capitalize!, style: textTheme.titleMedium),
              Text(
                TFormatter.formatDate(order.timeCreated),
                style: textTheme.bodyLarge,
              ),
            ],
          ),
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
              Text(order.orderId.toUpperCase(), style: textTheme.bodyLarge),
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
                TFormatter.formatCurrency(order.amountReceived),
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
