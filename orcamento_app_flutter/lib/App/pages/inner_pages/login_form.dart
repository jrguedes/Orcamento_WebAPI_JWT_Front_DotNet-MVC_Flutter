import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/account/account_controller.dart';
import '../widgets/animated_login_button.dart';
import '../widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  late final AccountController _accountController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: size.height / 2.5,
      child: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                icon: Icons.person_outline,
                obscure: false,
                hintText: 'Usuário',
                textEditingController: _emailController,
                onChanged: (value) => {},
              ),
              const SizedBox(height: 15),
              CustomTextField(
                icon: Icons.lock_outline,
                obscure: true,
                hintText: 'Senha',
                textEditingController: _passwordController,
                onChanged: (value) => {},
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 45),
                  AnimatedLoginButton(
                    onTap: _buttonTapped,
                    buttonTappedState: _accountController.buttonTappedState,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _buttonTapped() {
    _accountController.signIn(email: _emailController.text, password: _passwordController.text);
  }
}
