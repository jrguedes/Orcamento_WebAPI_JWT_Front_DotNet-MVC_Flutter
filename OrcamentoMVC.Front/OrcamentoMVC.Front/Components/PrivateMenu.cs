using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Models;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;

public class PrivateMenu : ViewComponent
{
    private readonly IAccessTokenService _tokenService;

    public PrivateMenu(IAccessTokenService tokenService)
    {
        _tokenService = tokenService;
    }

    public IViewComponentResult Invoke()
    {        
        var token = _tokenService.GetJwtTokenFromCookies();
        _tokenService.ValidateToken(token);
        Task.Run(() => task);
        return View(new AuthenticationViewModel(isValidToken));
    }
}
