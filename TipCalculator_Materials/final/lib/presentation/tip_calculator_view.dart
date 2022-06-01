import 'package:flutter/material.dart';

import 'input_textfield.dart';
import 'total_row.dart';

class TipCalculatorView extends StatefulWidget {
  const TipCalculatorView({Key? key}) : super(key: key);

  @override
  State<TipCalculatorView> createState() => _TipCalculatorViewState();
}

class _TipCalculatorViewState extends State<TipCalculatorView> {
  late TextEditingController tipPercentageController;
  late double billAmount;
  late double tipPercentage;
  late double tip;
  late double totalBill;
  late TextEditingController billAmountController;

  late String? billAmountErrorText;
  late String? tipPercentageErrorText;

  void onBillAmountChanged(String value) {
    if (value.isNotEmpty) {
      final amount = double.tryParse(value);

      if (amount != null) {
        billAmountErrorText = null;
        billAmount = amount;
      } else {
        billAmountErrorText = 'Invalid bill amount';
        billAmount = 0;
      }
    } else {
      billAmountErrorText = 'Requires bill amount';
      billAmount = 0;
    }

    setState(() {
      calculateTipAndTotalBill();
    });
  }

  void onTipPercentageChanged(String value) {
    if (value.isNotEmpty) {
      final percentage = double.tryParse(value);
      if (percentage != null) {
        if (percentage <= 100) {
          tipPercentageErrorText = null;
          tipPercentage = percentage;
        } else {
          tipPercentageErrorText = 'Can not be greater than 100%';
          tipPercentage = 0;
        }
      } else {
        tipPercentageErrorText = 'Invalid tip percentage';
        tipPercentage = 0;
      }
    } else {
      tipPercentageErrorText = 'Requires tip percentage';
      tipPercentage = 0;
    }
    setState(() {
      calculateTipAndTotalBill();
    });
  }

  void calculateTip() {
    tip = billAmount * (tipPercentage / 100);
    final roundedTip = tip.toStringAsFixed(2);
    tip = double.parse(roundedTip);
  }

  void calculateTotalBill() {
    totalBill = billAmount + tip;
    totalBill = double.parse(totalBill.toStringAsFixed(2));
  }

  void calculateTipAndTotalBill() {
    calculateTip();
    calculateTotalBill();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billAmount = 0;
    tipPercentage = 15;
    tip = 0;
    totalBill = 0;
    billAmountErrorText = null;
    tipPercentageErrorText = null;
    tipPercentageController = TextEditingController(text: '$tipPercentage');
    billAmountController = TextEditingController(text: '$billAmount');
  }

  @override
  Widget build(BuildContext context) {
    final billAmountTextFieldDecoration = InputDecoration(
      label: const Text('Bill Amount'),
      suffixIcon: const Icon(
        Icons.attach_money,
      ),
      border: const OutlineInputBorder(),
      errorText: billAmountErrorText,
    );

    final tipPercentageTextFieldDecoration = InputDecoration(
      label: const Text('Tip Percentage'),
      suffixIcon: const Icon(
        Icons.percent,
      ),
      border: const OutlineInputBorder(),
      errorText: tipPercentageErrorText,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextField(
              controller: billAmountController,
              decoration: billAmountTextFieldDecoration,
              label: 'Bill Amount',
              errorText: billAmountErrorText,
              iconData: Icons.attach_money,
              onChanged: onBillAmountChanged,
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextField(
              controller: tipPercentageController,
              decoration: tipPercentageTextFieldDecoration,
              label: 'Tip Percentage',
              errorText: tipPercentageErrorText,
              iconData: Icons.percent,
              onChanged: onTipPercentageChanged,
            ),
            const Divider(
              height: 30,
            ),
            TotalRow(
              title: 'Tip',
              amount: tip,
              tipPercentageErrorText: tipPercentageErrorText,
              billAmountErrorText: billAmountErrorText,
            ),
            const SizedBox(
              height: 20,
            ),
            TotalRow(
              title: 'Total Bill',
              amount: totalBill,
              tipPercentageErrorText: tipPercentageErrorText,
              billAmountErrorText: billAmountErrorText,
            ),
          ],
        ),
      ),
    );
  }
}
