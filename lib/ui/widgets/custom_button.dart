import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

enum Variant {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.varian = Variant.primary});

  final void Function()? onPressed;
  final String text;
  final Variant varian;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: Variant.primary == varian ? blueColor : lightBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        text,
        style: (Variant.primary == varian ? whiteText : blueText).copyWith(
          fontSize: 16,
        ),
      ),
    );
  }
}
