import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class FacilityCard extends StatelessWidget {
  const FacilityCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
    this.isSelected = false,
    this.margin,
  });

  final String title;
  final String description;
  final Function()? onTap;
  final bool isSelected;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? lightBlueColor : whiteColor,
          border: Border.all(
            color: isSelected ? blueColor : lightBlueColor,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: blackText.copyWith(
                fontWeight: semibold,
              ),
            ),
            Text(
              description,
              style: greyText.copyWith(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
