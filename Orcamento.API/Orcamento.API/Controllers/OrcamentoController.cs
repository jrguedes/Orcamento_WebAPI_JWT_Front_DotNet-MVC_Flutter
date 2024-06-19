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
        try
        {
            var orcamentoModel = _mapper.Map<Models.Orcamento>(orcamento);
            var result = await _repository.InsertAsync(orcamentoModel);
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
    //[Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Get(int id)
    {
        try
        {
            var orcamento = await _repository.GetAsync(id, "ItensOrcamento");
            if (orcamento != null)
            {
                var response = _mapper.Map<OrcamentoResponse>(orcamento);
                return Ok(response);
            }
            return NotFound("Orçamento não encontrado");
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }

    [HttpDelete("{id}")]
    //[Authorize(Roles = "Gerente")]
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
    //[Authorize(Roles = "Gerente,Funcionario")]
    public async Task<ActionResult> Put([FromBody] UpdateOrcamentoRequest orcamento)
    {
        try
        {
            var orcamentoModel = _mapper.Map<Models.Orcamento>(orcamento);
            var result = await _repository.UpdateAsync(orcamentoModel);
            if (result != null)
            {
                var response = _mapper.Map<OrcamentoResponse>(result);
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
    //[Authorize(Roles = "Gerente,Funcionario")]    
    public async Task<ActionResult> Get()
    {
        try
        {
            var result = await _repository.GetAsync("ItensOrcamento");
            var response = _mapper.Map<IEnumerable<OrcamentoResponse>>(result);
            return Ok(response);
        }
        catch (ArgumentException e)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, e.Message);
        }
    }
}

