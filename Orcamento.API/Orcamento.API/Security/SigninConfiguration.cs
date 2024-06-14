using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;
using Microsoft.IdentityModel.Tokens;

namespace Orcamento.API.Security;

public class SigningConfiguration
{
    public SecurityKey Key { get; set; }
    public SigningCredentials SigningCredentials { get; set; }

    public SigningConfiguration()
    {
        using (var provider = new RSACryptoServiceProvider(2048))
        {
            Key = new RsaSecurityKey(provider.ExportParameters(true));
        }
        SigningCredentials = new SigningCredentials(Key, SecurityAlgorithms.RsaSha256Signature);
    }
}

