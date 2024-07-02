using Orcamento.API.Models;

namespace Orcamento.API.Repositories.Interfaces;

public interface IRepository<T> where T : ModelBase
{
    Task<T> InsertAsync(T model, CancellationToken cancellation);
    Task<T> UpdateAsync(T model, CancellationToken cancellation);
    Task<bool> DeleteAsync(int id, CancellationToken cancellation);
    Task<T> GetAsync(int id, CancellationToken cancellation, string include = null);
    Task<IEnumerable<T>> GetAsync(CancellationToken cancellation, string include = null);
    Task<bool> ExistsAsync(int id, CancellationToken cancellation);
}

