using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Models = Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;

namespace Orcamento.API.Controllers;

[ApiController]
[Authorize]
[Route("api/[controller]")]
public class OrcamentoController : ControllerBase
{
    private readonly IOrcamentoRepository _repository;

    public OrcamentoController(IOrcamentoRepository repository)
    {
        _repository = repository;
    }

    [HttpPost]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Post([FromBody] Models.Orcamento orcamento)
    {
        try
        {
            var result = await _repository.InsertAsync(orcamento);
            if (result != null)
            {
                return Created(new Uri(Url.Link("GetOrcamentoById", new { id = result.Id })), result);
            }
            return BadRequest();
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpGet("{id}", Name = "GetOrcamentoById")]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get(int id)
    {
        try
        {
            var orcamento = await _repository.GetAsync(id, "ItensOrcamento");
            if (orcamento != null)
            {
                return Ok(orcamento);
            }
            return NotFound("Orçamento não encontrado");
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
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Put([FromBody] Models.Orcamento orcamento)
    {
        try
        {
            var result = await _repository.UpdateAsync(orcamento);
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
    [Authorize(Roles = "Gerente,Funcionario")]    
    public async Task<ActionResult> Get()
    {
        try
        {
            return Ok(await _repository.GetAsync("ItensOrcamento"));
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }
}

