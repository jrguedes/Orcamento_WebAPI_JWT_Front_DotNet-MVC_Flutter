namespace OrcamentoMVC.Front;

public class OrcamentoViewModel
{
    public int OrcamentoId { get; set; }
    public string DescricaoOrcamento { get; set; } = string.Empty;
    public ItemOrcamento ItemOrcamento { get; set; } = new ItemOrcamento();
}
