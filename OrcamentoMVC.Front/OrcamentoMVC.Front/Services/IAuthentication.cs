using OrcamentoMVC.Front.Models;

namespace OrcamentoMVC.Front.Services;

public interface IAuthentication
{
    Task<ServiceResponse<TokenViewModel?>> AuthenticateUser(UserViewModel userVM);
}
