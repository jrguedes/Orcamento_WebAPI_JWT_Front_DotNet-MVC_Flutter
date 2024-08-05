import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orcamento_app_flutter/App/controllers/orcamento/orcamento_controller.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import '../../services/service_manager.dart';
import '../../states/generic_states/list_state.dart';

class OrcamentosPage extends StatefulWidget {
  const OrcamentosPage({Key? key}) : super(key: key);

  @override
  State<OrcamentosPage> createState() => _OrcamentosPageState();
}

class _OrcamentosPageState extends State<OrcamentosPage> {
  late final OrcamentoController _orcamentoController = GetIt.I.get<ServiceManager>().orcamentoController;

  @override
  void initState() {
    super.initState();
    _orcamentoController.orcamentosState.loadOrcamentos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  child: TextButton(
                    onPressed: () => {}, //_showYearBottomSheet,
                    child: const Text(
                      'Botao',
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
                    valueListenable: _orcamentoController.orcamentosState,
                    builder: (context, value, child) {
                      if (value is LoadingListState) {
                        return const Center(child: CircularProgressIndicator());
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
      ),
    );
  }

  ExpansionPanelList _buildExpansionPanelList(SuccessListState<OrcamentoModel> value) {
    return ExpansionPanelList(
      elevation: 3,
      expansionCallback: (index, isExpanded) {
        /*
        setState(() {
          value.list[index].isExpanded = !isExpanded;
        });
        */
      },
      animationDuration: const Duration(milliseconds: 600),
      children: value.list
          .map(
            (item) => ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Theme.of(context)
                    .dialogBackgroundColor, //item.isExpanded ? Theme.of(context).dialogBackgroundColor : Colors.white,
                headerBuilder: (_, isExpanded) => Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            child: Text(item.descricao,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600, //item.isExpanded ? FontWeight.w900 : FontWeight.w600,
                                  color: Colors.black87, //item.isExpanded ? Colors.black87 : Colors.black87),
                                ))),
                      ],
                    ),
                body: _buildCardBody(item),
                isExpanded: true //item.isExpanded,
                ),
          )
          .toList(),
    );
  }

  Widget _buildCardBody(OrcamentoModel item) {
    return Card(
      elevation: 0,
      child: Container(
          /*
        height: item.lancamentos.length * 60,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item.lancamentos.length,
          itemBuilder: (context, index) => Container(
            height: 50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.lancamentos[index].descricao,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.lancamentos[index].pessoa),
              ],
            ),
          ),
        ),*/
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