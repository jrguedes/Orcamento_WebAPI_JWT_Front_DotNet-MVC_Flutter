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
            var result = await _service.Create(orcamento, GetJwtTokenFromCookies());

            if (result != null)
            {
                var orcamentoVM = new OrcamentoItemViewModel() { OrcamentoId = result.Id, DescricaoOrcamento = result.Descricao };
                return RedirectToAction("ItemOrcamento", "Orcamento", orcamentoVM);
            }
        }
        else
        {
            //ViewBag.CategoriaId =
            //new SelectList(await _categoriaService.GetCategorias(), "CategoriaId", "Nome");
        }
        
        return View(orcamento);
    }

    public IActionResult List()
    {
        return View("List");
    }

    private string GetJwtTokenFromCookies()
    {
        string token = string.Empty;
        if (HttpContext.Request.Cookies.ContainsKey("X-Access-Token"))
            token = HttpContext.Request.Cookies["X-Access-Token"].ToString();
        return token;
    }
}
