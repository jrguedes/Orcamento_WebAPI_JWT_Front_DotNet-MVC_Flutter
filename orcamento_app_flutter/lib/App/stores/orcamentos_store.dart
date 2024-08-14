import 'package:flutter/foundation.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';
import '../states/generic_states/list_state.dart';

class OrcamentosStore extends ValueNotifier<ListState<OrcamentoModel>> {
  final OrcamentoApiService service;
  OrcamentosStore(this.service) : super(InitialListState<OrcamentoModel>());

  Future<void> loadOrcamentos() async {
    value = LoadingListState();
    try {
      final list = await service.getOrcamentos();
      value = SuccessListState<OrcamentoModel>(list);
    } catch (e) {
      value = ErrorListState('Há um problema de conexão com a API');
    }
  }
}
