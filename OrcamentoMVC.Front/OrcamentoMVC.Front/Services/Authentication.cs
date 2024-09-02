using System.Text;
using System.Text.Json;
using OrcamentoMVC.Front.Models;

namespace OrcamentoMVC.Front.Services;

public sealed class Authentication : IAuthentication
{
    private readonly IHttpClientFactory _clientFactory;
    const string authAPIEndpoint = "/api/Account/SignIn/";
    private readonly JsonSerializerOptions _options;
    private TokenViewModel? _userToken;


    public Authentication(IHttpClientFactory clientFactory)
    {
        _clientFactory = clientFactory;
        _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
    }


    public async Task<ServiceResponse<TokenViewModel?>> AuthenticateUser(UserViewModel userVM)
    {
        _userToken = null;
        ServiceResponse<TokenViewModel?> result;
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        var usuario = JsonSerializer.Serialize(userVM);
        StringContent content = new StringContent(usuario, Encoding.UTF8, "application/json");

        using (var response = await client.PostAsync(authAPIEndpoint, content))
        {
            if (response.IsSuccessStatusCode)
            {
                var apiResponse = await response.Content.ReadAsStreamAsync();
                _userToken = await JsonSerializer
                              .DeserializeAsync<TokenViewModel>
                              (apiResponse, _options);
                result = new(response: _userToken, statusCode: response.StatusCode, isSuccessStatusCode: true);
            }
            else
            {
                result = new(response: null, statusCode: response.StatusCode, isSuccessStatusCode: false);                
            }
        }
        return result;
    }
}
