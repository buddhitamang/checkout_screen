import 'package:flutter/material.dart';

class TextFieldPage extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? errorText;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;

  const TextFieldPage({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.controller,
    this.errorText,
    this.prefixIcon,
    required this.validator, // Accept validator function
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: hintText,
            prefixIcon: prefixIcon, // Icon displayed at the start
            errorText: errorText, // Error message
          ),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,// Use the validator function
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
