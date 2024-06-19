using Orcamento.API.Dtos.RequestDto;

namespace Orcamento.API.Dtos.ResponseDto;

public class ItemOrcamentoResponse
{
    public int Id { get; set; }    
    public string Descricao { get; set; }
    public int OrcamentoId { get; set; }    
    public string Local { get; set; }
    public string Telefone { get; set; }
    public string ResponsavelOrcamento { get; set; }
    public decimal Valor { get; set; }
}
