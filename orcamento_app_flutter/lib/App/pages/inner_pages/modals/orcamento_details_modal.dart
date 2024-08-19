import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/models/item_orcamento_model.dart';

import '../../../models/orcamento_model.dart';

class OrcamentoDetailsModal extends StatelessWidget {
  final OrcamentoModel orcamento;
  OrcamentoDetailsModal({Key? key, required this.orcamento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.zero,
        height: size.height - 330,
        width: size.width - 30,
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Column(children: [
                //Text('Adicionar Item de Orçamento', style: Theme.of(context).textTheme.headlineMedium),
                Text(orcamento.descricao, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 30),

                CupertinoButton.filled(
                  onPressed: () async {
                    //await _orcamentoController.updateOrcamento(orcamento, _orcamentoEdtController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Adicionar item ao orçamento'),
                ),
                _buildListItensOrcamento(),
              ]),
            ),
          ),
        ));
  }

  Widget _buildListItensOrcamento() {
    var itens = List.generate(10, (index) {
      return ItemOrcamentoModel(
        id: index,
        estabelecimento: 'estabelecimento $index',
        telefone: '11321',
        responsavel: 'responsavel $index',
        valor: 500,
        descricao: 'descricao $index',
        orcamentoId: 0,
      );
    });
    return Expanded(
      child: ListView.builder(
          itemCount: itens.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text('${itens[index].descricao}'),
            );
          }),
    );
  }
}
