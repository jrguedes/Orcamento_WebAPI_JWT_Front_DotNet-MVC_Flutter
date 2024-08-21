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
        style: const TextStyle(color: Colors.black54, fontSize: 16),
        obscureText: obscure,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Theme.of(context).hintColor,
            size: 30,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).hintColor, fontSize: 20, letterSpacing: 1.15),
          contentPadding: const EdgeInsets.all(10),
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).focusColor),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
