import 'package:flutter/material.dart';

class TextFieldModel extends StatelessWidget {
  const TextFieldModel(
      {super.key, required this.textController, this.obscureText = false, this.suffixIcon, this.hintText='' });
  final TextEditingController textController;
  final bool obscureText;
  final IconButton? suffixIcon;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade300,
          suffixIcon: suffixIcon,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(16.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10)),
      onChanged: (value) {
        print(textController.text);
      },
    );
  }
}
