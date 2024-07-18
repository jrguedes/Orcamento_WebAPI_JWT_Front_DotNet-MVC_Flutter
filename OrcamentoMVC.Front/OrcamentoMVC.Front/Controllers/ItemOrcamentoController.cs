using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;
[Route("Orcamento/[controller]")]
public class ItemOrcamentoController : Controller
{
    private readonly IItemOrcamentoService _service;

    public ItemOrcamentoController(IItemOrcamentoService service)
    {
        _service = service;
    }

    public IActionResult Index(OrcamentoItemViewModel orcamentoItemVM)
    {
        return View(orcamentoItemVM);
    }

    [HttpPost]
    public async Task<IActionResult> CreateItemOrcamento(ItemOrcamento itemOrcamento)
    {
        if (ModelState.IsValid)
        {
            var result = await _service.Create(itemOrcamento, GetJwtTokenFromCookies());

            if (result != null)
            {            
                return RedirectToAction("List", "Orcamento");
            }
        }        

        return View("Index", itemOrcamento);
        //corrigir, está esperando VM
    }

    private string GetJwtTokenFromCookies()
    {
        string token = string.Empty;
        if (HttpContext.Request.Cookies.ContainsKey("X-Access-Token"))
            token = HttpContext.Request.Cookies["X-Access-Token"].ToString();
        return token;
    }
}
