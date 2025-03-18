import 'package:flutter/material.dart';

class custom_input_field extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  custom_input_field({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2)),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
// user_model.dart
// user_model.dart
class user {
  final String email;
  final String password;

  user({required this.email, required this.password});
}
