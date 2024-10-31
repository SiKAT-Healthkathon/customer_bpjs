import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import 'custom_button.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    this.onPressed,
    this.text = 'Lanjutkan',
    this.onPressedSeccond,
    this.textSeccond,
  });

  final Function()? onPressed;
  final String text;
  final Function()? onPressedSeccond;
  final String? textSeccond;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24, right: 24, left: 24, top: 16),
      decoration: const BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: lightBlueColor,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Visibility(
            visible: textSeccond != null,
            child: Expanded(
              child: CustomButton(
                onPressed: onPressedSeccond,
                text: textSeccond ?? '',
                varian: Variant.secondary,
              ),
            ),
          ),
          Visibility(
              visible: textSeccond != null, child: const SizedBox(width: 16)),
          Expanded(
            child: CustomButton(
              onPressed: onPressed,
              text: text,
            ),
          ),
        ],
      ),
    );
  }
}
