using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Orcamento.API.AppDbContextSQLite;
using Models = Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;

namespace Orcamento.API.Repositories;

public class OrcamentoRepository : RepositoryBase<Models.Orcamento>, IOrcamentoRepository
{
    public OrcamentoRepository(AppDbContext context) : base(context)
    {
        _dataset = _context.Set<Models.Orcamento>();
    }

    public async Task<Models.Orcamento> GetOrcamentoComItensAsync(int id, CancellationToken cancellation)
    {
        try
        {
            return await _dataset.Where(p => p.Id == id).Include(i => i.ItensOrcamento).FirstOrDefaultAsync(cancellation);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}

