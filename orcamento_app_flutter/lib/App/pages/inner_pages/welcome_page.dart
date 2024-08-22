import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../controllers/account/account_controller.dart';
import '../../models/token_model.dart';

class WelcomePage extends StatelessWidget {
  final TokenModel jwtTokenInfo;
  final String title;
  late final AccountController _accountController;

  WelcomePage({super.key, required this.jwtTokenInfo, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _accountController = context.read();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: size.height / 1.9,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            AutoSizeText(
              'Bem vindo ${jwtTokenInfo.name}!',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 23, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: _accountController.logout,
              child: const Text('Sair'),
            ),
            const FaIcon(
              FontAwesomeIcons.circleDollarToSlot,
              color: Colors.amber,
              size: 200,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              jwtTokenInfo.role,
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
            )
          ],
        ),
      ),
    );
  }
}
