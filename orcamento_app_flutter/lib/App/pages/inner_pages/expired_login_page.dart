import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/account/account_controller.dart';

class ExpiredLoginPage extends StatelessWidget {
  ExpiredLoginPage({super.key});
  late final AccountController _accountController;

  @override
  Widget build(BuildContext context) {
    _accountController = context.read();
    return Center(
      child: Container(
        alignment: Alignment.center,
        //height: 350,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const Text(
              'Que pena, O login expirou! \n\n É necessário logar novamente \n clique abaixo para fazê-lo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () async {
                await _accountController.logout();
              },
              child: const Text('Logar'),
            ),
          ],
        ),
      ),
    );
  }
}
