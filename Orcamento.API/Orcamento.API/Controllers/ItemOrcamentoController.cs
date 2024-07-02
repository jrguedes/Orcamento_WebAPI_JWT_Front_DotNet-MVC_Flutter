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
        var itemModel = _mapper.Map<ItemOrcamento>(item);
        var result = await _repository.InsertAsync(itemModel);
        if (result != null)
        {
            return Created(new Uri(Url.Link("GetById", new { id = result.Id })), result);
        }
        return BadRequest();
    }

    [HttpGet("{id}", Name = "GetById")]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get(int id)
    {

        var item = await _repository.GetAsync(id);
        if (item != null)
        {
            var response = _mapper.Map<ItemOrcamentoResponse>(item);
            return Ok(response);
        }
        return NotFound("Item não encontrado");
    }

    [HttpDelete("{id}")]
    [Authorize(Roles = "Gerente")]
    public async Task<ActionResult> Delete(int id)
    {
        return Ok(await _repository.DeleteAsync(id));
    }

    [HttpPut]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Put([FromBody] UpdateItemOrcamentoRequest item)
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

    [HttpGet]
    [Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get()
    {
        var itensOrcamentos = await _repository.GetAsync();
        var response = _mapper.Map<IEnumerable<ItemOrcamentoResponse>>(itensOrcamentos);
        return Ok(response);
    }

    [HttpGet("orcamento/{id}")]
    //[Authorize(Roles = "Gerente,Funcionario")]
    [AllowAnonymous]
    public async Task<ActionResult> GetByOrcamento(int id)
    {
        return Ok(await _repository.GetItensByOrcamentoAsync(id));
    }
}

