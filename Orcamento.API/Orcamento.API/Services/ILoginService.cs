using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Orcamento.API.Models;

namespace Orcamento.API.Services;

public interface ILoginService
{
    Task<object> SignIn(Login login, CancellationToken cancellation);
}

