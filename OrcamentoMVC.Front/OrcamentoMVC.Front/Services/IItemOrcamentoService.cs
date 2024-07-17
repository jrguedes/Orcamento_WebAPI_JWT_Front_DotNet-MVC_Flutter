namespace OrcamentoMVC.Front.Services;

public interface IItemOrcamentoService
{
    Task<ItemOrcamento> Create(ItemOrcamento itemOrcamento, string token);
}
