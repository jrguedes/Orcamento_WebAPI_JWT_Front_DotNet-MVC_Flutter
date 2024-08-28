import 'package:flutter/foundation.dart';
import 'package:orcamento_app_flutter/App/models/orcamento_model.dart';
import 'package:orcamento_app_flutter/App/services/api/orcamento_api_service.dart';
import '../services/exceptions/not_found_exception.dart';
import '../states/generic_states/list_state.dart';

class OrcamentosStore extends ValueNotifier<ListState<OrcamentoModel>> {
  final OrcamentoApiService service;
  OrcamentosStore(this.service) : super(InitialListState<OrcamentoModel>());

  Future<void> loadOrcamentos() async {
    value = LoadingListState();
    try {
      final listResponse = await service.getOrcamentos();

      if (listResponse.validToken) {
        value = SuccessListState<OrcamentoModel>(listResponse.response);
      } else {
        value = UnauthorizedListState('Tempo de login expirado \n Necessário logar novamente');
      }
    } on NotFoundException catch (e) {
      value = ErrorListState(e.message);
    } catch (e) {
      value = ErrorListState('Há um problema de conexão com a API');
    }
  }
}
