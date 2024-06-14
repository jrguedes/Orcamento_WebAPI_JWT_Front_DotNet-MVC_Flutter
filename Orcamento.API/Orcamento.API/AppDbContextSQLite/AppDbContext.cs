using Microsoft.EntityFrameworkCore;
using Models = Orcamento.API.Models;

namespace Orcamento.API.AppDbContextSQLite
{
     

    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        public DbSet<Models.Orcamento> Orcamentos { get; set; }
        public DbSet<Models.ItemOrcamento> ItensOrcamento { get; set; }
        public DbSet<Models.User> Users { get; set; }
        
    }
}
