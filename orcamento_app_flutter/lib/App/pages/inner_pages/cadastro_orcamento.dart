import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/data/constants/pages.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/expired_login_page.dart';
import 'package:provider/provider.dart';

import '../../controllers/bottom_bar/bottom_bar_controller.dart';
import '../../controllers/orcamento/orcamento_controller.dart';
import '../widgets/custom_text_form_field.dart';
import 'modals/modal_dialog.dart';
import 'modals/orcamento_details_modal.dart';

class CadastroOrcamento extends StatefulWidget {
  const CadastroOrcamento({super.key});

  @override
  State<CadastroOrcamento> createState() => _CadastroOrcamentoState();
}

class _CadastroOrcamentoState extends State<CadastroOrcamento> {
  final TextEditingController _orcamentoEdtController = TextEditingController(text: '');

  late final OrcamentoController _orcamentoController;
  late final BottomBarController _bottomBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orcamentoController = context.read();
    _bottomBar = context.read();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).textTheme.headlineMedium;
    return Container(
      padding: const EdgeInsets.only(top: 150, left: 15, right: 15),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Orçamento', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black54)),
            const SizedBox(height: 30),
            CustomTextFormField(
              labelText: 'O que você gostaria de orçar?',
              hintText: 'O que você gostaria de orçar?',
              controller: _orcamentoEdtController,
              keyboardType: TextInputType.text,
              icon: Icon(Icons.attach_money_outlined, color: Theme.of(context).hintColor),
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size(200, 40)),
                  onPressed: () async {
                    var orcamento = await _orcamentoController.saveOrcamento(_orcamentoEdtController.text);
                    if (!orcamento.validToken) {
                      return ExpiredLoginPage().show(context);
                    }
                    if (orcamento.value != null) {
                      await ModalDialog.show(
                        context: context,
                        title: 'Adicionar ao orçamento',
                        content: OrcamentoDetailsModal(orcamento: orcamento.value!),
                      );

                      _bottomBar.convexAppBarTap(LISTA_ORCAMENTOS);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
