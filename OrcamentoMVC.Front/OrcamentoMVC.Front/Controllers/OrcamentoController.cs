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

    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> CreateOrcamento(Orcamento orcamento)
    {
        if (ModelState.IsValid)
        {
            orcamento.Data = DateTime.UtcNow;
            var result = await _service.Create(orcamento, GetJwtTokenFromCookies());

            if (result != null)
            {
                var orcamentoVM = new OrcamentoViewModel() { OrcamentoId = result.Id, DescricaoOrcamento = result.Descricao, ItemOrcamento = new ItemOrcamento() };
                return RedirectToAction("ItemOrcamento", "Orcamento", orcamentoVM);
            }
        }
        return View(orcamento);
    }

    public async Task<IActionResult> Delete(int id)
    {
        var deleted = await _service.Delete(id, GetJwtTokenFromCookies());
        return RedirectToAction("List", "Orcamento");
    }

    public async Task<IActionResult> Details(int id)
    {
        var orcamentoItensVM = await _service.Get(id, GetJwtTokenFromCookies());
        if (orcamentoItensVM is null)
            return View("Error");
        return View(orcamentoItensVM);
    }

    public IActionResult NewOrcamento()
    {
        return RedirectToAction("Index", "Orcamento");
    }

    public async Task<IActionResult> List()
    {
        var result = await _service.Get(GetJwtTokenFromCookies());

        if (result != null)
        {
            return View(result);
        }
        return View(new List<Orcamento>());
    }

    private string GetJwtTokenFromCookies()
    {
        string token = string.Empty;
        if (HttpContext.Request.Cookies.ContainsKey("X-Access-Token"))
            token = HttpContext.Request.Cookies["X-Access-Token"].ToString();
        return token;
    }
}
