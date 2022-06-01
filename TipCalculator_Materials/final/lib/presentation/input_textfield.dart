import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.controller,
    required this.decoration,
    required this.label,
    required this.iconData,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final InputDecoration decoration;
  final String? errorText;
  final IconData iconData;
  final void Function(String value) onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: decoration,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
