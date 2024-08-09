import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/login_form.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/welcome_page.dart';
import 'package:orcamento_app_flutter/App/pages/widgets/credits_widget.dart';

class HomePage extends StatefulWidget {
  final bool userLogged;
  final TokenModel? jwtTokenInfo;
  final String? erroMessage;
  HomePage({
    Key? key,
    this.jwtTokenInfo,
    this.erroMessage,
    required this.title,
    required this.userLogged,
  }) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          gradient: RadialGradient(
        colors: [
          Colors.white,
          Color.fromARGB(163, 34, 13, 69),
        ],
        radius: .7,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Image(
              height: 130,
              width: 120,
              fit: BoxFit.cover,
              image: AssetImage(
                'lib/app/assets/images/2606581_5917_ouro.png',
              )),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: size.height * 0.60,
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor, //Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                  //style:  Theme.of(context).textTheme.headline4,
                ),
                widget.userLogged ? WelcomePage(jwtTokenInfo: widget.jwtTokenInfo!) : const LoginForm(),
                widget.erroMessage != null
                    ? Container(
                        child: Text(
                          widget.erroMessage!,
                          style: TextStyle(color: Colors.red[300]),
                        ),
                      )
                    : Container(),
                const CreditsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
