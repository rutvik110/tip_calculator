import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      setState(() {
        if (amount != null) {
          billAmount = amount;
          billAmountErrorText = null;
        } else {
          billAmount = 0;
          billAmountErrorText = 'Invalid bill amount';
        }

        calculateTotalTipAndBill();
      });
    } else {
      setState(() {
        billAmount = 0;
        billAmountErrorText = 'Requires bill amount';
        calculateTotalTipAndBill();
      });
    }
  }

  void onTipPercentageChanged(String value) {
    if (value.isNotEmpty) {
      final percentage = double.tryParse(value);
      if (percentage != null) {
        if (percentage > 100) {
          tipPercentageErrorText = 'Can not be greater than 100%';
          tipPercentage = 0;
          calculateTotalTipAndBill();
          setState(() {});
        } else {
          tipPercentageErrorText = null;
          tipPercentage = percentage;
          calculateTotalTipAndBill();
          setState(() {});
        }
      } else {
        tipPercentageErrorText = 'Invalid tip percentage';
        tipPercentage = 0;
        calculateTotalTipAndBill();
        setState(() {});
      }
    } else {
      tipPercentageErrorText = 'Requires tip percentage';
      tipPercentage = 0;
      calculateTotalTipAndBill();
      setState(() {});
    }
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

  String formatAmount(double amount) {
    return '${NumberFormat("#,##0.00", "en_US").format(amount)}\$';
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
    final moneyTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
    );
    final titleTextStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
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
            SizedBox(
              height: 50,
              child: TextField(
                controller: billAmountController,
                decoration: InputDecoration(
                  // hintText: 'Add Bill Amount',
                  border: const OutlineInputBorder(),
                  label: const Text('Bill Amount'),
                  suffixIcon: Icon(
                    Icons.attach_money,
                    color: billAmountErrorText != null ? Colors.red : null,
                  ),
                  errorText: billAmountErrorText,
                ),
                onChanged: onBillAmountChanged,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: tipPercentageController,
                decoration: InputDecoration(
                  // hintText: 'Add Tip Percentage',
                  border: const OutlineInputBorder(),
                  label: const Text('Tip Percentage'),
                  suffixIcon: Icon(
                    Icons.percent,
                    color: tipPercentageErrorText != null ? Colors.red : null,
                  ),
                  errorText: tipPercentageErrorText,
                ),
                onChanged: onTipPercentageChanged,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            // show total tip and total bill
            const Divider(
              height: 30,
            ),

            Row(
              children: [
                Text(
                  'Total Tip: ',
                  style: titleTextStyle,
                ),
                Text(
                  tipPercentageErrorText != null || billAmountErrorText != null
                      ? 'N/A'
                      : formatAmount(totalTip),
                  style: moneyTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Total Bill: ',
                  style: titleTextStyle,
                ),
                Text(
                  tipPercentageErrorText != null || billAmountErrorText != null
                      ? 'N/A'
                      : formatAmount(totalBill),
                  style: moneyTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
