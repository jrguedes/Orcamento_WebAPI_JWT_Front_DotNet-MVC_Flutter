using System.Net;
using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;

public class ItemOrcamentoController : Controller
{    
    private readonly IItemOrcamentoService _service;
    private readonly IAccessTokenService _tokenService;

    public ItemOrcamentoController(IItemOrcamentoService service, IAccessTokenService tokenService)
    {
        _tokenService = tokenService;
        _service = service;        
    }

    public IActionResult Index(OrcamentoViewModel orcamentoItemVM)
    {
        return View(orcamentoItemVM);
    }

    [HttpPost]
    public async Task<IActionResult> CreateItemOrcamento(string descricaoOrcamento, ItemOrcamento itemOrcamento)
    {
        if (!ModelState.IsValid)
        {
            return View(nameof(Index), itemOrcamento);
        }

        var result = await _service.Create(itemOrcamento, _tokenService.GetJwtTokenFromCookies());
        if (result.IsSuccessStatusCode)
        {
            if (result.Response != null)
            {
                return RedirectToAction("Details", "Orcamento", new { id = result.Response.OrcamentoId });
            }
        }
        var orcamentoItemVM = new OrcamentoViewModel() { OrcamentoId = itemOrcamento.OrcamentoId, DescricaoOrcamento = descricaoOrcamento, ItemOrcamento = itemOrcamento };
        return ValidateAuthorization(result, View("Index", orcamentoItemVM));
    }

    public async Task<IActionResult> Delete(int id)
    {
        var token = _tokenService.GetJwtTokenFromCookies();
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
}
