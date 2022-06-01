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
      body: Container(),
    );
  }
}
