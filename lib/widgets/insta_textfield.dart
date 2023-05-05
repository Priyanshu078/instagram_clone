import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/constants/colors.dart';

class InstaTextField extends StatelessWidget {
  const InstaTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.fontSize,
      required this.color,
      required this.fontWeight,
      required this.hintColor,
      required this.obscureText,
      required this.icon,
      required this.borderRadius,
      required this.backgroundColor,
      required this.forPassword,
      required this.suffixIconCallback,
      this.suffixIcon});

  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final Color color;
  final Color hintColor;
  final FontWeight fontWeight;
  final bool obscureText;
  final Widget? icon;
  final double borderRadius;
  final Color backgroundColor;
  final bool forPassword;
  final VoidCallback suffixIconCallback;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.sourceSansPro(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: forPassword
            ? IconButton(
                icon: suffixIcon!,
                onPressed: suffixIconCallback,
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        contentPadding: EdgeInsets.zero,
        prefixIcon: icon,
        filled: true,
        fillColor: backgroundColor,
        hintText: hintText,
        hintStyle: GoogleFonts.sourceSansPro(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: hintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
      ),
    );
  }
}
