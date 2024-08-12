import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/home/home_controller.dart';
import '../../services/service_manager.dart';
import '../widgets/custom_text_form_field.dart';

class CadastroItemOrcamento extends StatelessWidget {
  CadastroItemOrcamento({super.key});
  final HomeController _homeController = GetIt.I.get<ServiceManager>().homeController;
  final TextEditingController _estabelecimentoEdtController = TextEditingController(text: '');
  final TextEditingController _telefoneEdtController = TextEditingController(text: '');
  final TextEditingController _responsavelEdtController = TextEditingController(text: '');
  final TextEditingController _descricaoEdtController = TextEditingController(text: '');
  final TextEditingController _valorEdtController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 150, left: 15, right: 15),
      child: Column(
        children: [
          Text('Adicionar Item de Orçamento', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: 'Estabelecimento',
            hintText: 'Estabelecimento',
            controller: _estabelecimentoEdtController,
            icon: const Icon(Icons.store),
          ),
          CustomTextFormField(
            labelText: 'Telefone',
            hintText: 'Telefone',
            controller: _telefoneEdtController,
            icon: const Icon(Icons.phone),
          ),
          CustomTextFormField(
            labelText: 'Responsável',
            hintText: 'Responsável',
            controller: _responsavelEdtController,
            icon: const Icon(Icons.co_present_rounded),
          ),
          CustomTextFormField(
            labelText: 'Valor',
            hintText: 'Valor',
            controller: _valorEdtController,
            icon: const Icon(Icons.attach_money_outlined),
          ),
          CustomTextFormField(
            labelText: 'Descrição',
            hintText: 'Descrição',
            controller: _descricaoEdtController,
            icon: const Icon(Icons.description_outlined),
          ),
          const SizedBox(height: 30),
          CupertinoButton.filled(
            child: const Text('Adicionar'),
            onPressed: () => _homeController.convexAppBarTap(3),
          ),
        ],
      ),
    );
  }
}
