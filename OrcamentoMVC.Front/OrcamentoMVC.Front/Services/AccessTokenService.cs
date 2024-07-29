using System.Net;
using System.Net.Http.Headers;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;


namespace OrcamentoMVC.Front.Services;

public sealed class AccessTokenService : DefaultService, IAccessTokenService
{
    private readonly IHttpContextAccessor _httpContextAccessor;
    private readonly IHttpClientFactory _clientFactory;
    const string orcamentoAPIEndpoint = "/api/Account/Token/";
    private readonly JsonSerializerOptions _options;

    public AccessTokenService(IHttpContextAccessor httpContextAccessor, IHttpClientFactory clientFactory)
    {
        _httpContextAccessor = httpContextAccessor;
        _clientFactory = clientFactory;
        _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
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

    public async Task<bool> ValidateToken(string token)
    {
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);
        using (var response = await client.GetAsync(orcamentoAPIEndpoint))
        {
            if (response.IsSuccessStatusCode)
            {
                var apiResponse = await response.Content.ReadAsStreamAsync();
                _ = await JsonSerializer
                               .DeserializeAsync<bool>
                               (apiResponse, _options);
                return true;
            }
            return false;
        }
    }
}
