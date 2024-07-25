using System.Net;

namespace OrcamentoMVC.Front.Services;

public class ServiceResponse<T>(T response, HttpStatusCode statusCode, bool isSuccessStatusCode) : IServiceResponse
{
    public HttpStatusCode StatusCode { get; init; } = statusCode;
    public bool IsSuccessStatusCode { get; init; } = isSuccessStatusCode;
    public T Response { get; init; } = response;
}
