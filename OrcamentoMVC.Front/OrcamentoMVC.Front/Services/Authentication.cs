﻿using System.Text;
using System.Text.Json;
using OrcamentoMVC.Front.Models;

namespace OrcamentoMVC.Front.Services;

public class Authentication : IAuthentication
{
    private readonly IHttpClientFactory _clientFactory;
    const string authAPIEndpoint = "/api/Account/SignIn/";
    private readonly JsonSerializerOptions _options;
    private TokenViewModel _userToken;


    public Authentication(IHttpClientFactory clientFactory)
    {
        _clientFactory = clientFactory;
        _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
    }

    public async Task<TokenViewModel> AuthenticateUser(UserViewModel userVM)
    {
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
            }
            else
            {
                return null;
            }
        }
        return _userToken;
    }
}