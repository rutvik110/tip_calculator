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
  late double totalTip;
  late double totalBill;
  late TextEditingController billAmountController;

  late String? billAmountErrorText;
  late String? tipPercentageErrorText;

  void onBillAmountChanged(String value) {
    if (value.isNotEmpty) {
      final amount = double.tryParse(value);

      if (amount != null) {
        billAmount = amount;
        billAmountErrorText = null;
      } else {
        billAmount = 0;
        billAmountErrorText = 'Invalid bill amount';
      }
    } else {
      billAmount = 0;
      billAmountErrorText = 'Requires bill amount';
    }

    setState(() {
      calculateTotalTipAndBill();
    });
  }

  void onTipPercentageChanged(String value) {
    if (value.isNotEmpty) {
      final percentage = double.tryParse(value);
      if (percentage != null) {
        if (percentage > 100) {
          tipPercentageErrorText = 'Can not be greater than 100%';
          tipPercentage = 0;
        } else {
          tipPercentageErrorText = null;
          tipPercentage = percentage;
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
      calculateTotalTipAndBill();
    });
  }

  void calculateTotalTip() {
    totalTip = billAmount * (tipPercentage / 100);
    totalTip = double.parse(totalTip.toStringAsFixed(2));
  }

  void calculateTotalBill() {
    totalBill = billAmount + totalTip;
    totalBill = double.parse(totalBill.toStringAsFixed(2));
  }

  void calculateTotalTipAndBill() {
    calculateTotalTip();
    calculateTotalBill();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billAmount = 0;
    tipPercentage = 15;
    totalTip = 0;
    totalBill = 0;
    tipPercentageController = TextEditingController(text: '$tipPercentage');
    billAmountController = TextEditingController(text: '$billAmount');

    billAmountErrorText = null;
    tipPercentageErrorText = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: InputTextField(
                controller: billAmountController,
                label: 'Bill Amount',
                errorText: billAmountErrorText,
                iconData: Icons.attach_money,
                onChanged: onBillAmountChanged,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 50,
                child: InputTextField(
                  controller: tipPercentageController,
                  label: 'Tip Percentage',
                  errorText: tipPercentageErrorText,
                  iconData: Icons.percent,
                  onChanged: onTipPercentageChanged,
                )),
            // show total tip and total bill
            const Divider(
              height: 30,
            ),

            TotalRow(
              title: 'Total Tip',
              amount: totalTip,
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
