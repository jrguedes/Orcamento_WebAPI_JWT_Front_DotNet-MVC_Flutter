using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.EntityFrameworkCore;
using Orcamento.API.AppDbContextSQLite;
using Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;

namespace Orcamento.API.Repositories;

public class RepositoryBase<T> : IRepository<T> where T : ModelBase
{
    protected readonly AppDbContext _context;
    protected DbSet<T> _dataset;

    public RepositoryBase(AppDbContext context)
    {
        _context = context;
        _dataset = _context.Set<T>();
    }

    public async Task<bool> DeleteAsync(int id, CancellationToken cancellation)
    {
        try
        {
            var result = await _dataset.SingleOrDefaultAsync(p => p.Id.Equals(id), cancellation);
            if (result == null)
            {
                return false;
            }

            _dataset.Remove(result);
            await _context.SaveChangesAsync(cancellation);
            return true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public async Task<bool> ExistsAsync(int id, CancellationToken cancellation)
    {
        try
        {
            return await _dataset.AnyAsync(p => p.Id.Equals(id), cancellation);
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    public async Task<T> GetAsync(int id, CancellationToken cancellation, string include = null)
    {
        try
        {
            if (string.IsNullOrEmpty(include))
            {
                return await _dataset.Where(p => p.Id.Equals(id)).FirstOrDefaultAsync(cancellation);
            }
            return await _dataset.Include(include).SingleOrDefaultAsync(p => p.Id.Equals(id), cancellation);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public async Task<IEnumerable<T>> GetAsync(CancellationToken cancellation, string include = null)
    {
        try
        {
            if (string.IsNullOrEmpty(include))
            {
                return await _dataset.ToListAsync(cancellation);
            }
            return await _dataset.Include(include).ToListAsync(cancellation);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public async Task<T> InsertAsync(T model, CancellationToken cancellation)
    {
        try
        {
            _dataset.Add(model);

            await _context.SaveChangesAsync(cancellation);
            return model;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public async Task<T> UpdateAsync(T model, CancellationToken cancellation)
    {
        try
        {
            var result = await _dataset.SingleOrDefaultAsync(p => p.Id.Equals(model.Id), cancellation);
            if (result == null)
            {
                return null;
            }
            _context.Entry(result).CurrentValues.SetValues(model);
            await _context.SaveChangesAsync(cancellation);
            return model;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}

