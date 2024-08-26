import 'package:auto_size_text/auto_size_text.dart';
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
    var size = MediaQuery.sizeOf(context);

    return Container(
      padding: EdgeInsets.zero,
      height: 550,
      width: size.width - 20,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
          child: Container(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    orcamento.descricao,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 23,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  labelText: 'Estabelecimento',
                  hintText: 'Estabelecimento',
                  keyboardType: TextInputType.name,
                  controller: _estabelecimentoEdtController,
                  icon: Icon(Icons.store, color: Theme.of(context).hintColor),
                ),
                CustomTextFormField(
                  labelText: 'Telefone',
                  hintText: 'Telefone',
                  keyboardType: TextInputType.phone,
                  controller: _telefoneEdtController,
                  icon: Icon(Icons.phone, color: Theme.of(context).hintColor),
                ),
                CustomTextFormField(
                  labelText: 'Responsável',
                  hintText: 'Responsável',
                  keyboardType: TextInputType.name,
                  controller: _responsavelEdtController,
                  icon: Icon(Icons.co_present_rounded, color: Theme.of(context).hintColor),
                ),
                CustomTextFormField(
                  labelText: 'Valor',
                  hintText: 'Valor',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  controller: _valorEdtController,
                  icon: Icon(Icons.attach_money_outlined, color: Theme.of(context).hintColor),
                ),
                CustomTextFormField(
                  labelText: 'Descrição',
                  hintText: 'Descrição',
                  keyboardType: TextInputType.text,
                  controller: _descricaoEdtController,
                  icon: Icon(Icons.description_outlined, color: Theme.of(context).hintColor),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _controller.saveItemOrcamento(
                          orcamento.id,
                          _estabelecimentoEdtController.text,
                          _telefoneEdtController.text,
                          _responsavelEdtController.text,
                          double.parse(_valorEdtController.text),
                          _descricaoEdtController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Adicionar'),
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
