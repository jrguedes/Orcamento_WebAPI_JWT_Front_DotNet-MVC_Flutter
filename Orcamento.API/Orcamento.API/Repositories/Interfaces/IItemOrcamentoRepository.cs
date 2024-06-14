using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Orcamento.API.Models;

namespace Orcamento.API.Repositories.Interfaces;

public interface IItemOrcamentoRepository : IRepository<ItemOrcamento>
{
    Task<IEnumerable<ItemOrcamento>> GetItensByOrcamentoAsync(int orcamentoId);
}

