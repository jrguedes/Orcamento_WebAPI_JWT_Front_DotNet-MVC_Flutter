using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Models;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;

public class AccountController : Controller
{
    private readonly IAccessTokenService _tokenService;
    private readonly IAuthentication _authenticationService;

    public AccountController(IAuthentication authenticationService, IAccessTokenService tokenService)
    {
        _tokenService = tokenService;
        _authenticationService = authenticationService;
    }

    [HttpGet]
    public ActionResult Login()
    {
        return View();
    }

    [HttpPost]
    public async Task<ActionResult> Login(UserViewModel userVM)
    {
        if (!ModelState.IsValid)
        {
            ModelState.AddModelError(string.Empty, "Login inválido!");
            return View(userVM);
        }

        var result = await _authenticationService.AuthenticateUser(userVM);


        if (result is null)
        {
            ModelState.AddModelError(string.Empty, "Login inválido!");
            return View(userVM);
        }

        _tokenService.AddJwtTokenToCookies(result.AccessToken);

        return Redirect("/");
    }

    public async Task<ActionResult> Logout()
    {
        _tokenService.DeleteJwtTokenFromCookies();
        return Redirect("/");
    }
}
