import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.labelText,
      this.hintText,
      this.errorText,
      this.controller,
      this.icon,
      this.keyboardType,
      this.inputFormatters})
      : super(key: key);
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black54),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).focusColor),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          labelStyle: TextStyle(color: Theme.of(context).hintColor),
          errorText: errorText,
          errorStyle: const TextStyle(
            height: 0.4,
          ),
        ),
      ),
    );
  }
}
