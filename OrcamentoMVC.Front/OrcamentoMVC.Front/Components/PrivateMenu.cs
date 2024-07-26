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
        //TODO verificar se há token valido para o usuário e caso nao haja enviar como falso.
        //talvez seja necessario remover token caso receba como resposta CodState = 401
        return View(new AuthenticationViewModel(true));
    }
}
