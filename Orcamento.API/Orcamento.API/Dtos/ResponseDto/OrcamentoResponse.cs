using System.Text.Json.Serialization;

namespace Orcamento.API.Dtos.ResponseDto;

public class OrcamentoResponse
{
    public int Id { get; set; }
    public string Descricao { get; set; }
    public DateTime Data { get; set; }
    
    [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
    public IEnumerable<ItemOrcamentoResponse> ItensOrcamento { get; set; }

}
