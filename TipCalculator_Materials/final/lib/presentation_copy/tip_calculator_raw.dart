import 'package:flutter/material.dart';

class TipCalculatorRawView extends StatefulWidget {
  const TipCalculatorRawView({Key? key}) : super(key: key);

  @override
  State<TipCalculatorRawView> createState() => _TipCalculatorRawViewState();
}

class _TipCalculatorRawViewState extends State<TipCalculatorRawView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: add TextStyles
    const billAmountTextFieldDecoration = InputDecoration(
      label: Text('Bill Amount'),
      suffixIcon: Icon(
        Icons.attach_money,
      ),
      border: OutlineInputBorder(),
    );

    const tipPercentageTextFieldDecoration = InputDecoration(
      label: Text('Tip Percentage'),
      suffixIcon: Icon(
        Icons.percent,
      ),
      border: OutlineInputBorder(),
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
            const TextField(), // For Bill Amount

            const SizedBox(
              height: 20,
            ),
            const TextField(), // For Tip Percentage

            const Divider(
              height: 30,
            ),

            Row(
              children: [
                const Text(
                  'Total Tip: ',
                  // TODO : add title TextStyle
                ),
                const Text(
                  '10\$',
                  // TODO : add amount TextStyle
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Total Bill: ',
                  // TODO : add title TextStyle
                ),
                const Text(
                  '20\$',
                  // TODO : add amount TextStyle
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}