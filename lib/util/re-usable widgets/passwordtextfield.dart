import 'package:flutter/material.dart';

class PasswordTextfield extends StatelessWidget {
  const PasswordTextfield({super.key,required this.controller,required this.hint});
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(true);

    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, obscureText, child) {
        return TextField(
          controller: controller,
          obscureText: obscureText, 
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.password),
            suffixIcon: GestureDetector(
              onTap: () {
                obscureTextNotifier.value = !obscureTextNotifier.value;
              },
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        );
      },
    );
  }
}
