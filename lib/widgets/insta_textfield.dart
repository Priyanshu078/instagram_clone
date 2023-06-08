import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstaTextField extends StatelessWidget {
  const InstaTextField({
    super.key,
    this.controller,
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
    this.suffixIcon,
    required this.editProfileTextfield,
    required this.enabled,
    required this.onChange,
    this.focusNode,
  });

  final TextEditingController? controller;
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
  final bool editProfileTextfield;
  final bool enabled;
  final Function(String value)? onChange;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: onChange,
      enabled: enabled,
      cursorColor: Colors.white,
      style: GoogleFonts.sourceSansPro(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      controller: controller,
      obscureText: obscureText,
      decoration: editProfileTextfield
          ? InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
              ),
            )
          : InputDecoration(
              suffixIcon: forPassword
                  ? IconButton(
                      icon: suffixIcon!,
                      onPressed: suffixIconCallback,
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              contentPadding: const EdgeInsets.only(left: 8),
              prefixIcon: icon,
              isDense: true,
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
