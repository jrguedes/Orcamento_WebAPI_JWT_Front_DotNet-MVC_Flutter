using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Principal;
using System.Threading.Tasks;
using Microsoft.IdentityModel.Tokens;
using Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;
using Orcamento.API.Security;

namespace Orcamento.API.Services;

public class LoginService : ILoginService
{
    private readonly IUserRepository _repository;

    private SigningConfiguration _signingConfiguration;
    private TokenConfiguration _tokenConfiguration;

    public LoginService(IUserRepository repository, SigningConfiguration signingConfiguration, TokenConfiguration tokenConfiguration)
    {
        _repository = repository;
        _signingConfiguration = signingConfiguration;
        _tokenConfiguration = tokenConfiguration;
    }

    public async Task<object> SignIn(Login login, CancellationToken cancellation)
    {
        if (login != null && !string.IsNullOrWhiteSpace(login.Email))
        {
            var user = await _repository.SignIn(login, cancellation);
            if (user != null)
            {
                var identity = new ClaimsIdentity(
                    new GenericIdentity(user.Email),
                    new[]{
                            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                            new Claim(JwtRegisteredClaimNames.UniqueName, user.Email),
                            new Claim(ClaimTypes.Name, user.Name),
                            new Claim(ClaimTypes.Role,user.Role)
                    }
                );
                DateTime createDate = DateTime.UtcNow;
                DateTime expirationDate = createDate + TimeSpan.FromSeconds(_tokenConfiguration.Seconds);
                var handler = new JwtSecurityTokenHandler();

                string token = CreateToken(identity, createDate, expirationDate, handler);

                return SuccessObject(createDate, expirationDate, token, user);
            }
        }

        return new
        {
            authenticated = false,
            message = "Falha ao autenticar"
        };
    }

    private string CreateToken(ClaimsIdentity identity, DateTime createDate, DateTime expirationDate, JwtSecurityTokenHandler handler)
    {
        var securityToken = handler.CreateToken(
            new SecurityTokenDescriptor
            {
                Issuer = _tokenConfiguration.Issuer,
                Audience = _tokenConfiguration.Audience,
                SigningCredentials = _signingConfiguration.SigningCredentials,
                Subject = identity,
                NotBefore = createDate,
                Expires = expirationDate
            });

        var token = handler.WriteToken(securityToken);

        return token;
    }

    private object SuccessObject(DateTime createDate, DateTime expirationDate, string token, User user)
    {
        return new
        {
            authenticated = true,
            created = createDate.ToString("yyyy-MM-dd HH:mm:ss"),
            expirationDate = createDate.ToString("yyyy-MM-dd HH:mm:ss"),
            accessToken = token,
            userName = user.Email,
            name = user.Name,
            message = "Usuário logado com sucesso",
            role = user.Role
        };
    }
}

