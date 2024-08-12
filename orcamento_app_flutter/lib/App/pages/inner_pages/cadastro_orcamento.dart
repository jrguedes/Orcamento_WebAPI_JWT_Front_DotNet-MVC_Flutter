import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orcamento_app_flutter/App/controllers/home/home_controller.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/cadastro_item_orcamento.dart';

import '../../controllers/account/account_controller.dart';
import '../../services/service_manager.dart';

import '../widgets/custom_text_form_field.dart';

class CadastroOrcamento extends StatefulWidget {
  const CadastroOrcamento({super.key});

  @override
  State<CadastroOrcamento> createState() => _CadastroOrcamentoState();
}

class _CadastroOrcamentoState extends State<CadastroOrcamento> {
  final TextEditingController _orcamentoEdtController = TextEditingController(text: '');
  final AccountController _accountController = GetIt.I.get<ServiceManager>().accountController;
  final HomeController _homeController = GetIt.I.get<ServiceManager>().homeController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Theme.of(context).textTheme.headlineMedium;
    return Container(
      padding: const EdgeInsets.only(top: 150, left: 15, right: 15),
      child: Container(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Orçamento', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 30),
              CustomTextFormField(
                  controller: _orcamentoEdtController,
                  labelText: 'O que você gostaria de orçar?',
                  hintText: 'O que você gostaria de orçar?',
                  icon: const Icon(Icons.attach_money_outlined)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton.filled(
                    onPressed: () => _homeController.convexAppBarTap(4),
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
}
