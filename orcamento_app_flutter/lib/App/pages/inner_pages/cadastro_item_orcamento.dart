import 'package:flutter/foundation.dart';
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
      padding: EdgeInsets.only(top: 150),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextFormField(labelText: 'Item de orçamento', hintText: 'Item de orçamento'),
              Container(
                padding: const EdgeInsets.only(top: 5),
                //width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Adicionar'),
                  onPressed: () => _homeController.convexAppBarTap(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
