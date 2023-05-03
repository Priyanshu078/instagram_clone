import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class InstaButton extends StatelessWidget {
  const InstaButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.fontSize,
      required this.textColor,
      required this.fontWeight,
      required this.buttonColor});

  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final Color textColor;
  final Color buttonColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: buttonColor == Colors.black
            ? BorderSide(width: 1, color: Colors.white.withOpacity(0.15))
            : null,
        backgroundColor: buttonColor,
        minimumSize: Size(double.infinity, height * 0.065),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: InstaText(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          text: text),
    );
  }
}
