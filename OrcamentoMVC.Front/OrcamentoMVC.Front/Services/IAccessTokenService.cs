namespace OrcamentoMVC.Front.Services;

public interface IAccessTokenService
{
    public string GetJwtTokenFromCookies();
    public void AddJwtTokenToCookies(string token);
    public void DeleteJwtTokenFromCookies();
    public Task<bool> ValidateToken(string token);
}
