import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Enter your email",
        // [enabledBorder], displayed when [TextField, InputDecoration.enabled] is true
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent),
        ),
        //[focusedBorder], displayed when [TextField, InputDecorator.isFocused] is true
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
