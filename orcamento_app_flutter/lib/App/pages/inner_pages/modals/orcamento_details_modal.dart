import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                AutoSizeText(
                  orcamento.descricao,
                  style: Theme.of(context).textTheme.headlineSmall,
                  minFontSize: 23,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 30),

                CupertinoButton.filled(
                  onPressed: () async {
                    //await _orcamentoController.updateOrcamento(orcamento, _orcamentoEdtController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Adicionar item ao orçamento'),
                ),
                const SizedBox(height: 15),
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
            return _buildItemOrcamento(itens, index);
          }),
    );
  }

  Widget _buildItemOrcamento(List<ItemOrcamentoModel> itens, int index) {
    return Card(
      color: Colors.blue[100],
      elevation: 0,
      child: Container(
        height: 210,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Container(
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                itens[index].descricao,
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              AutoSizeText(
                itens[index].estabelecimento,
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              AutoSizeText(
                itens[index].responsavel,
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              AutoSizeText(
                itens[index].telefone,
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              AutoSizeText(
                NumberFormat('###.0#', 'pt_BR').format(itens[index].valor),
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  const Icon(Icons.delete_outline_outlined, color: Colors.redAccent),
                  CupertinoButton(
                    onPressed: () async {},
                    child: const Text('Excluir'),
                  ),
                  const SizedBox(width: 5),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
