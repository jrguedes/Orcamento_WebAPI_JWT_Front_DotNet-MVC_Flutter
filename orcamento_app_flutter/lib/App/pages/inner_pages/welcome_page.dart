import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';

import '../../controllers/account/account_controller.dart';
import '../../services/service_manager.dart';

class WelcomePage extends StatelessWidget {
  final TokenModel jwtTokenInfo;
  final AccountController _accountController = GetIt.I.get<ServiceManager>().accountController;

  WelcomePage({super.key, required this.jwtTokenInfo});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: size.height / 2.5,
      child: Center(
        child: Column(
          children: [
            Text(
              'Bem vindo ${jwtTokenInfo.name}! \n \n Função: ${jwtTokenInfo.role}',
              textAlign: TextAlign.center,
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
