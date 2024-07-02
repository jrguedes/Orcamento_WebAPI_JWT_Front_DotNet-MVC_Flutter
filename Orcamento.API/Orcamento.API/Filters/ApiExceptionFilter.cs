using Microsoft.AspNetCore.Mvc.Filters;

namespace Orcamento.API.Filters;

public class ApiExceptionFilter : IExceptionFilter
{
    public void OnException(ExceptionContext context)
    {                        
        context.Result = new Microsoft.AspNetCore.Mvc.ObjectResult("Entidade não processável! Ocorreu um problema ao tratar sua solicitação: Status Code 422")
        {
            StatusCode = StatusCodes.Status422UnprocessableEntity,            
        };
    }
}
