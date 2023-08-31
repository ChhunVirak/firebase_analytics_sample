import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      textInputAction: textInputAction ?? TextInputAction.next,
      // maxLines: null,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        isDense: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
