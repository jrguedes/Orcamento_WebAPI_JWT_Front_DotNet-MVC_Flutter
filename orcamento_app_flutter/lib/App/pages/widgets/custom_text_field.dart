import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final bool obscure;
  final String hintText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String? errorText;
  final TextEditingController textEditingController;

  CustomTextField(
      {super.key,
      required this.icon,
      required this.obscure,
      required this.hintText,
      required this.onChanged,
      required this.textEditingController,
      this.errorText,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: TextField(
        keyboardType: keyboardType,
        controller: textEditingController,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
        obscureText: obscure,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.deepPurple[300],
              size: 30,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 20, letterSpacing: 1.15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(10),
            errorText: errorText),
      ),
    );
  }
}
