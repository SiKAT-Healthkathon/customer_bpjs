import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.progress,
    this.title,
    this.color = whiteColor,
    this.textColor = blackColor,
    this.isBack = true,
  });

  final double? progress;
  final String? title;
  final Color? color;
  final Color? textColor;
  final bool? isBack;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      surfaceTintColor: color,
      title: title != null
          ? Text(
              title!,
              style: blackText.copyWith(
                color: textColor,
                fontSize: 20,
                fontWeight: semibold,
              ),
            )
          : Container(
              height: 16,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: lightGreyColor,
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: blueColor,
                  ),
                ),
              ),
            ),
      leading: isBack == true
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: textColor,
              ),
            )
          : IconButton(
              onPressed: () => Navigator.pushNamed(context, '/tracking'),
              icon: Icon(
                Icons.bookmark,
                color: textColor,
              ),
            ),
    );
  }
}
