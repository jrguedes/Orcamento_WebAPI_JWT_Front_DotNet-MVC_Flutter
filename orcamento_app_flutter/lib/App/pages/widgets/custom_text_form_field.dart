import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, this.labelText, this.hintText, this.errorText, this.controller, this.icon})
      : super(key: key);
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    Color borderColor = const Color.fromARGB(255, 91, 45, 114);
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 91, 45, 114)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 91, 45, 114)),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 91, 45, 114)),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          errorStyle: const TextStyle(
            height: 0.4,
          ),
        ),
      ),
    );
  }
}
