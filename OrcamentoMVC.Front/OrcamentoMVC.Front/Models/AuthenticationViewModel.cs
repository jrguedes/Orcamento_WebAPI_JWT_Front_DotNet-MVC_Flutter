namespace OrcamentoMVC.Front.Models;

public class AuthenticationViewModel
{
    public bool UserHasPermission { get; init; }

    public AuthenticationViewModel(bool userHasPermission)
    {
        UserHasPermission = userHasPermission;
    }
}
