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
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult> Post([FromBody] CreateOrcamentoRequest orcamento, CancellationToken cancellation)
    {
        var orcamentoModel = _mapper.Map<Models.Orcamento>(orcamento);
        var result = await _repository.InsertAsync(orcamentoModel, cancellation);
        if (result != null)
        {
            return Created(new Uri(Url.Link("GetOrcamentoById", new { id = result.Id })), result);
        }
        return BadRequest();
    }

    [HttpGet("{id}", Name = "GetOrcamentoById")]
    //[Authorize(Roles = "Gerente,Funcionario")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult> Get(int id, CancellationToken cancellation)
    {
        var orcamento = await _repository.GetAsync(id, cancellation, "ItensOrcamento");
        if (orcamento != null)
        {
            var response = _mapper.Map<OrcamentoResponse>(orcamento);
            return Ok(response);
        }
        return NotFound("Orçamento não encontrado");
    }

    [HttpDelete("{id}")]
    //[Authorize(Roles = "Gerente")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult> Delete(int id, CancellationToken cancellation)
    {
        var deleted = await _repository.DeleteAsync(id, cancellation);
        if (!deleted)
        {
            return NotFound("Orçamento não encontrado");
        }
        return Ok(deleted);
    }

    [HttpPut]
    //[Authorize(Roles = "Gerente,Funcionario")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult> Put([FromBody] UpdateOrcamentoRequest orcamento, CancellationToken cancellation)
    {
        var orcamentoModel = _mapper.Map<Models.Orcamento>(orcamento);
        var result = await _repository.UpdateAsync(orcamentoModel, cancellation);
        if (result != null)
        {
            var response = _mapper.Map<OrcamentoResponse>(result);
            return Ok(response);
        }
        return NotFound("Orçamento não encontrado");
    }

    [HttpGet]
    //[Authorize(Roles = "Gerente,Funcionario")]  
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult> Get(CancellationToken cancellation)
    {
        var result = await _repository.GetAsync(cancellation, "ItensOrcamento");
        var response = _mapper.Map<IEnumerable<OrcamentoResponse>>(result);
        return Ok(response);
    }
}

