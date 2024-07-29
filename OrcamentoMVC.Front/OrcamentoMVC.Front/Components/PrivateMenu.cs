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

    public async Task<IViewComponentResult> InvokeAsync()
    {        
        var token = _tokenService.GetJwtTokenFromCookies();
        var isValidToken = await _tokenService.ValidateToken(token);
        if (!isValidToken)
        {
            _tokenService.DeleteJwtTokenFromCookies();
        }
        return View(new AuthenticationViewModel(isValidToken));
    }
}
