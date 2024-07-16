namespace OrcamentoMVC.Front;

public class ItemOrcamento
{
    public int Id { get; set; }
    public string Descricao { get; set; } = string.Empty;
    public string Local { get; set; } = string.Empty;
    public string Telefone { get; set; } = string.Empty;
    public string ResponsavelOrcamento { get; set; } = string.Empty;
    public decimal Valor { get; set; }

    /*
    {
      "descricao": "string",
      "orcamentoId": 0,
      "local": "string",
      "telefone": "string",
      "responsavelOrcamento": "string",
      "valor": 0
    }
    */
}
