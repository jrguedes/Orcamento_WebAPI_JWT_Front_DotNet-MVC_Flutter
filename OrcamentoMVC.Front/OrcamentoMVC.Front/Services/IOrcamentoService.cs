namespace OrcamentoMVC.Front.Services;

public interface IOrcamentoService
{
    Task<IEnumerable<Orcamento>> Get(string token);
    Task<Orcamento> Get(int id, string token);
    Task<Orcamento> Create(Orcamento orcamento, string token);
    Task<bool> Update(int id, Orcamento orcamento, string token);
    Task<bool> Delete(int id, string token);
}
