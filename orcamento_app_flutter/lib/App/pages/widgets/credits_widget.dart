import 'package:flutter/material.dart';

class CreditsWidget extends StatelessWidget {
  const CreditsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        child: const Text(
          textAlign: TextAlign.center,
          'Developed by: Júnior Guedes',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}