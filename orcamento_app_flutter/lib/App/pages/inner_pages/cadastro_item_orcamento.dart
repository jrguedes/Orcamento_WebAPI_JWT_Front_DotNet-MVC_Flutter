import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/home/home_controller.dart';
import '../../services/service_manager.dart';
import '../widgets/custom_text_form_field.dart';

class CadastroItemOrcamento extends StatelessWidget {
  CadastroItemOrcamento({super.key});
  final HomeController _homeController = GetIt.I.get<ServiceManager>().homeController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 150, left: 15, right: 15),
      child: Column(
        children: [
          Text('Adicionar Item de Orcamento', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 30),
          const CustomTextFormField(labelText: 'Estabelecimento', hintText: 'Estabelecimento', icon: Icon(Icons.store)),
          const CustomTextFormField(labelText: 'Telefone', hintText: 'Telefone', icon: Icon(Icons.phone)),
          const CustomTextFormField(
              labelText: 'Responsável', hintText: 'Responsável', icon: Icon(Icons.co_present_rounded)),
          const CustomTextFormField(
              labelText: 'Descrição', hintText: 'Descrição', icon: Icon(Icons.description_outlined)),
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
