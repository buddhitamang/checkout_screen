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
    required this.validator,
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
            prefixIcon: prefixIcon,
            errorText: errorText,
          ),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
