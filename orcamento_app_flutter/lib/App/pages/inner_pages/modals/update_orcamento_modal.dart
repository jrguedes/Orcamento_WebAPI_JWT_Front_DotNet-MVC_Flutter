import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/orcamento/orcamento_controller.dart';
import '../../../models/orcamento_model.dart';
import '../../widgets/custom_text_form_field.dart';
import '../expired_login_page.dart';

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

    var _size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 30),
      height: 200,
      width: _size.width - 30,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
          child: ListView(
            children: [
              CustomTextFormField(
                labelText: 'O que você gostaria de orçar?',
                hintText: 'O que você gostaria de orçar?',
                controller: _orcamentoEdtController,
                icon: Icon(Icons.attach_money_outlined, color: Theme.of(context).hintColor),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(200, 40)),
                onPressed: () async {
                  var orcamentoResponse =
                      await _orcamentoController.updateOrcamento(orcamento, _orcamentoEdtController.text);
                  if (!orcamentoResponse.validToken) {
                    return ExpiredLoginPage().show(context);
                  }
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
