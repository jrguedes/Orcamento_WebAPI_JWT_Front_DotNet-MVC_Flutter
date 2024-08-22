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

    await service.postItemOrcamento(itemOrcamento);
  }

  Future<bool> deleteOrcamento(ItemOrcamentoModel itemOrcamento) async {
    var deleted = await service.deleteOrcamento(itemOrcamento);
    return deleted;
  }
}
