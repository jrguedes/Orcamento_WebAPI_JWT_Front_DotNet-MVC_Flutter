using Orcamento.API.Models;

namespace Orcamento.API.Repositories.Interfaces;

public interface IUserRepository : IRepository<User>
{
    Task<User> SignIn(Login login);
}

