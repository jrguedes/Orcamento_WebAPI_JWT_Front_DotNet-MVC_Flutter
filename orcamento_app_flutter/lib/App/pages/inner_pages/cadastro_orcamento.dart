import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/bottom_bar/bottom_bar_controller.dart';
import '../../controllers/orcamento/orcamento_controller.dart';
import '../../models/orcamento_model.dart';
import '../widgets/custom_text_form_field.dart';
import 'modals/add_item_orcamento_modal.dart';
import 'modals/modal_dialog.dart';

class CadastroOrcamento extends StatefulWidget {
  const CadastroOrcamento({super.key});

  @override
  State<CadastroOrcamento> createState() => _CadastroOrcamentoState();
}

class _CadastroOrcamentoState extends State<CadastroOrcamento> {
  final TextEditingController _orcamentoEdtController = TextEditingController(text: '');

  late final OrcamentoController _orcamentoController;
  late final BottomBarController _bottomBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orcamentoController = context.read();
    _bottomBar = context.read();
  }

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                  onPressed: () async {
                    var orcamento = await _orcamentoController.saveOrcamento(_orcamentoEdtController.text);
                    if (orcamento != null) {
                      await ModalDialog.show(
                        context: context,
                        title: 'Adicionar Item ao orçamento',
                        content: AddItemOrcamentoModal(orcamento: orcamento),
                      );
                    }
                  },
                  child: const Text('Salvar'),
                ),
                /*
                const SizedBox(height: 20),
                CupertinoButton(
                  child: const Text('Item Orçamento'),
                  onPressed: () async {
                    var orcamento = OrcamentoModel(id: 10, descricao: 'Orçamento de Teste', data: DateTime.now());
                    await ModalDialog.show(
                      context: context,
                      title: 'Adicionar Item ao orçamento',
                      content: AddItemOrcamentoModal(orcamento: orcamento),
                    );
                  },
                )
                */
              ],
            )
          ],
        ),
      ),
    );
  }
}
