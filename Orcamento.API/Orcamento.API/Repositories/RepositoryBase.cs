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

    public async Task<bool> DeleteAsync(int id)
    {
        try
        {
            var result = await _dataset.SingleOrDefaultAsync(p => p.Id.Equals(id));
            if (result == null)
            {
                return false;
            }

            _dataset.Remove(result);
            await _context.SaveChangesAsync();
            return true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public async Task<bool> ExistsAsync(int id)
    {
        try
        {
            return await _dataset.AnyAsync(p => p.Id.Equals(id));
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    public async Task<T> GetAsync(int id, string include = null)
    {
        try
        {
            if (string.IsNullOrEmpty(include))
            {
                return await _dataset.Where(p => p.Id.Equals(id)).FirstOrDefaultAsync();
            }
            return await _dataset.Include(include).SingleOrDefaultAsync(p => p.Id.Equals(id));
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public async Task<IEnumerable<T>> GetAsync(string include = null)
    {
        try
        {
            if (string.IsNullOrEmpty(include))
            {
                return await _dataset.ToListAsync();
            }
            return await _dataset.Include(include).ToListAsync();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public async Task<T> InsertAsync(T model)
    {
        try
        {
            _dataset.Add(model);

            await _context.SaveChangesAsync();
            return model;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public async Task<T> UpdateAsync(T model)
    {
        try
        {
            var result = await _dataset.SingleOrDefaultAsync(p => p.Id.Equals(model.Id));
            if (result == null)
            {
                return null;
            }
            _context.Entry(result).CurrentValues.SetValues(model);
            await _context.SaveChangesAsync();
            return model;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}

