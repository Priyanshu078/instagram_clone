import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class InstaButton extends StatelessWidget {
  const InstaButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.fontSize,
      required this.color,
      required this.fontWeight});

  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: instablue,
        minimumSize: Size(double.infinity, height * 0.065),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: InstaText(
          fontSize: fontSize, color: color, fontWeight: fontWeight, text: text),
    );
  }
}
