using OrcamentoMVC.Front.Models;

namespace OrcamentoMVC.Front.Services;

public interface IAuthentication
{
    Task<TokenViewModel> AuthenticateUser(UserViewModel userVM);
}
