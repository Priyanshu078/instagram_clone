import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class InstaSnackbar {
  const InstaSnackbar({
    required this.text,
  });

  final String text;

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 2),
      content: InstaText(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          text: text),
    ));
  }
}
