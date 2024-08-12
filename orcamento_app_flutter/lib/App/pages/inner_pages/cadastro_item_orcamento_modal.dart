import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_form_field.dart';

class CadastroItemOrcamentoModal extends StatelessWidget {
  const CadastroItemOrcamentoModal({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      width: size.width - 30,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextFormField(labelText: 'Item de orçamento', hintText: 'Item de orçamento'),
              Container(
                padding: const EdgeInsets.only(top: 5),
                //width: double.infinity,
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
