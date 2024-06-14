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
    public async Task<ActionResult> SignIn([FromBody] Login login, [FromServices] ILoginService service)
    {
        try
        {
            var result = await service.SignIn(login);
            var authenticated = result.GetType().GetProperty("authenticated").GetValue(result, null);
            if (result != null && authenticated != null && (bool)authenticated == true)
            {
                return Ok(result);
            }
            return NotFound(result);
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }


    [HttpPost]
    [AllowAnonymous]
    public async Task<ActionResult> Post([FromBody] User user)
    {
        try
        {
            var result = await _repository.InsertAsync(user);
            if (result != null)
            {
                result.Password = null;
                return Created(new Uri(Url.Link("GetUserById", new { id = result.Id })), result);
            }
            return BadRequest();
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpGet("{id}", Name = "GetUserById")]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get(int id)
    {
        try
        {
            var user = await _repository.GetAsync(id);
            if (user != null)
            {
                return Ok(user);
            }
            return NotFound("Usuário não encontrado");
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpDelete("{id}")]
    [Authorize(Roles = "Gerente")]
    public async Task<ActionResult> Delete(int id)
    {
        try
        {
            return Ok(await _repository.DeleteAsync(id));
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpPut]
    [Authorize(Roles = "Gerente")]
    public async Task<ActionResult> Put([FromBody] User user)
    {
        try
        {
            var result = await _repository.UpdateAsync(user);
            if (result != null)
            {
                return Ok(result);
            }
            return BadRequest();
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpGet]
    //[Authorize(Roles = "Gerente,Funcionario")]
    [AllowAnonymous]
    public async Task<ActionResult> Get()
    {
        try
        {
            return Ok(await _repository.GetAsync());
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }
}

