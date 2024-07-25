namespace OrcamentoMVC.Front.Services;

public interface IOrcamentoService
{
    Task<ServiceResponse<IEnumerable<Orcamento>>> Get(string token);
    Task<ServiceResponse<OrcamentoItensViewModel>> Get(int id, string token);
    Task<ServiceResponse<Orcamento>> Create(Orcamento orcamento, string token);
    Task<ServiceResponse<bool>> Update(Orcamento orcamento, string token);
    Task<ServiceResponse<bool>> Delete(int id, string token);
}
