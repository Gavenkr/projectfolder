import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}