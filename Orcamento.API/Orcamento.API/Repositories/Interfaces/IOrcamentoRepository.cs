using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Models = Orcamento.API.Models;

namespace Orcamento.API.Repositories.Interfaces;

public interface IOrcamentoRepository : IRepository<Models.Orcamento>
{
    Task<Models.Orcamento> GetOrcamentoComItensAsync(int id);
}

