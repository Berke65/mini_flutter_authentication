import 'package:flutter/material.dart';
import 'package:untitled2/utils/custom_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.textColor = CustomColors.textColor
      });

  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(buttonText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
