import '../../../../../core/utils/get_image_widget.dart';
import '../../../data/models/currency.dart';
import '../widgets.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({super.key, required this.currency});
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipOval(
              child: FutureBuilder(
                future: getImageWidget(currency.imageFile, context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CircleAvatar(
                      maxRadius: 40,
                      child: snapshot.requireData,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currency.currencyName, style: textTheme.titleLarge),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text(
                        currency.buyStatus ? 'Active Buy' : '',
                        style: textTheme.titleSmall,
                      ),
                      Text('', style: textTheme.titleMedium),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text('', style: textTheme.titleMedium),
                      Text('', style: textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
