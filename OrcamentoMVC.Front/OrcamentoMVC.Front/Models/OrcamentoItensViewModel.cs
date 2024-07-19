namespace OrcamentoMVC.Front;

public class OrcamentoItensViewModel
{

    public int Id { get; set; }
    public string Descricao { get; set; } = string.Empty;
    public DateTime Data { get; set; }
    public IEnumerable<ItemOrcamento> ItensOrcamento { get; set; }
    public OrcamentoItensViewModel() => ItensOrcamento = new List<ItemOrcamento>();
}
