
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

namespace OrcamentoMVC.Front.Services;

public class OrcamentoService : IOrcamentoService
{
    private readonly IHttpClientFactory _clientFactory;
    const string orcamentoAPIEndpoint = "/api/Orcamento/";
    private readonly JsonSerializerOptions _options;

    public OrcamentoService(IHttpClientFactory clientFactory)
    {
        _clientFactory = clientFactory;
        _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
    }

    public async Task<Orcamento> Create(Orcamento orcamentoVM, string token)
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
            else
            {
                return null;
            }
        }
        return orcamentoVM;
    }

    public async Task<bool> Delete(int id, string token)
    {
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);

        using (var response = await client.DeleteAsync(orcamentoAPIEndpoint + id))
        {
            if (response.IsSuccessStatusCode)
            {
                return true;
            }
        }
        return false;
    }

    public async Task<IEnumerable<Orcamento>> Get(string token)
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
            else
            {
                return null;
            }
        }
        return orcamentosVM;
    }

    public async Task<OrcamentoItensViewModel> Get(int id, string token)
    {
        OrcamentoItensViewModel orcamentoItensVM;
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
            else
            {
                return null;
            }
        }
        return orcamentoItensVM;
    }

    public async Task<bool> Update(int id, Orcamento orcamentoVM, string token)
    {
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);

        using (var response = await client.PutAsJsonAsync(orcamentoAPIEndpoint, orcamentoVM))
        {
            if (response.IsSuccessStatusCode)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    private static void PutTokenInAuthorizationHeader(string token, HttpClient client)
    {
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
    }
}
