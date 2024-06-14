using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Orcamento.API.Models;

public class ItemOrcamento : ModelBase
{
    public int OrcamentoId { get; set; }
    public Orcamento Orcamento { get; set; }

    [StringLength(100)]
    public string Local { get; set; }
    [StringLength(16)]
    public string Telefone { get; set; }
    [StringLength(30)]
    public string ResponsavelOrcamento { get; set; }
    [Column(TypeName = "decimal(10,2)")]
    public decimal Valor { get; set; }
}

