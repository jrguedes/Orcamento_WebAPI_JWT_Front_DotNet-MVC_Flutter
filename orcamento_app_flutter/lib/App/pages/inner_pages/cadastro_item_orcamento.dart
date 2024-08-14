import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/bottom_bar/bottom_bar_controller.dart';
import '../../controllers/item_orcamento/item_orcamento_controller.dart';
import '../../models/orcamento_model.dart';
import '../widgets/custom_text_form_field.dart';

class CadastroItemOrcamento extends StatelessWidget {
  CadastroItemOrcamento({super.key, required this.orcamentoModel});

  final OrcamentoModel? orcamentoModel;
  late final BottomBarController _bottomBar;
  late final ItemOrcamentoController _controller;

  final TextEditingController _estabelecimentoEdtController = TextEditingController(text: '');
  final TextEditingController _telefoneEdtController = TextEditingController(text: '');
  final TextEditingController _responsavelEdtController = TextEditingController(text: '');
  final TextEditingController _descricaoEdtController = TextEditingController(text: '');
  final TextEditingController _valorEdtController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    _bottomBar = context.read();
    _controller = context.read();

    return Container(
      padding: const EdgeInsets.only(top: 150, left: 15, right: 15),
      child: Column(
        children: [
          Text('Adicionar Item de Orçamento', style: Theme.of(context).textTheme.headlineMedium),
          orcamentoModel != null
              ? Text(orcamentoModel!.descricao, style: Theme.of(context).textTheme.headlineSmall)
              : Container(),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: 'Estabelecimento',
            hintText: 'Estabelecimento',
            controller: _estabelecimentoEdtController,
            icon: const Icon(Icons.store),
          ),
          CustomTextFormField(
            labelText: 'Telefone',
            hintText: 'Telefone',
            controller: _telefoneEdtController,
            icon: const Icon(Icons.phone),
          ),
          CustomTextFormField(
            labelText: 'Responsável',
            hintText: 'Responsável',
            controller: _responsavelEdtController,
            icon: const Icon(Icons.co_present_rounded),
          ),
          CustomTextFormField(
            labelText: 'Valor',
            hintText: 'Valor',
            controller: _valorEdtController,
            icon: const Icon(Icons.attach_money_outlined),
          ),
          CustomTextFormField(
            labelText: 'Descrição',
            hintText: 'Descrição',
            controller: _descricaoEdtController,
            icon: const Icon(Icons.description_outlined),
          ),
          const SizedBox(height: 30),
          CupertinoButton.filled(
            child: const Text('Adicionar'),
            onPressed: () async {
              await _controller.saveItemOrcamento(_estabelecimentoEdtController.text, _telefoneEdtController.text,
                  _responsavelEdtController.text, double.parse(_valorEdtController.text), _descricaoEdtController.text);
              _bottomBar.convexAppBarTap(3);
            },
          ),
        ],
      ),
    );
  }
}
