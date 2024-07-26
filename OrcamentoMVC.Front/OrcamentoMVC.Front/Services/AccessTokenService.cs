using System.Net;
using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;


namespace OrcamentoMVC.Front.Services;

public sealed class AccessTokenService : IAccessTokenService
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public AccessTokenService(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public string GetJwtTokenFromCookies()
    {
        string token = string.Empty;
        if (_httpContextAccessor.HttpContext.Request.Cookies.ContainsKey("X-Access-Token"))
            token = _httpContextAccessor.HttpContext.Request.Cookies["X-Access-Token"].ToString();
        return token;
    }

    public void AddJwtTokenToCookies(string token)
    {
        _httpContextAccessor.HttpContext.Response.Cookies.Append("X-Access-Token", token, new CookieOptions()
        {
            Secure = true,
            HttpOnly = true,
            SameSite = SameSiteMode.Strict
        });
    }

    public void DeleteJwtTokenFromCookies()
    {
        _httpContextAccessor.HttpContext.Response.Cookies.Delete("X-Access-Token");
    }
}
