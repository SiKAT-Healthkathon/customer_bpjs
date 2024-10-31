import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final TextInputType keyboardType;
  final bool isMultiline;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: blackText.copyWith(
            fontWeight: medium,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          maxLines: isMultiline ? null : 1,
          style: blackText.copyWith(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintStyle: greyText.copyWith(fontSize: 14),
            hintText: hintText,
            filled: true,
            fillColor: lightGreyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
