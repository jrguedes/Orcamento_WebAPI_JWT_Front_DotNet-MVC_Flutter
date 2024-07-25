namespace OrcamentoMVC.Front.Services;

public interface IOrcamentoService
{
    Task<ServiceResponse<IEnumerable<Orcamento>>> Get(string token);
    Task<OrcamentoItensViewModel> Get(int id, string token);
    Task<Orcamento> Create(Orcamento orcamento, string token);
    Task<bool> Update(Orcamento orcamento, string token);
    Task<bool> Delete(int id, string token);
}
