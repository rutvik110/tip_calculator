import 'package:flutter/material.dart';

import '../helpers/format_amount.dart';

class TotalRow extends StatelessWidget {
  const TotalRow({
    Key? key,
    this.billAmountErrorText,
    this.tipPercentageErrorText,
    required this.amount,
    required this.title,
  }) : super(key: key);
  final String? tipPercentageErrorText;
  final String? billAmountErrorText;
  final double amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    final moneyTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
    );
    final titleTextStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
    );
    return Row(
      children: [
        Text(
          '$title : ',
          style: titleTextStyle,
        ),
        Text(
          tipPercentageErrorText != null || billAmountErrorText != null
              ? 'N/A'
              : formatAmount(amount),
          style: moneyTextStyle,
        ),
      ],
    );
  }
}
