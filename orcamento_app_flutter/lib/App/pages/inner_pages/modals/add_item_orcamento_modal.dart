import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/bottom_bar/bottom_bar_controller.dart';
import '../../../controllers/item_orcamento/item_orcamento_controller.dart';
import '../../../models/orcamento_model.dart';
import '../../widgets/custom_text_form_field.dart';

class AddItemOrcamentoModal extends StatelessWidget {
  final OrcamentoModel orcamento;
  late final BottomBarController _bottomBar;
  late final ItemOrcamentoController _controller;

  final TextEditingController _estabelecimentoEdtController = TextEditingController(text: '');
  final TextEditingController _telefoneEdtController = TextEditingController(text: '');
  final TextEditingController _responsavelEdtController = TextEditingController(text: '');
  final TextEditingController _descricaoEdtController = TextEditingController(text: '');
  final TextEditingController _valorEdtController = TextEditingController(text: '');

  AddItemOrcamentoModal({Key? key, required this.orcamento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _bottomBar = context.read();
    _controller = context.read();

    return Container(
      padding: EdgeInsets.zero,
      height: 550,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
          child: Container(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              children: [
                //Text('Adicionar Item de Orçamento', style: Theme.of(context).textTheme.headlineMedium),
                Text(orcamento.descricao, style: Theme.of(context).textTheme.headlineSmall),
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

                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Adicionar'),
                    onPressed: () async {
                      await _controller.saveItemOrcamento(
                          orcamento.id,
                          _estabelecimentoEdtController.text,
                          _telefoneEdtController.text,
                          _responsavelEdtController.text,
                          double.parse(_valorEdtController.text),
                          _descricaoEdtController.text);
                      //_bottomBar.convexAppBarTap(2);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
