import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstaText extends StatelessWidget {
  const InstaText(
      {super.key,
      required this.fontSize,
      required this.color,
      required this.fontWeight,
      required this.text});

  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceSansPro(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
