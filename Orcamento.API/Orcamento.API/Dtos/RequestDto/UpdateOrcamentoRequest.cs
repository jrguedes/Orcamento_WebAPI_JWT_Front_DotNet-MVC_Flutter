namespace Orcamento.API.Dtos.RequestDto;

public class UpdateOrcamentoRequest
{
    public int Id { get; set; }
    public string Descricao { get; set; }
    public DateTime Data { get; set; }
}
