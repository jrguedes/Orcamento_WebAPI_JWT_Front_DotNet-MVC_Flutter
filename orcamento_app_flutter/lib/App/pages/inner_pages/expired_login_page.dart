import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/account/account_controller.dart';
import '../../controllers/bottom_bar/bottom_bar_controller.dart';
import '../../stores/istore.dart';

class ExpiredLoginPage extends StatelessWidget {
  final IStore? store;
  ExpiredLoginPage({super.key, this.store});

  late final AccountController _accountController;

  late final BottomBarController _bottomBar;

  Widget _buildFullScreenExpiredLoginMessage(BuildContext context) {
    _accountController = context.read();
    _bottomBar = context.read();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
            _bottomBar.convexAppBarTap(0);
            Navigator.popUntil(context, ModalRoute.withName('/'));
            await _accountController.logout();
            store?.initState();
          },
          child: const Text('Logar'),
        ),
      ],
    );
  }

  void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog.fullscreen(child: _buildFullScreenExpiredLoginMessage(context)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
