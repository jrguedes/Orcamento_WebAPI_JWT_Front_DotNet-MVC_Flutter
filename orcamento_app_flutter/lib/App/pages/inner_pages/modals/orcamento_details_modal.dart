import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        child: Container(
          padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
          child: Column(children: [
            const SizedBox(height: 10),
            ElevatedButton(
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
            const SizedBox(height: 10),
            const Divider(
              thickness: 0,
            ),
            _buildListItensOrcamento(),
            const SizedBox(height: 15),
          ]),
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
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Container(
            height: 325,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(7),
                  height: 55,
                  width: double.infinity,
                  decoration: _buildInsideContainerBorderDecoration(),
                  child: AutoSizeText(
                    itens[index].descricao,
                    minFontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: double.infinity,
                  decoration: _buildInsideContainerBorderDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildText(label: 'Estabelecimento', description: itens[index].local),
                      const SizedBox(height: 5),
                      _buildText(label: 'Responsável', description: itens[index].responsavelOrcamento),
                      const SizedBox(height: 5),
                      _buildText(label: 'Telefone', description: itens[index].telefone),
                      const SizedBox(height: 5),
                      _buildText(
                          label: 'Valor', description: NumberFormat('###.0#', 'pt_BR').format(itens[index].valor)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    const FaIcon(FontAwesomeIcons.trash, color: Color.fromARGB(209, 156, 8, 8)),
                    CupertinoButton(
                      onPressed: () async {
                        await _controller.deleteOrcamento(itens[index]);
                        await _store.loadItensOrcamento(widget.orcamento.id);
                      },
                      child: const Text('Excluir'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 3),
        const Divider(thickness: 0, indent: 50, endIndent: 50),
        const SizedBox(height: 3),
      ],
    );
  }

  Widget _buildText({required String label, required String description, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        AutoSizeText(
          description,
          minFontSize: 14,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          maxLines: maxLines,
        ),
      ],
    );
  }

  BoxDecoration _buildInsideContainerBorderDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 0,
          color: Colors.white,
        ));
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
