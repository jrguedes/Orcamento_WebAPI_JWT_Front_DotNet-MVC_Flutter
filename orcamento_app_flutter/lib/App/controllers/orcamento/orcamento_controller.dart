import 'package:flutter/cupertino.dart';
import 'package:orcamento_app_flutter/App/models/item_orcamento_model.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';
import 'package:orcamento_app_flutter/App/states/orcamentos_state.dart';

import '../../services/api/item_orcamento_api_service.dart';
import '../../states/generic_states/object_state.dart';

class OrcamentoController {
  final OrcamentosState orcamentosState = OrcamentosState();
  final OrcamentoAPIService _service = OrcamentoAPIService();
  final ItemOrcamentoApiService _itemService = ItemOrcamentoApiService();
  final ValueNotifier<ObjectState<OrcamentoModel?>> orcamentoState =
      ValueNotifier<ObjectState<OrcamentoModel?>>(InitialObjectState(null));
  OrcamentoModel? orcamentoModel;

  Future<void> getOrcamentos() async {
    var orcamentos = await _service.getOrcamentos();
    return;
  }

/*
  Future<void> saveOrcamento(String descricaoOrcamento) async {
    var orcamento = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());

    orcamentoState.value = LoadingObjectState();
    try {
      var orcamentoResult = await _service.postOrcamento(orcamento);
      if (orcamentoResult == null) {
        orcamentoState.value = ErrorObjectState('Usuário ou senha inválidos!');
      } else {
        orcamentoState.value = SuccessObjectState<OrcamentoModel?>(orcamentoResult);
      }
    } catch (e) {
      orcamentoState.value = ErrorObjectState('Há um problema de conexão com a API');
    }
  }
  */

  Future<void> saveOrcamento(String descricaoOrcamento) async {
    orcamentoModel = null;
    var orcamento = OrcamentoModel(id: 0, descricao: descricaoOrcamento, data: DateTime.now());
    orcamentoModel = await _service.postOrcamento(orcamento);
  }

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

      await _itemService.postItemOrcamento(itemOrcamento);
    }
  }
}
