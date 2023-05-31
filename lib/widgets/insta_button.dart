import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class InstaButton extends StatelessWidget {
  const InstaButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.fontSize,
      required this.textColor,
      required this.fontWeight,
      required this.buttonColor,
      required this.height,
      required this.postButton});

  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final Color textColor;
  final Color buttonColor;
  final FontWeight fontWeight;
  final double height;
  final bool postButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: buttonColor == Colors.black
            ? BorderSide(
                width: 1,
                color:
                    postButton ? Colors.white : Colors.white.withOpacity(0.15))
            : null,
        backgroundColor: buttonColor,
        minimumSize: Size(double.infinity, height),
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
