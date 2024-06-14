using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;

namespace Orcamento.API.Controllers;

[ApiController]
[Authorize]
[Route("api/[controller]")]
public class ItemOrcamentoController : ControllerBase
{
    private readonly IItemOrcamentoRepository _repository;

    public ItemOrcamentoController(IItemOrcamentoRepository repository)
    {
        _repository = repository;
    }

    [HttpPost]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Post([FromBody] ItemOrcamento item)
    {
        try
        {
            var result = await _repository.InsertAsync(item);
            if (result != null)
            {
                return Created(new Uri(Url.Link("GetById", new { id = result.Id })), result);
            }
            return BadRequest();
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpGet("{id}", Name = "GetById")]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get(int id)
    {
        try
        {
            var item = await _repository.GetAsync(id);
            if (item != null)
            {
                return Ok(item);
            }
            return NotFound("Item não encontrado");
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
    public async Task<ActionResult> Put([FromBody] ItemOrcamento item)
    {
        try
        {
            var result = await _repository.UpdateAsync(item);
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
            return Ok(await _repository.GetAsync());
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpGet("orcamento/{id}")]
    //[Authorize(Roles = "Gerente,Funcionario")]
    [AllowAnonymous]
    public async Task<ActionResult> GetByOrcamento(int id)
    {
        try
        {
            return Ok(await _repository.GetItensByOrcamentoAsync(id));
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }
}

