using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

namespace OrcamentoMVC.Front.Services;

public class ItemOrcamentoService : IItemOrcamentoService
{
    private readonly IHttpClientFactory _clientFactory;

    public ItemOrcamentoService(IHttpClientFactory clientFactory)
    {
        _clientFactory = clientFactory;
        _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
    }

    const string orcamentoAPIEndpoint = "/api/ItemOrcamento/";
    private readonly JsonSerializerOptions _options;
    public async Task<ServiceResponse<ItemOrcamento>> Create(ItemOrcamento itemOrcamentoVM, string token)
    {
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);

        var produto = JsonSerializer.Serialize(itemOrcamentoVM);
        StringContent content = new StringContent(produto, Encoding.UTF8, "application/json");

        using (var response = await client.PostAsync(orcamentoAPIEndpoint, content))
        {
            if (response.IsSuccessStatusCode)
            {
                var apiResponse = await response.Content.ReadAsStreamAsync();
                itemOrcamentoVM = await JsonSerializer
                             .DeserializeAsync<ItemOrcamento>
                             (apiResponse, _options);
            }
            return new(itemOrcamentoVM, response.StatusCode, response.IsSuccessStatusCode);
        }        
    }

    public async Task<ServiceResponse<ItemOrcamento>> Get(int id, string token)
    {
        ItemOrcamento item = new();
        var client = _clientFactory.CreateClient("OrcamentoAPI");
        PutTokenInAuthorizationHeader(token, client);
        using (var response = await client.GetAsync(orcamentoAPIEndpoint + id))
        {
            if (response.IsSuccessStatusCode)
            {
                var apiResponse = await response.Content.ReadAsStreamAsync();
                item = await JsonSerializer
                              .DeserializeAsync<ItemOrcamento>
                              (apiResponse, _options);

            }
            return new(item, response.StatusCode, response.IsSuccessStatusCode);
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

    private static void PutTokenInAuthorizationHeader(string token, HttpClient client)
    {
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
    }


}
