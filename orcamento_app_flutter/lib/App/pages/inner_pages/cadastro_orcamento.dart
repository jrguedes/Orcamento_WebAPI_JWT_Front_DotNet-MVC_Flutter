import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orcamento_app_flutter/App/controllers/home/home_controller.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/cadastro_item_orcamento.dart';

import '../../controllers/account/account_controller.dart';
import '../../services/service_manager.dart';

import '../widgets/custom_text_field.dart';

class CadastroOrcamento extends StatefulWidget {
  const CadastroOrcamento({super.key});

  @override
  State<CadastroOrcamento> createState() => _CadastroOrcamentoState();
}

class _CadastroOrcamentoState extends State<CadastroOrcamento> {
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  final AccountController _accountController = GetIt.I.get<ServiceManager>().accountController;
  final HomeController _homeController = GetIt.I.get<ServiceManager>().homeController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Theme.of(context).textTheme.headlineMedium;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: size.height / 2.5,
      child: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Cadastro de Orçamento', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 30),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                icon: Icons.attach_money,
                obscure: false,
                hintText: 'O que você gostaria de orçar?',
                textEditingController: _emailController,
                onChanged: (value) => {},
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 45),
                  CupertinoButton.filled(
                    onPressed: () => _homeController.convexAppBarTap(4), //_showDialog(context),
                    child: const Text('Salvar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Center(
                child: Text(
                  'Item Orçamento',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              contentPadding: const EdgeInsets.only(right: 0, left: 0, bottom: 0, top: 12),
              content: CadastroItemOrcamento(),
            ));
  }
}
