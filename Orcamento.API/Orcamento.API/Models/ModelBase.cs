using System.ComponentModel.DataAnnotations;

namespace Orcamento.API.Models;

public class ModelBase
{
    [Key]
    public int Id { get; set; }
    [Required]
    [StringLength(100)]
    public string Descricao { get; set; }
}

