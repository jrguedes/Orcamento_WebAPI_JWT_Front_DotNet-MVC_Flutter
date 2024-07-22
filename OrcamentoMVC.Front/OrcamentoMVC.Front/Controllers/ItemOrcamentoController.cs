using Microsoft.AspNetCore.Mvc;
using OrcamentoMVC.Front.Services;

namespace OrcamentoMVC.Front;
//[Route("[controller]")]
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

    public string Data()
    {
        return DateTime.Now.ToString();
    }


    [HttpPost]
    public async Task<IActionResult> CreateItemOrcamento(ItemOrcamento itemOrcamento)
    {
        if (ModelState.IsValid)
        {
            var result = await _service.Create(itemOrcamento, GetJwtTokenFromCookies());

            if (result != null)
            {
                return RedirectToAction("Details", "Orcamento", new { id = result.OrcamentoId });
            }
        }

        return View("Index", itemOrcamento);
        //corrigir, está esperando VM
    }


    /*
    public async Task<IActionResult> Delete(int id)
    {
        var token = GetJwtTokenFromCookies();
        var item = await _service.Get(id, token);
        await _service.Delete(id, token);
        return RedirectToAction("Details", "Orcamento", new { id = item.OrcamentoId });
    }
    */


    //    [HttpGet("{id}")]

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

    private string GetJwtTokenFromCookies()
    {
        string token = string.Empty;
        if (HttpContext.Request.Cookies.ContainsKey("X-Access-Token"))
            token = HttpContext.Request.Cookies["X-Access-Token"].ToString();
        return token;
    }
}
