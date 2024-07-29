using System.Net.Http.Headers;

namespace OrcamentoMVC.Front.Services;

public class DefaultService
{
    protected void PutTokenInAuthorizationHeader(string token, HttpClient client)
    {
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
    }
}
