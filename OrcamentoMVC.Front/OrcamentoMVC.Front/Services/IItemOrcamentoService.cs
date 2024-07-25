namespace OrcamentoMVC.Front.Services;

public interface IItemOrcamentoService
{
    Task<ServiceResponse<ItemOrcamento>> Create(ItemOrcamento itemOrcamento, string token);
    Task<ServiceResponse<ItemOrcamento>> Get(int id, string token);
    Task<ServiceResponse<bool>> Delete(int id, string token);
}
