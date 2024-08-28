import 'package:flutter/cupertino.dart';
import 'package:orcamento_app_flutter/App/models/item_orcamento_model.dart';

import '../services/api/item_orcamento_api_service.dart';
import '../states/generic_states/list_state.dart';

class ItensOrcamentoStore extends ValueNotifier<ListState<ItemOrcamentoModel>> {
  final ItemOrcamentoApiService service;
  ItensOrcamentoStore(this.service) : super(InitialListState<ItemOrcamentoModel>());

  Future<void> loadItensOrcamento(int orcamentoId) async {
    value = LoadingListState();
    try {
      final listResponse = await service.getItensOrcamento(orcamentoId);

      if (listResponse.validToken) {
        value = SuccessListState<ItemOrcamentoModel>(listResponse.response);
      } else {
        value = UnauthorizedListState('Tempo de login expirado \n Necessário logar novamente');
      }
    } catch (e) {
      value = ErrorListState('Há um problema de conexão com a API');
    }
  }
}
