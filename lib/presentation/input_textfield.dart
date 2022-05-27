import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.iconData,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String? errorText;
  final IconData iconData;
  final void Function(String value) onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        // hintText: 'Add Bill Amount',
        border: const OutlineInputBorder(),
        label: Text(label),
        suffixIcon: Icon(
          iconData,
          color: errorText != null ? Colors.red : null,
        ),
        errorText: errorText,
      ),
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
