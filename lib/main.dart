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

  late String? errorText;

  void onBillAmountChanged(String value) {
    setState(() {
      if (value.isNotEmpty) {
        billAmount = double.tryParse(value) ?? 0;
      } else {
        billAmount = 0;
      }

      calculateTotalTipAndBill();
    });
  }

  void onTipPercentageChanged(String value) {
    if (value.isNotEmpty) {
      final percentValue = double.tryParse(value) ?? 0;
      if (percentValue > 100) {
        if (errorText == null) {
          errorText = 'Can not be greater than 100%';
          tipPercentage = 0;
          calculateTotalTipAndBill();
          setState(() {});
        }
      } else {
        if (errorText != null) {
          errorText = null;
        }

        tipPercentage = percentValue;
        calculateTotalTipAndBill();
        setState(() {});
      }
    } else {
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

    errorText = null;
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Bill Amount'),
                  suffixIcon: Icon(Icons.attach_money),
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
                  border: const OutlineInputBorder(),
                  label: const Text('Tip Percentage'),
                  suffixIcon: Icon(
                    Icons.percent,
                    color: errorText != null ? Colors.red : null,
                  ),
                  errorText: errorText,
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
                  errorText != null ? 'N/A' : formatAmount(totalTip),
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
                  formatAmount(totalBill),
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
