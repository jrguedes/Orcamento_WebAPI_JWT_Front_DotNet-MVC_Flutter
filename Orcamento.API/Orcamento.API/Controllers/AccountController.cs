using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;
using Orcamento.API.Services;

namespace Orcamento.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class AccountController : ControllerBase
{
    private readonly IUserRepository _repository;

    public AccountController(IUserRepository repository)
    {
        _repository = repository;
    }


    [HttpPost("SignIn")]
    [AllowAnonymous]
    public async Task<ActionResult> SignIn([FromBody] Login login, [FromServices] ILoginService service, CancellationToken cancellation)
    {
        var result = await service.SignIn(login, cancellation);
        var authenticated = result.GetType().GetProperty("authenticated").GetValue(result, null);
        if (result != null && authenticated != null && (bool)authenticated == true)
        {
            return Ok(result);
        }
        return NotFound(result);
    }


    [HttpPost]
    [AllowAnonymous]
    public async Task<ActionResult> Post([FromBody] User user, CancellationToken cancellation)
    {
        var result = await _repository.InsertAsync(user, cancellation);
        if (result != null)
        {
            result.Password = null;
            return Created(new Uri(Url.Link("GetUserById", new { id = result.Id })), result);
        }
        return BadRequest();
    }

    [HttpGet("{id}", Name = "GetUserById")]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get(int id, CancellationToken cancellation)
    {
        var user = await _repository.GetAsync(id, cancellation);
        if (user != null)
        {
            return Ok(user);
        }
        return NotFound("Usuário não encontrado");
    }

    [HttpDelete("{id}")]
    [Authorize(Roles = "Gerente")]
    public async Task<ActionResult> Delete(int id, CancellationToken cancellation)
    {
        var deleted = await _repository.DeleteAsync(id, cancellation);
        if (!deleted)
        {
            return NotFound("Usuario não encontrado");
        }
        return Ok(deleted);
    }

    [HttpPut]
    [Authorize(Roles = "Gerente")]
    public async Task<ActionResult> Put([FromBody] User user, CancellationToken cancellation)
    {
        var result = await _repository.UpdateAsync(user, cancellation);
        if (result != null)
        {
            return Ok(result);
        }
        return NotFound("Usuario não encontrado");
    }

    [HttpGet]
    //[Authorize(Roles = "Gerente,Funcionario")]
    [AllowAnonymous]
    public async Task<ActionResult> Get(CancellationToken cancellation)
    {
        return Ok(await _repository.GetAsync(cancellation));
    }
}

