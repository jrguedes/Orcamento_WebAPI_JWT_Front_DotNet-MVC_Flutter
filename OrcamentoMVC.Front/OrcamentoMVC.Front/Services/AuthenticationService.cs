using OrcamentoMVC.Front.Models;
using System.Text;
using System.Text.Json;

namespace OrcamentoMVC.Front.Services;

public class AuthenticationService : IAuthenticationService
{
    private readonly IHttpClientFactory _clientFactory;
    const string endpointAPI = "/api/login/";
    private readonly JsonSerializerOptions _options;
    private TokenViewModel? userToken;

    public AuthenticationService(IHttpClientFactory clientFactory)
    {
        _clientFactory = clientFactory;
        _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
    }

    public async Task<TokenViewModel?> AuthenticateUser(UserViewModel usuarioVM)
    {
        var client = _clientFactory.CreateClient("AutenticaApi");
        var usuario = JsonSerializer.Serialize(usuarioVM);
        StringContent content = new StringContent(usuario, Encoding.UTF8, "application/json");

        using (var response = await client.PostAsync(endpointAPI, content))
        {
            if (!response.IsSuccessStatusCode)
            {
                return null;
            }

            var apiResponse = await response.Content.ReadAsStreamAsync();
            userToken = await JsonSerializer
                          .DeserializeAsync<TokenViewModel>
                          (apiResponse, _options);
        }
        return userToken;
    }
}
