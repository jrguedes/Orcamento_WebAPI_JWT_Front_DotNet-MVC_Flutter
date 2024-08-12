import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orcamento_app_flutter/App/controllers/home/home_controller.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/cadastro_item_orcamento.dart';

import '../../controllers/account/account_controller.dart';
import '../../controllers/orcamento/orcamento_controller.dart';
import '../../services/service_manager.dart';

import '../widgets/custom_text_form_field.dart';

class CadastroOrcamento extends StatefulWidget {
  const CadastroOrcamento({super.key});

  @override
  State<CadastroOrcamento> createState() => _CadastroOrcamentoState();
}

class _CadastroOrcamentoState extends State<CadastroOrcamento> {
  final TextEditingController _orcamentoEdtController = TextEditingController(text: '');

  final OrcamentoController _orcamentoController = GetIt.I.get<ServiceManager>().orcamentoController;
  final HomeController _homeController = GetIt.I.get<ServiceManager>().homeController;

  @override
  Widget build(BuildContext context) {
    Theme.of(context).textTheme.headlineMedium;
    return Container(
      padding: const EdgeInsets.only(top: 150, left: 15, right: 15),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Orçamento', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 30),
            CustomTextFormField(
              labelText: 'O que você gostaria de orçar?',
              hintText: 'O que você gostaria de orçar?',
              controller: _orcamentoEdtController,
              icon: const Icon(Icons.attach_money_outlined),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                  onPressed: () async {
                    await _orcamentoController.saveOrcamento(_orcamentoEdtController.text);
                    _homeController.convexAppBarTap(4);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
