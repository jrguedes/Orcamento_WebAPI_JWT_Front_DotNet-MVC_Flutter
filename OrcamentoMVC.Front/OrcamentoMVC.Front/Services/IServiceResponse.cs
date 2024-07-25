using System.Net;

namespace OrcamentoMVC.Front.Services;

public interface IServiceResponse
{
    public HttpStatusCode StatusCode { get; init; }
    public bool IsSuccessStatusCode { get; init; }
}
