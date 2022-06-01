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
    const titleTextStyle = TextStyle(
      fontSize: 16,
    );

    const amountTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );

    return Row(
      children: [
        Text(
          '$title : ',
          style: titleTextStyle,
        ),
        Text(
          formatAmount(amount),
          style: amountTextStyle,
        ),
      ],
    );
  }
}
