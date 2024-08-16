import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:provider/provider.dart';
import '../../controllers/bottom_bar/bottom_bar_controller.dart';
import '../../controllers/orcamento/orcamento_controller.dart';
import '../../stores/orcamento_store.dart';
import '../widgets/custom_text_form_field.dart';

class CadastroOrcamento extends StatefulWidget {
  final OrcamentoModel? orcamento;

  const CadastroOrcamento({super.key, this.orcamento});

  @override
  State<CadastroOrcamento> createState() => _CadastroOrcamentoState();
}

class _CadastroOrcamentoState extends State<CadastroOrcamento> {
  final TextEditingController _orcamentoEdtController = TextEditingController(text: '');

  late final OrcamentoController _orcamentoController;
  late final BottomBarController _bottomBar;
  late final OrcamentoStore _orcamentoStore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orcamentoController = context.read();
    _bottomBar = context.read();

    _orcamentoStore = context.read();

    if (widget.orcamento != null) {
      _orcamentoEdtController.text = widget.orcamento!.descricao;
    }
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
            Text('Orçamento', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 30),
            CustomTextFormField(
              labelText: 'O que você gostaria de orçar?',
              hintText: 'O que você gostaria de orçar?',
              controller: _orcamentoEdtController,
              icon: const Icon(Icons.attach_money_outlined),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                  onPressed: () async {
                    if (widget.orcamento != null) {
                      await _orcamentoController.updateOrcamento(widget.orcamento!, _orcamentoEdtController.text);
                      _bottomBar.convexAppBarTap(2);
                    } else {
                      await _orcamentoController.saveOrcamento(_orcamentoEdtController.text);
                      _bottomBar.convexAppBarTap(4);
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
