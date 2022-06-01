import 'package:flutter/material.dart';

class TipCalculatorView extends StatefulWidget {
  const TipCalculatorView({Key? key}) : super(key: key);

  @override
  State<TipCalculatorView> createState() => _TipCalculatorViewState();
}

class _TipCalculatorViewState extends State<TipCalculatorView> {
  // TODO: add and initialize TextEditingControllers
  @override
  Widget build(BuildContext context) {
    // TODO: add textfield decorations
    // TODO: add TextStyles
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
