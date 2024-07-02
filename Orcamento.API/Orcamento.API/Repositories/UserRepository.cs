using Microsoft.EntityFrameworkCore;
using Orcamento.API.AppDbContextSQLite;
using Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;

namespace Orcamento.API.Repositories;

public class UserRepository : RepositoryBase<User>, IUserRepository
{
    public UserRepository(AppDbContext context) : base(context)
    {
        _dataset = _context.Set<User>();
    }

    public async Task<User> SignIn(Login login, CancellationToken cancellation)
    {
        try
        {
            return await _dataset.SingleOrDefaultAsync(p => p.Email.Equals(login.Email) && p.Password.Equals(login.Password), cancellation);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}

