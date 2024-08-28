import 'package:orcamento_app_flutter/App/services/api/item_orcamento_api_service.dart';
import '../../models/item_orcamento_model.dart';

class ItemOrcamentoController {
  final ItemOrcamentoApiService service;

  ItemOrcamentoController(this.service);

  Future<void> saveItemOrcamento(int orcamentoId, String local, String telefone, String responsavelOrcamento,
      double valor, String descricao) async {
    ItemOrcamentoModel? itemOrcamento;

    itemOrcamento = ItemOrcamentoModel(
      id: 0,
      local: local,
      telefone: telefone,
      responsavelOrcamento: responsavelOrcamento,
      valor: valor,
      descricao: descricao,
      orcamentoId: orcamentoId,
    );

    var saveItemResponse = await service.postItemOrcamento(itemOrcamento);

    if (!saveItemResponse.validToken) {
      //remover pages privadas e mandar pra tela de login
    }
  }

  Future<bool> deleteOrcamento(ItemOrcamentoModel itemOrcamento) async {
    var deleteResponse = await service.deleteOrcamento(itemOrcamento);

    if (!deleteResponse.validToken) {
      //remover pages privadas e mandar pra tela de login
    }
    return deleteResponse.response;
  }
}
