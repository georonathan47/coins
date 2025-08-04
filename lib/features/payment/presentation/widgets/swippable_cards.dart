import 'package:flutter/cupertino.dart';

import '../../../homepage/presentation/widgets/widgets.dart';
import '../../data/models/user_payment_details.dart';
import 'widgets.dart';

class SwippablePayAccountCard extends StatefulWidget {
  final List<UserPaymentDetail> payAccounts;

  const SwippablePayAccountCard({super.key, required this.payAccounts});

  @override
  State<SwippablePayAccountCard> createState() =>
      _SwippablePayAccountCardState();
}

class _SwippablePayAccountCardState extends State<SwippablePayAccountCard> {
  int currentIndex = 0;
  double _lastPanY = 0;

  void _cycleToNext() {
    if (widget.payAccounts.isNotEmpty) {
      setState(() {
        currentIndex = (currentIndex + 1) % widget.payAccounts.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.payAccounts.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentAccount = widget.payAccounts[currentIndex];

    return Column(
      children: [
        GestureDetector(
          onPanStart: (details) {
            _lastPanY = details.localPosition.dy;
          },
          onPanUpdate: (details) {
            final deltaY = details.localPosition.dy - _lastPanY;
            // Detect downward swipe with minimum threshold
            if (deltaY > 75) {
              _cycleToNext();
              _lastPanY = details
                  .localPosition
                  .dy; // Reset to prevent multiple triggers
            }
          },
          onTap: () => _cycleToNext(),
          child: Container(
            height: 220,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            child: AnimatedGradientColoring(
              endColor: TColors.accent,
              startColor: TColors.primary,
              child: Stack(
                children: [
                  // Background pattern - curved lines
                  Positioned.fill(
                    child: CustomPaint(painter: CardPatternPainter()),
                  ),

                  // Card content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with bank name and status indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '≡≡≡',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  currentAccount.bankName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentAccount.isActivated
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Card number
                        Text(
                          _formatCardNumber(currentAccount.accountNumber),
                          style: const TextStyle(
                            fontSize: 30,
                            letterSpacing: 2,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Cardholder name and logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentAccount.nameOnAccount,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  TImages.logoWhite,
                                  height: Get.height * 0.025,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'eBitcoinics',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Instruction text
        const Text(
          'Swipe down or tap on cards to cycle through your available PayAccounts',
          style: TextStyle(fontSize: 16),
        ),

        // Card indicators
        if (widget.payAccounts.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.payAccounts.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index == currentIndex
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 16),
        Container(
          height: 50,
          padding: EdgeInsets.all(TSizes.xs),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(TSizes.sm),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GetBuilder<PayAccountsController>(
              builder: (instance) {
                return Row(
                  spacing: 10,
                  children: [
                    ActionChip(
                      label: const Text('Add'),
                      avatar: Icon(Iconsax.add),
                      onPressed: () => instance.openAccount(),
                    ),
                    ActionChip(
                      label: const Text('Edit'),
                      avatar: Icon(Iconsax.edit),
                      onPressed: () {},
                    ),
                    ActionChip(
                      label: const Text('Remove'),
                      avatar: Icon(CupertinoIcons.trash),
                      onPressed: () {},
                    ),
                    ActionChip(
                      avatar: Icon(Icons.check),
                      label: const Text('Activate'),
                      onPressed: () {},
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String _formatCardNumber(String number) {
    // Format as •••• •••• •••• XXXX showing only last 4 digits
    if (number.length >= 10) {
      final lastFour = number.substring(number.length - 4);
      return '•••• •••• •••• $lastFour';
    }
    return '•••• •••• •••• ••••';
  }
}

class CardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path1 = Path();
    path1.moveTo(size.width * 0.7, 0);
    path1.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.3,
      size.width * 0.8,
      size.height * 0.6,
    );
    path1.quadraticBezierTo(
      size.width * 1.2,
      size.height * 0.9,
      size.width * 0.9,
      size.height,
    );

    final path2 = Path();
    path2.moveTo(size.width * 0.9, 0);
    path2.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.4,
      size.width,
      size.height * 0.7,
    );

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
