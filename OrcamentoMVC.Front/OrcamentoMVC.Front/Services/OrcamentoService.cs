﻿
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

namespace OrcamentoMVC.Front.Services;

public sealed class OrcamentoService : DefaultService, IOrcamentoService
{
    private readonly IHttpClientFactory _clientFactory;
    const string orcamentoAPIEndpoint = "/api/Orcamentos/";
    private readonly JsonSerializerOptions _options;

    public OrcamentoService(IHttpClientFactory clientFactory)
    {
        _clientFactory = clientFactory;
        _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
    }

    public async Task<ServiceResponse<Orcamento>> Create(Orcamento orcamentoVM, string token)
    {
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);

        var produto = JsonSerializer.Serialize(orcamentoVM);
        StringContent content = new StringContent(produto, Encoding.UTF8, "application/json");

        using (var response = await client.PostAsync(orcamentoAPIEndpoint, content))
        {
            if (response.IsSuccessStatusCode)
            {
                var apiResponse = await response.Content.ReadAsStreamAsync();
                orcamentoVM = await JsonSerializer
                             .DeserializeAsync<Orcamento>
                             (apiResponse, _options);
            }
            return new(orcamentoVM, response.StatusCode, response.IsSuccessStatusCode);
        }

    }

    public async Task<ServiceResponse<bool>> Delete(int id, string token)
    {
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);

        using (var response = await client.DeleteAsync(orcamentoAPIEndpoint + id))
        {
            if (response.IsSuccessStatusCode)
            {
                return new(true, response.StatusCode, response.IsSuccessStatusCode);
            }
            return new(false, response.StatusCode, response.IsSuccessStatusCode);
        }
    }

    public async Task<ServiceResponse<IEnumerable<Orcamento>>> Get(string token)
    {
        IEnumerable<Orcamento> orcamentosVM = new List<Orcamento>();
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);
        using (var response = await client.GetAsync(orcamentoAPIEndpoint))
        {
            if (response.IsSuccessStatusCode)
            {
                var apiResponse = await response.Content.ReadAsStreamAsync();
                orcamentosVM = await JsonSerializer
                               .DeserializeAsync<IEnumerable<Orcamento>>
                               (apiResponse, _options);
            }
            return new(orcamentosVM, response.StatusCode, response.IsSuccessStatusCode);
        }
    }

    public async Task<ServiceResponse<OrcamentoItensViewModel>> Get(int id, string token)
    {
        OrcamentoItensViewModel orcamentoItensVM = new();
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);
        using (var response = await client.GetAsync(orcamentoAPIEndpoint + id))
        {
            if (response.IsSuccessStatusCode)
            {
                var apiResponse = await response.Content.ReadAsStreamAsync();
                orcamentoItensVM = await JsonSerializer
                              .DeserializeAsync<OrcamentoItensViewModel>
                              (apiResponse, _options);

            }
            return new(orcamentoItensVM, response.StatusCode, response.IsSuccessStatusCode);
        }
    }

    public async Task<ServiceResponse<bool>> Update(Orcamento orcamento, string token)
    {
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);

        using (var response = await client.PutAsJsonAsync(orcamentoAPIEndpoint, orcamento))
        {
            if (response.IsSuccessStatusCode)
            {
                return new(true, response.StatusCode, response.IsSuccessStatusCode);
            }
            else
            {
                return new(false, response.StatusCode, response.IsSuccessStatusCode);
            }
        }
    }

}
