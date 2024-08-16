import 'package:flutter/material.dart';

import '../../../models/orcamento_model.dart';
import '../../widgets/custom_text_form_field.dart';

class UpdateOrcamentoModal extends StatelessWidget {
  final OrcamentoModel orcamento;
  const UpdateOrcamentoModal({Key? key, required this.orcamento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 400,
      width: 400,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CustomTextFormField(labelText: 'Descrição', hintText: 'Descrição'),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Adicionar'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
