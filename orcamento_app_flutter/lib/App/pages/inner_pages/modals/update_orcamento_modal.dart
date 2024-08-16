import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/orcamento/orcamento_controller.dart';
import '../../../models/orcamento_model.dart';
import '../../widgets/custom_text_form_field.dart';

class UpdateOrcamentoModal extends StatelessWidget {
  final OrcamentoModel orcamento;
  final TextEditingController _orcamentoEdtController = TextEditingController(text: '');
  late final OrcamentoController _orcamentoController;

  UpdateOrcamentoModal({Key? key, required this.orcamento}) : super(key: key) {
    _orcamentoEdtController.text = orcamento.descricao;
  }

  @override
  Widget build(BuildContext context) {
    _orcamentoController = context.read();
    return Container(
      padding: EdgeInsets.zero,
      height: 250,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
          child: Column(
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
              CupertinoButton.filled(
                onPressed: () async {
                  await _orcamentoController.updateOrcamento(orcamento, _orcamentoEdtController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
