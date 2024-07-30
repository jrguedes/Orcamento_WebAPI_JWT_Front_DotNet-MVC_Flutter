namespace OrcamentoMVC.Front.Models;

public class AuthenticationViewModel
{
    public bool UserAuthenticated { get; init; } = false;

    public AuthenticationViewModel(bool userAuthenticated = false)
    {
        UserAuthenticated = userAuthenticated;
    }
}
