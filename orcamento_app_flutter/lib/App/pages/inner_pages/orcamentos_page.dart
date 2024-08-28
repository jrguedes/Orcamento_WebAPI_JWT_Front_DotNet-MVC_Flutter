import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:orcamento_app_flutter/App/controllers/orcamento/orcamento_controller.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/expired_login_page.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/modals/modal_dialog.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/modals/orcamento_details_modal.dart';
import 'package:orcamento_app_flutter/App/stores/orcamentos_store.dart';
import 'package:orcamento_app_flutter/App/stores/signin_store.dart';
import 'package:provider/provider.dart';

import '../../states/generic_states/list_state.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/custom_cupertino_activity_indicator.dart';
import 'modals/update_orcamento_modal.dart';

class OrcamentosPage extends StatefulWidget {
  const OrcamentosPage({Key? key}) : super(key: key);

  @override
  State<OrcamentosPage> createState() => _OrcamentosPageState();
}

class _OrcamentosPageState extends State<OrcamentosPage> {
  late final OrcamentosStore _orcamentosStore;
  late final SignInStore _signInStore;
  late final OrcamentoController _controller;

  @override
  void initState() {
    super.initState();
    _signInStore = context.read();
    _orcamentosStore = context.read();
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 4),
                  color: Theme.of(context).hintColor,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => {print('Pressed')},
                    child: Text(
                      'Orçamentos',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30, color: Theme.of(context).dialogBackgroundColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
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

                      if (value is ErrorListState<OrcamentoModel>) {
                        return _errorMessage(value.message);
                      }

                      if (value is UnauthorizedListState<OrcamentoModel>) {
                        return ExpiredLoginPage();
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
          ),
        ],
      ),
    );
  }

  ExpansionPanelList _buildExpansionPanelList(SuccessListState<OrcamentoModel> value) {
    return ExpansionPanelList(
      key: const PageStorageKey<String>('orcamentoListKey'),
      elevation: 0,
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
                      child: AutoSizeText(
                        item.descricao,
                        minFontSize: 17,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: item.isExpanded ? FontWeight.w600 : FontWeight.w900,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      )),
                ],
              ),
              body: Column(
                children: [
                  _buildCardBody(item),
                  const SizedBox(height: 10),
                ],
              ),
              isExpanded: item.isExpanded,
            ),
          )
          .toList(),
    );
  }

  Widget _buildCardBody(OrcamentoModel item) {
    var size = MediaQuery.sizeOf(context);
    double iconSize = size.width < 430 ? 15 : 24;
    return Card(
      child: Container(
        height: 170,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Container(
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                item.descricao,
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                maxLines: 2,
              ),
              Text(
                '${DateFormat.yMMMMEEEEd('pt_BR').format(item.data)} às ${DateFormat.Hm('pt_BR').format(item.data)}',
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.pen, color: Colors.black87, size: iconSize),
                  CupertinoButton(
                    onPressed: () async {
                      await ModalDialog.show(
                        context: context,
                        title: 'Editar',
                        content: UpdateOrcamentoModal(orcamento: item),
                      );
                      await _orcamentosStore.loadOrcamentos();
                    },
                    child: const Text('Editar'),
                  ),
                  FaIcon(FontAwesomeIcons.trash, color: const Color.fromARGB(209, 156, 8, 8), size: iconSize),
                  CupertinoButton(
                    onPressed: () async {
                      await ConfirmationDialog.show(
                        context: context,
                        title: 'Confirmação',
                        description: 'Tem certeza que deseja excluir?',
                        okPress: () async {
                          await _controller.deleteOrcamento(item);
                          await _orcamentosStore.loadOrcamentos();
                        },
                        cancelPress: () {},
                      );
                    },
                    child: const Text('Excluir'),
                  ),
                  FaIcon(FontAwesomeIcons.newspaper, color: Colors.deepPurpleAccent, size: iconSize),
                  CupertinoButton(
                    onPressed: () async {
                      await ModalDialog.show(
                        context: context,
                        title: 'Adicionar ao orçamento',
                        content: OrcamentoDetailsModal(orcamento: item),
                      );
                    },
                    child: const Text('Detalhes'),
                  ),
                ],
              ),
            ],
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
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
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
          'Que pena! \n\n Não há orçamentos cadastrados',
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
