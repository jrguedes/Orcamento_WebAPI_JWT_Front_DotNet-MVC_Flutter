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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textAlign: TextAlign.left,
              'Developed by: Júnior Guedes',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 10,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
