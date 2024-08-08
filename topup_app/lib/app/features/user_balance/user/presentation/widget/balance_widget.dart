import 'package:flutter/material.dart';
import 'package:topup_app/core/app_colors.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
    required this.balance,
    required this.name,
    required this.currency,
    required this.isVerified,
  });

  final double balance;
  final String name;
  final String currency;
  final String isVerified;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Text(
          'Welcome $name',
          style: const TextStyle(
            color: AppColors.color30447D,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                'Verified: $isVerified',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Your Balance:',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          '$balance $currency',
          style: const TextStyle(
            color: AppColors.color30447D,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
