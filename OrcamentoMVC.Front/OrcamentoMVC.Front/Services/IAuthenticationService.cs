using OrcamentoMVC.Front.Models;

namespace OrcamentoMVC.Front.Services;

public interface IAuthenticationService
{
    Task<TokenViewModel> AuthenticateUser(UserViewModel userVM);
}
