import 'package:flutter/foundation.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/orcamento_service.dart';
import 'generic_states/list_state.dart';

class LancamentosState extends ValueNotifier<ListState<OrcamentoModel>> {
  late final OrcamentoService _service = OrcamentoService();
  LancamentosState() : super(InitialListState<OrcamentoModel>());

  Future<void> loadDatasLancamento(int ano, int mes) async {
    value = LoadingListState();
    try {
      final list = await _service.getOrcamentos();
      value = SuccessListState<OrcamentoModel>(list);
    } catch (e) {
      value = ErrorListState('Há um problema de conexão com a API');
    }
  }
}
