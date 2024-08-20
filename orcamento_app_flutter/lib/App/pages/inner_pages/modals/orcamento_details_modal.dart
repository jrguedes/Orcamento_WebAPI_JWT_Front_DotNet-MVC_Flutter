import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orcamento_app_flutter/App/controllers/item_orcamento/item_orcamento_controller.dart';
import 'package:orcamento_app_flutter/App/models/item_orcamento_model.dart';
import 'package:orcamento_app_flutter/App/pages/widgets/custom_cupertino_activity_indicator.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/list_state.dart';
import 'package:provider/provider.dart';

import '../../../models/orcamento_model.dart';
import '../../../stores/itens_orcamento_store.dart';
import 'add_item_orcamento_modal.dart';
import 'modal_dialog.dart';

class OrcamentoDetailsModal extends StatefulWidget {
  final OrcamentoModel orcamento;

  OrcamentoDetailsModal({Key? key, required this.orcamento}) : super(key: key);

  @override
  State<OrcamentoDetailsModal> createState() => _OrcamentoDetailsModalState();
}

class _OrcamentoDetailsModalState extends State<OrcamentoDetailsModal> {
  late final ItensOrcamentoStore _store;
  late final ItemOrcamentoController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _store = context.read();
    _controller = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _store.loadItensOrcamento(widget.orcamento.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.zero,
        height: size.height - 330,
        width: size.width - 30,
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
            child: Container(
              padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
              child: Column(children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: CupertinoButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Voltar'),
                  ),
                ),
                //Text('Adicionar Item de Orçamento', style: Theme.of(context).textTheme.headlineMedium),

                CupertinoButton.filled(
                  onPressed: () async {
                    await ModalDialog.show(
                      context: context,
                      title: 'Adicionar Item ao orçamento',
                      content: AddItemOrcamentoModal(orcamento: widget.orcamento),
                    );
                    await _store.loadItensOrcamento(widget.orcamento.id);
                  },
                  child: const Text('Adicionar item ao orçamento'),
                ),
                const SizedBox(height: 15),
                _buildListItensOrcamento(),
                const SizedBox(height: 15),
              ]),
            ),
          ),
        ));
  }

  Widget _buildListItensOrcamento() {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: _store,
          builder: (context, value, child) {
            if (value is LoadingListState) {
              return const CustomCupertinoActivityIndicator();
            }

            if (value is SuccessListState<ItemOrcamentoModel>) {
              return ListView.builder(
                  itemCount: value.list.length,
                  itemBuilder: (context, index) {
                    return _buildItemOrcamento(value.list, index);
                  });
            }

            if (value is ErrorListState<ItemOrcamentoModel>) {
              return _errorMessage(value.message);
            }
            return Container();
          }),
    );
  }

  Widget _buildItemOrcamento(List<ItemOrcamentoModel> itens, int index) {
    return Card(
      color: Colors.blue[100],
      elevation: 0,
      child: Container(
        height: 250,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                //border: BorderRadius.circular(5),
              ),
              child: AutoSizeText(
                itens[index].descricao,
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
            AutoSizeText(
              itens[index].estabelecimento,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            AutoSizeText(
              itens[index].responsavelOrcamento,
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
                  onPressed: () async {
                    await _controller.deleteOrcamento(itens[index]);
                    await _store.loadItensOrcamento(widget.orcamento.id);
                  },
                  child: const Text('Excluir'),
                ),
                const SizedBox(width: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _emptyMessage() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 350,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: const Text(
          'Que pena! \n\n Não há itens cadastrados',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _errorMessage(String message) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 350,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(221, 236, 82, 82),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
