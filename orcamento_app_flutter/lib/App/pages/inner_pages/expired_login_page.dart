import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.circleDollarToSlot,
                  color: Colors.amber,
                  size: 150,
                ),
                Text(
                  'OrçApp',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text('😢', textAlign: TextAlign.center, style: TextStyle(fontSize: 40)),
        const Text(
          'Que pena, o login expirou! \n\n Vamos logar novamente?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        const Text('😁', textAlign: TextAlign.center, style: TextStyle(fontSize: 40)),
        const SizedBox(height: 15),
        CupertinoButton(
          onPressed: () async {
            _bottomBar.convexAppBarTap(0);
            Navigator.popUntil(context, ModalRoute.withName('/'));
            await _accountController.logout();
            store?.initState();
          },
          child: const Text('Logar novamente'),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<String>(
        useSafeArea: false,
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
