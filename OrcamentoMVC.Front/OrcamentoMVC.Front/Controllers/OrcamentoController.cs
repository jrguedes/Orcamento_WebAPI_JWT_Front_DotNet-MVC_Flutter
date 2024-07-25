using System.Net;
using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;

public class OrcamentoController : Controller
{

    private readonly IOrcamentoService _service;

    public OrcamentoController(IOrcamentoService service)
    {
        _service = service;
    }

    public IActionResult Index(Orcamento orcamento)
    {
        return View(orcamento ?? new Orcamento());
    }

    [HttpPost]
    public async Task<IActionResult> CreateOrUpdateOrcamento(Orcamento orcamento)
    {
        if (ModelState.IsValid)
        {
            Orcamento result = null;
            orcamento.Data = DateTime.UtcNow;

            if (orcamento.Id == 0)
            {
                result = await _service.Create(orcamento, GetJwtTokenFromCookies());
            }
            else
            {
                _ = await _service.Update(orcamento, GetJwtTokenFromCookies());
                return RedirectToAction("Details", new { Id = orcamento.Id });
            }

            if (result != null)
            {
                var orcamentoVM = new OrcamentoViewModel() { OrcamentoId = result.Id, DescricaoOrcamento = result.Descricao, ItemOrcamento = new ItemOrcamento() };
                return RedirectToAction("ItemOrcamento", "Orcamento", orcamentoVM);
            }
        }
        return View("Index", orcamento);
    }

    public async Task<IActionResult> Delete(int id)
    {
        _ = await _service.Delete(id, GetJwtTokenFromCookies());
        return RedirectToAction("List", "Orcamento");
    }

    public async Task<IActionResult> Details(int id)
    {
        var orcamentoItensVM = await _service.Get(id, GetJwtTokenFromCookies());
        if (orcamentoItensVM is null)
            return View("Error");
        return View(orcamentoItensVM);
    }

    public async Task<IActionResult> Update(int id)
    {
        var orcamentoVM = await _service.Get(id, GetJwtTokenFromCookies());
        if (orcamentoVM is null)
            return View("Error");
        return View(nameof(Index), new Orcamento() { Id = orcamentoVM.Id, Descricao = orcamentoVM.Descricao, Data = orcamentoVM.Data });
    }

    public IActionResult NewOrcamento()
    {
        return RedirectToAction("Index", "Orcamento");
    }

    public async Task<IActionResult> List()
    {
        var result = await _service.Get(GetJwtTokenFromCookies());

        if (result.IsSuccessStatusCode)
        {
            return View(result.Response);
        }
        return ValidateResult(result, View(new List<Orcamento>()));
    }

    private IActionResult ValidateResult(IServiceResponse serviceResult, IActionResult defaultActionResult)
    {
        if (serviceResult.StatusCode == HttpStatusCode.Unauthorized)
        {
            return RedirectToAction("Login", "Account");
        }
        return defaultActionResult;
    }

    private string GetJwtTokenFromCookies()
    {
        string token = string.Empty;
        if (HttpContext.Request.Cookies.ContainsKey("X-Access-Token"))
            token = HttpContext.Request.Cookies["X-Access-Token"].ToString();
        return token;
    }
}
