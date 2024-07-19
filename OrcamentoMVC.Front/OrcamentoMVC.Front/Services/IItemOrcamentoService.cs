namespace OrcamentoMVC.Front.Services;

public interface IItemOrcamentoService
{
    Task<ItemOrcamento> Create(ItemOrcamento itemOrcamento, string token);
    Task<ItemOrcamento> Get(int id, string token);
    Task<bool> Delete(int id, string token);
}
