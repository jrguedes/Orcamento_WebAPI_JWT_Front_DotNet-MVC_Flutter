using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Models = Orcamento.API.Models;
using Orcamento.API.Repositories.Interfaces;
using Orcamento.API.Dtos.RequestDto;
using AutoMapper;
using Orcamento.API.Dtos.ResponseDto;

namespace Orcamento.API.Controllers;

[ApiController]
//[Authorize]
[Route("api/[controller]")]
public class OrcamentoController : ControllerBase
{
    private readonly IMapper _mapper;
    private readonly IOrcamentoRepository _repository;

    public OrcamentoController(IOrcamentoRepository repository, IMapper mapper)
    {
        _mapper = mapper;
        _repository = repository;
    }

    [HttpPost]
    //[Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Post([FromBody] CreateOrcamentoRequest orcamento)
    {
        var orcamentoModel = _mapper.Map<Models.Orcamento>(orcamento);
        var result = await _repository.InsertAsync(orcamentoModel);
        if (result != null)
        {
            return Created(new Uri(Url.Link("GetOrcamentoById", new { id = result.Id })), result);
        }
        return BadRequest();
    }

    [HttpGet("{id}", Name = "GetOrcamentoById")]
    //[Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get(int id)
    {
        var orcamento = await _repository.GetAsync(id, "ItensOrcamento");
        if (orcamento != null)
        {
            var response = _mapper.Map<OrcamentoResponse>(orcamento);
            return Ok(response);
        }
        return NotFound("Orçamento não encontrado");
    }

    [HttpDelete("{id}")]
    //[Authorize(Roles = "Gerente")]
    public async Task<ActionResult> Delete(int id)
    {
        var deleted = await _repository.DeleteAsync(id);
        if (!deleted)
        {
            return NotFound("Orçamento não encontrado");
        }
        return Ok(deleted);
    }

    [HttpPut]
    //[Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Put([FromBody] UpdateOrcamentoRequest orcamento)
    {
        var orcamentoModel = _mapper.Map<Models.Orcamento>(orcamento);
        var result = await _repository.UpdateAsync(orcamentoModel);
        if (result != null)
        {
            var response = _mapper.Map<OrcamentoResponse>(result);
            return Ok(response);
        }
        return NotFound("Orçamento não encontrado");
    }

    [HttpGet]
    //[Authorize(Roles = "Gerente,Funcionario")]    
    public async Task<ActionResult> Get()
    {
        var result = await _repository.GetAsync("ItensOrcamento");
        var response = _mapper.Map<IEnumerable<OrcamentoResponse>>(result);
        return Ok(response);
    }
}

