using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Orcamento.API.AppDbContextSQLite;
using Orcamento.API.Dtos.Mappings;
using Orcamento.API.Filters;
using Orcamento.API.Repositories;
using Orcamento.API.Repositories.Interfaces;
using Orcamento.API.Security;
using Orcamento.API.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


builder.Services.AddDbContext<AppDbContext>(
                db => db.UseSqlite(builder.Configuration.GetConnectionString("DefaultConnection"))
            );
builder.Services.AddTransient<IUserRepository, UserRepository>();
builder.Services.AddTransient<IOrcamentoRepository, OrcamentoRepository>();
builder.Services.AddTransient<IItemOrcamentoRepository, ItemOrcamentoRepository>();
builder.Services.AddTransient<ILoginService, LoginService>();

var signingConfiguration = new SigningConfiguration();
builder.Services.AddSingleton(signingConfiguration);

var tokenConfiguration = new TokenConfiguration()
{
    Audience = "audience",
    Issuer = "issuer",
    //Seconds = 3600
    Seconds = 30
};
builder.Services.AddSingleton(tokenConfiguration);

builder.Services.AddAuthentication(authOptions =>
            {
                authOptions.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                authOptions.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(bearerOptions =>
            {
                var paramsValidation = bearerOptions.TokenValidationParameters;
                paramsValidation.IssuerSigningKey = signingConfiguration.Key;
                paramsValidation.ValidAudience = tokenConfiguration.Audience;
                paramsValidation.ValidIssuer = tokenConfiguration.Issuer;
                paramsValidation.ValidateIssuerSigningKey = true;
                paramsValidation.ValidateLifetime = true;
                paramsValidation.ClockSkew = TimeSpan.Zero;
            });

builder.Services.AddControllers(options =>
            {
                options.Filters.Add(typeof(ApiExceptionFilter));
            }
 ).AddNewtonsoftJson(options =>
            {
                options.SerializerSettings.ReferenceLoopHandling =
                Newtonsoft.Json.ReferenceLoopHandling.Ignore;
            });
builder.Services.AddCors();

builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Version = "v1",
        Title = "Orcamento-WebAPI",
        Description = "Orcamento-WebAPI",
        TermsOfService = new Uri("http://www.google.com"),
        Contact = new OpenApiContact
        {
            Name = "Junior Guedes",
            Email = "email@gmail.com",
            Url = new Uri("http://www.google.com")
        },
        License = new OpenApiLicense
        {
            Name = "Termo de Licença de Uso",
            Url = new Uri("http://www.google.com/minhalicenca")
        }
    });



    //faz o botao de autenticacao aparecer
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "Entre com o Token JWT",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey
    });

    //faz a autenticacao
    c.AddSecurityRequirement(
        new OpenApiSecurityRequirement{
                        {
                            new OpenApiSecurityScheme{
                                Reference = new OpenApiReference{
                                    Id = "Bearer",
                                    Type = ReferenceType.SecurityScheme
                                }
                            },
                            new List<string>()
                        }
        }
    );
});

builder.Services.AddAutoMapper(typeof(GeneralDtoMappingProfile));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(options => options.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

