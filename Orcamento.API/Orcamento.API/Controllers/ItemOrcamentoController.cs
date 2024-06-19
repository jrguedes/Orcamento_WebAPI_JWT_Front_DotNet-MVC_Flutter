using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Orcamento.API.Dtos.RequestDto;
using Orcamento.API.Dtos.ResponseDto;
using Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;

namespace Orcamento.API.Controllers;

[ApiController]
[Authorize]
[Route("api/[controller]")]
public class ItemOrcamentoController : ControllerBase
{
    private readonly IItemOrcamentoRepository _repository;
    private readonly IMapper _mapper;

    public ItemOrcamentoController(IItemOrcamentoRepository repository, IMapper mapper)
    {
        _repository = repository;
        _mapper = mapper;
    }

    [HttpPost]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Post([FromBody] CreateItemOrcamentoRequest item)
    {
        try
        {
            var itemModel = _mapper.Map<ItemOrcamento>(item);
            var result = await _repository.InsertAsync(itemModel);
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
                var response = _mapper.Map<ItemOrcamentoResponse>(item);
                return Ok(response);
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
    public async Task<ActionResult> Put([FromBody] UpdateItemOrcamentoRequest item)
    {
        try
        {
            var itemModel = _mapper.Map<ItemOrcamento>(item);
            var result = await _repository.UpdateAsync(itemModel);
            if (result != null)
            {
                var response = _mapper.Map<ItemOrcamentoResponse>(result);
                return Ok(response);
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
            var itensOrcamentos = await _repository.GetAsync();
            var response = _mapper.Map<IEnumerable<ItemOrcamentoResponse>>(itensOrcamentos);
            return Ok(response);
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

