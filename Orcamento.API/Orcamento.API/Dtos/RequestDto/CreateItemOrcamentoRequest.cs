namespace Orcamento.API.Dtos.RequestDto;

public class CreateItemOrcamentoRequest
{    
    public string Descricao { get; set; }
    public int OrcamentoId { get; set; }    
    public string Local { get; set; }
    public string Telefone { get; set; }
    public string ResponsavelOrcamento { get; set; }
    public decimal Valor { get; set; }
}
