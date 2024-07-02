using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Orcamento.API.AppDbContextSQLite;
using Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;

namespace Orcamento.API.Repositories;

public class ItemOrcamentoRepository : RepositoryBase<ItemOrcamento>, IItemOrcamentoRepository
{
    public ItemOrcamentoRepository(AppDbContext context) : base(context)
    {
        _dataset = _context.Set<ItemOrcamento>();
    }

    public async Task<IEnumerable<ItemOrcamento>> GetItensByOrcamentoAsync(int orcamentoId, CancellationToken cancellation)
    {
        try
        {
            return await _dataset.Where(p => p.OrcamentoId == orcamentoId).Include(i => i.Orcamento).ToListAsync(cancellation);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

}

