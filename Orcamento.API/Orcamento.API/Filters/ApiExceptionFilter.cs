using Microsoft.AspNetCore.Mvc.Filters;

namespace Orcamento.API.Filters;

public class ApiExceptionFilter : IExceptionFilter
{
    public void OnException(ExceptionContext context)
    {                        
        context.Result = new Microsoft.AspNetCore.Mvc.ObjectResult("Ocorreu um problema ao tratar sua solicitação: Status Code 400")
        {
            StatusCode = StatusCodes.Status400BadRequest,
        };
    }
}
