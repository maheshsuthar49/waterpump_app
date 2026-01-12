import 'package:flutter/material.dart';
import 'package:water_pump/shared/custom_theme.dart';

class CustomButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final IconData? icon;
  final bool isOutlined;

  const CustomButton({
   super.key,
   required this.text,
    required this.onPressed,
    this.color,
    this.width,
    this.height,
    this.fontSize,
    this.icon,
    this.isOutlined = false,
    this.textColor
});
  @override
  Widget build(BuildContext context) {
    final btnColor = color ??AppColors.primaryGreen;
    final txtColor = textColor ?? Colors.white;
    return ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          foregroundColor: txtColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )
        ),
        child: Text(text, style: TextStyle(fontSize: fontSize ?? 16, ),));
  }

}