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
    public async Task<ItemOrcamento> Create(ItemOrcamento itemOrcamentoVM, string token)
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
            else
            {
                return null;
            }
        }
        return itemOrcamentoVM;
    }

    public async Task<ItemOrcamento> Get(int id, string token)
    {
        ItemOrcamento item;
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
            else
            {
                return null;
            }
        }
        return item;
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

    private static void PutTokenInAuthorizationHeader(string token, HttpClient client)
    {
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
    }


}
