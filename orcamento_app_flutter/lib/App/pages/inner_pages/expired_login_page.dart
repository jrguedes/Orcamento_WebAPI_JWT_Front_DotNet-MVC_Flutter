import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/account/account_controller.dart';
import '../../controllers/bottom_bar/bottom_bar_controller.dart';
import '../../stores/istore.dart';

class ExpiredLoginPage extends StatefulWidget {
  final IStore? store;
  ExpiredLoginPage({super.key, this.store});

  @override
  State<ExpiredLoginPage> createState() => _ExpiredLoginPageState();
}

class _ExpiredLoginPageState extends State<ExpiredLoginPage> {
  late final AccountController _accountController;

  late final BottomBarController _bottomBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog.fullscreen(child: _buildFullScreenExpiredLoginMessage()),
      );
    });
  }

  Widget _buildFullScreenExpiredLoginMessage() {
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
            Navigator.pop(context);
            await _accountController.logout();
            widget.store?.initState();
          },
          child: const Text('Logar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _accountController = context.read();
    _bottomBar = context.read();
    return Center(
      child: Container(
        alignment: Alignment.center,
        //height: 350,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
