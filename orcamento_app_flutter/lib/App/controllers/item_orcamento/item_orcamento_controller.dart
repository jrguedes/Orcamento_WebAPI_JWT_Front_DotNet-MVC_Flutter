import 'package:orcamento_app_flutter/App/services/api/item_orcamento_api_service.dart';

import '../../models/item_orcamento_model.dart';
import '../../models/orcamento_model.dart';

class ItemOrcamentoController {
  final ItemOrcamentoApiService service;
  OrcamentoModel? orcamentoModel;

  ItemOrcamentoController(this.service);

  Future<void> saveItemOrcamento(
      String estabelecimento, String telefone, String responsavel, double valor, String descricao) async {
    ItemOrcamentoModel? itemOrcamento;
    if (orcamentoModel != null) {
      itemOrcamento = ItemOrcamentoModel(
        id: 0,
        estabelecimento: estabelecimento,
        telefone: telefone,
        responsavel: responsavel,
        valor: valor,
        descricao: descricao,
        orcamentoId: orcamentoModel!.id,
      );

      await service.postItemOrcamento(itemOrcamento);
    }
  }
}
