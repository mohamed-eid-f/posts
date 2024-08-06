import 'package:flutter/material.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int lines;
  const AppTextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.hint,
      this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$hint should not be empty" : null,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        minLines: lines,
        maxLines: lines,
      ),
    );
  }
}
