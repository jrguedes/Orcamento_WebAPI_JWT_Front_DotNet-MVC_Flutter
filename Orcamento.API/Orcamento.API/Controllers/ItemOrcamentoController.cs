using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
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
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult> Post([FromBody] CreateItemOrcamentoRequest item, CancellationToken cancellation)
    {
        var itemModel = _mapper.Map<ItemOrcamento>(item);
        var result = await _repository.InsertAsync(itemModel, cancellation);
        if (result != null)
        {
            return Created(new Uri(Url.Link("GetById", new { id = result.Id })), result);
        }
        return BadRequest();
    }

    [HttpGet("{id}", Name = "GetById")]
    [Authorize(Roles = "Gerente,Funcionario")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult> Get(int id, CancellationToken cancellation)
    {
        var item = await _repository.GetAsync(id, cancellation);
        if (item != null)
        {
            var response = _mapper.Map<ItemOrcamentoResponse>(item);
            return Ok(response);
        }
        return NotFound("Item não encontrado");
    }

    [HttpDelete("{id}")]
    [Authorize(Roles = "Gerente")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult> Delete(int id, CancellationToken cancellation)
    {
        var deleted = await _repository.DeleteAsync(id, cancellation);
        if (!deleted)
        {
            return NotFound("Item não encontrado");
        }
        return Ok(deleted);
    }

    [HttpPut]
    [Authorize(Roles = "Gerente,Funcionario")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult> Put([FromBody] UpdateItemOrcamentoRequest item, CancellationToken cancellation)
    {
        var itemModel = _mapper.Map<ItemOrcamento>(item);
        var result = await _repository.UpdateAsync(itemModel, cancellation);
        if (result != null)
        {
            var response = _mapper.Map<ItemOrcamentoResponse>(result);
            return Ok(response);
        }
        return NotFound("Item não encontrado");
    }

    [HttpGet]
    [Authorize(Roles = "Gerente,Funcionario")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult> Get(CancellationToken cancellation)
    {
        var itensOrcamentos = await _repository.GetAsync(cancellation);
        var response = _mapper.Map<IEnumerable<ItemOrcamentoResponse>>(itensOrcamentos);
        return Ok(response);
    }

    [HttpGet("orcamento/{id}")]
    [Authorize(Roles = "Gerente,Funcionario")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult> GetByOrcamento(int id, CancellationToken cancellation)
    {
        var result = await _repository.GetItensByOrcamentoAsync(id, cancellation);
        if (result.IsNullOrEmpty())
        {
            return NotFound("Orçamento não encontrado");
        }
        return Ok(result);
    }
}

