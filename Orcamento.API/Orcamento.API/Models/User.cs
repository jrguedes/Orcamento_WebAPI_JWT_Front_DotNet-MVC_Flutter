using System.ComponentModel.DataAnnotations;

namespace Orcamento.API.Models;

public class User : ModelBase
{
    [Required]
    [StringLength(50)]
    public string Name { get; set; }

    [StringLength(30)]
    [Required(ErrorMessage = "Email obrigatorio")]
    public string Email { get; set; }

    [DataType(DataType.Password)]
    [Required(ErrorMessage = "Senha obrigatoria")]
    [StringLength(8, ErrorMessage = "Senha deve ter entre 4 and 8 caracteres", MinimumLength = 4)]
    public string Password { get; set; }
    private string _role;
    public string Role
    {
        get { return _role; }
        set { _role = value ?? "Funcionario"; }
    }
}

