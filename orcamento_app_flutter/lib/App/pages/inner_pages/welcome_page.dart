import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/account/account_controller.dart';
import '../../models/token_model.dart';

class WelcomePage extends StatelessWidget {
  final TokenModel jwtTokenInfo;
  late final AccountController _accountController;

  WelcomePage({super.key, required this.jwtTokenInfo});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _accountController = context.read();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: size.height / 2.5,
      child: Center(
        child: Column(
          children: [
            Text(
              'Bem vindo ${jwtTokenInfo.name}! \n \n Função: ${jwtTokenInfo.role}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: _accountController.logout,
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
