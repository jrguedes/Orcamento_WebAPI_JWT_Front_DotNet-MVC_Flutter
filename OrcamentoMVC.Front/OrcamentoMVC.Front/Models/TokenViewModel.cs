namespace OrcamentoMVC.Front.Models;

public class TokenViewModel
{
    public bool Authenticated { get; set; }
    public DateTime Created { get; set; }
    public DateTime ExpirationDate { get; set; }
    public string? AccessToken { get; set; }
    public string? Message { get; set; }
    public string UserName { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
}
