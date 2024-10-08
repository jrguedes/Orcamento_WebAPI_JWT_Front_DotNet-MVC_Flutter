import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/login_form.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/welcome_page.dart';
import 'package:orcamento_app_flutter/App/pages/widgets/credits_widget.dart';

class HomePage extends StatefulWidget {
  final bool userLogged;
  final TokenModel? jwtTokenInfo;
  final String? erroMessage;
  final String title;
  HomePage({
    Key? key,
    this.jwtTokenInfo,
    this.erroMessage,
    required this.title,
    required this.userLogged,
  }) : super(key: key);

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
          Color(0xFF80d0c7),
          Color(0xFF3c899b),
        ],
        radius: .7,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const FaIcon(
            FontAwesomeIcons.circleDollarToSlot,
            color: Colors.amber,
            size: 140,
          ),
          Title(
            color: Colors.amber,
            title: widget.title,
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: size.height * 0.60,
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.userLogged
                    ? WelcomePage(jwtTokenInfo: widget.jwtTokenInfo!, title: widget.title)
                    : const LoginForm(),
                widget.erroMessage != null
                    ? Container(
                        child: Text(
                          widget.erroMessage!,
                          style: const TextStyle(
                            color: Color.fromARGB(209, 156, 8, 8),
                          ),
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
