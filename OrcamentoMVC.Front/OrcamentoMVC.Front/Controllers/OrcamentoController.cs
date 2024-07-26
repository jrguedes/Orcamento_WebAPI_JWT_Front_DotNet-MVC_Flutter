using System.Net;
using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;

public class OrcamentoController : Controller
{

    private readonly IOrcamentoService _service;
    private readonly IAccessTokenService _tokenService;
    
    public OrcamentoController(IOrcamentoService service, IAccessTokenService tokenService)
    {
        _service = service;
        _tokenService = tokenService;
    }

    public IActionResult Index(Orcamento orcamento)
    {
        return View(orcamento ?? new Orcamento());
    }

    [HttpPost]
    public async Task<IActionResult> CreateOrUpdateOrcamento(Orcamento orcamento)
    {
        if (!ModelState.IsValid)
        {
            return View(nameof(Index), orcamento);
        }

        ServiceResponse<Orcamento> result = null;
        orcamento.Data = DateTime.UtcNow;

        if (orcamento.Id == 0)
        {
            result = await _service.Create(orcamento, _tokenService.GetJwtTokenFromCookies());
            var orcamentoVM = new OrcamentoViewModel();
            var actionResultCreate = RedirectToAction("ItemOrcamento", "Orcamento", orcamentoVM);
            if (result.Response != null)
            {
                orcamentoVM = new OrcamentoViewModel() { OrcamentoId = result.Response.Id, DescricaoOrcamento = result.Response.Descricao, ItemOrcamento = new ItemOrcamento() };
                actionResultCreate = RedirectToAction("ItemOrcamento", "Orcamento", orcamentoVM);
            }
            return ValidateAuthorization(result, actionResultCreate);
        }
        else
        {
            var updated = await _service.Update(orcamento, _tokenService.GetJwtTokenFromCookies());
            var actionResult = RedirectToAction("Details", new { orcamento.Id });
            return ValidateAuthorization(updated, actionResult);
        }
    }

    public async Task<IActionResult> Delete(int id)
    {
        var result = await _service.Delete(id, _tokenService.GetJwtTokenFromCookies());

        if (result.IsSuccessStatusCode)
        {
            return RedirectToAction("List", "Orcamento");
        }

        return ValidateAuthorization(result, View(false));
    }

    public async Task<IActionResult> Details(int id)
    {
        var result = await _service.Get(id, _tokenService.GetJwtTokenFromCookies());
        if (result.Response is null)
            return View("Error");

        if (result.IsSuccessStatusCode)
        {
            return View(result.Response);
        }

        return ValidateAuthorization(result, View(result.Response));
    }

    public async Task<IActionResult> Update(int id)
    {
        var result = await _service.Get(id, _tokenService.GetJwtTokenFromCookies());

        if (result.Response is null)
            return View("Error");

        var actionResult = View(nameof(Index), new Orcamento() { Id = result.Response.Id, Descricao = result.Response.Descricao, Data = result.Response.Data });

        return ValidateAuthorization(result, actionResult);
    }

    public IActionResult NewOrcamento()
    {
        return RedirectToAction("Index", "Orcamento");
    }

    public async Task<IActionResult> List()
    {
        var result = await _service.Get(_tokenService.GetJwtTokenFromCookies());

        if (result.IsSuccessStatusCode)
        {
            return View(result.Response);
        }
        return ValidateAuthorization(result, View(new List<Orcamento>()));
    }

    private IActionResult ValidateAuthorization(IServiceResponse serviceResult, IActionResult defaultActionResult)
    {
        if (serviceResult.StatusCode == HttpStatusCode.Unauthorized)
        {
            return RedirectToAction("Login", "Account");
        }
        return defaultActionResult;
    }
}
