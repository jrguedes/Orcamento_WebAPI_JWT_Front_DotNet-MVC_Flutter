import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/pages/widgets/animated_login_button.dart';
import 'package:orcamento_app_flutter/App/pages/widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: size.height / 2.5,
      child: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Login Form'),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                icon: Icons.person_outline,
                obscure: false,
                hintText: 'Usuário',
                onChanged: (value) => {},
              ),
              const SizedBox(height: 15),
              CustomTextField(
                icon: Icons.lock_outline,
                obscure: true,
                hintText: 'Senha',
                onChanged: (value) => {},
              ),
              const SizedBox(height: 15),
              AnimatedLoginButton()
            ],
          ),
        ),
      ),
    );
  }
}
