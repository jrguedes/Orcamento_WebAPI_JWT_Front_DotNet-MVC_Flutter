using System.Net;
using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;

public class ItemOrcamentoController : Controller
{
    private readonly IItemOrcamentoService _service;

    public ItemOrcamentoController(IItemOrcamentoService service)
    {
        _service = service;
    }

    public IActionResult Index(OrcamentoViewModel orcamentoItemVM)
    {
        return View(orcamentoItemVM);
    }

    [HttpPost]
    public async Task<IActionResult> CreateItemOrcamento(OrcamentoViewModel orcamentoItemVM)
    {
        if (!ModelState.IsValid)
        {
            return View(nameof(Index), orcamentoItemVM);
        }

        var result = await _service.Create(orcamentoItemVM.ItemOrcamento, GetJwtTokenFromCookies());
        if (result.IsSuccessStatusCode)
        {
            if (result.Response != null)
            {
                return RedirectToAction("Details", "Orcamento", new { id = result.Response.OrcamentoId });
            }
        }
        return ValidateAuthorization(result, View("Index", orcamentoItemVM));
    }

    public async Task<IActionResult> Delete(int id)
    {
        var token = GetJwtTokenFromCookies();
        var resultItem = await _service.Get(id, token);
        if (resultItem.IsSuccessStatusCode && resultItem.Response != null)
        {
            var actionResult = RedirectToAction("Details", "Orcamento", new { id = resultItem.Response.OrcamentoId });
            var resultDelete = await _service.Delete(id, token);
            if (resultDelete.IsSuccessStatusCode)
            {
                return actionResult;
            }
            return ValidateAuthorization(resultDelete, View("Index", actionResult));
        }
        return ValidateAuthorization(resultItem, RedirectToAction("Index", "Home"));
    }

    [HttpPost]
    public async Task<IActionResult> CreateNewItemOrcamento(int idOrcamento, string descricaoOrcamento)
    {
        var itemVM = new OrcamentoViewModel()
        {
            OrcamentoId = idOrcamento,
            DescricaoOrcamento = descricaoOrcamento,
            ItemOrcamento = new ItemOrcamento()
        };

        return View("Index", itemVM);
    }

    private IActionResult ValidateAuthorization(IServiceResponse serviceResult, IActionResult defaultActionResult)
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
