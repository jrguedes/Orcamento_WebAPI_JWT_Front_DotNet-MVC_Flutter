import 'package:orcamento_app_flutter/App/services/api/item_orcamento_api_service.dart';
import '../../models/item_orcamento_model.dart';

class ItemOrcamentoController {
  final ItemOrcamentoApiService service;

  ItemOrcamentoController(this.service);

  Future<void> saveItemOrcamento(int orcamentoId, String estabelecimento, String telefone, String responsavelOrcamento,
      double valor, String descricao) async {
    ItemOrcamentoModel? itemOrcamento;

    itemOrcamento = ItemOrcamentoModel(
      id: 0,
      estabelecimento: estabelecimento,
      telefone: telefone,
      responsavelOrcamento: responsavelOrcamento,
      valor: valor,
      descricao: descricao,
      orcamentoId: orcamentoId,
    );

    await service.postItemOrcamento(itemOrcamento);
  }
}
