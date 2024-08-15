import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orcamento_app_flutter/App/controllers/account/account_controller.dart';
import 'package:orcamento_app_flutter/App/controllers/orcamento/orcamento_controller.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/stores/orcamentos_store.dart';
import 'package:provider/provider.dart';
import '../../services/service_manager.dart';
import '../../states/generic_states/list_state.dart';
import '../widgets/custom_cupertino_activity_indicator.dart';

class OrcamentosPage extends StatefulWidget {
  const OrcamentosPage({Key? key}) : super(key: key);

  @override
  State<OrcamentosPage> createState() => _OrcamentosPageState();
}

class _OrcamentosPageState extends State<OrcamentosPage> {
  late final OrcamentosStore _orcamentosStore;
  late final OrcamentoController _controller;

  @override
  void initState() {
    super.initState();
    _orcamentosStore = context.read<OrcamentosStore>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _orcamentosStore.loadOrcamentos();
      _controller = context.read();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                child: TextButton(
                  onPressed: () => {}, //_showYearBottomSheet,
                  child: const Text(
                    'BT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black38),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 4),
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => {print('Pressed')}, //_showMonthBottomSheet,
                    child: Text(
                      'Mes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Theme.of(context).dialogBackgroundColor /*backgroundColor*/),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: _orcamentosStore,
                  builder: (context, value, child) {
                    if (value is LoadingListState) {
                      return const Center(
                          child: CustomCupertinoActivityIndicator(
                        color: CupertinoColors.activeOrange,
                        radius: 20,
                      ));
                    }

                    if (value is ErrorListState) {
                      return const Center(
                        child: Text(
                          'Erro', //value.message,
                          //style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      );
                    }

                    if (value is SuccessListState<OrcamentoModel>) {
                      if (value.list.isEmpty) {
                        return _emptyMessage();
                      }
                      return _buildExpansionPanelList(value);
                    }

                    return Container();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  ExpansionPanelList _buildExpansionPanelList(SuccessListState<OrcamentoModel> value) {
    return ExpansionPanelList(
      elevation: 3,
      expansionCallback: (index, isExpanded) {
        setState(() {
          value.list[index].isExpanded = isExpanded;
        });
      },
      animationDuration: const Duration(milliseconds: 600),
      children: value.list
          .map(
            (item) => ExpansionPanel(
              canTapOnHeader: true,
              backgroundColor: item.isExpanded ? Theme.of(context).dialogBackgroundColor : Colors.white,
              headerBuilder: (_, isExpanded) => Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text(
                        item.descricao,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: item.isExpanded ? FontWeight.w900 : FontWeight.w600,
                            color: item.isExpanded ? Colors.black87 : Colors.black87),
                      )),
                ],
              ),
              body: _buildCardBody(item),
              isExpanded: item.isExpanded,
            ),
          )
          .toList(),
    );
  }

  Widget _buildCardBody(OrcamentoModel item) {
    return Card(
      color: Colors.blue[100],
      elevation: 0,
      child: Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Container(
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.descricao,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${DateFormat.yMMMMEEEEd('pt_BR').format(item.data)} às ${DateFormat.Hm('pt_BR').format(item.data)}',
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit, color: Colors.black87),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Text('Editar'),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.delete_outline_outlined, color: Colors.redAccent),
                  CupertinoButton(
                    onPressed: () async {
                      await _controller.deleteOrcamento(item);
                      await _orcamentosStore.loadOrcamentos();
                    },
                    child: const Text('Excluir'),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.newspaper, color: Colors.deepPurpleAccent),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Text('Detalhes'),
                  ),
                ],
              )
            ],
          ),
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
          'Que pena! \n\n Não há orçamentos cadastrados para este período',
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
}
