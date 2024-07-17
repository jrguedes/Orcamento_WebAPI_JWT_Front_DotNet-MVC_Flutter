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
        var vm = orcamentoItemVM;
        vm.OrcamentoId = 10;
        return View(vm);
    }

    [HttpPost]
    public async Task<IActionResult> CreateItemOrcamento(ItemOrcamento itemOrcamento)
    {
        if (ModelState.IsValid)
        {
            var result = await _service.Create(itemOrcamento, GetJwtTokenFromCookies());

            if (result != null)
            {
                //var orcamentoVM = new OrcamentoItemViewModel() { OrcamentoId = result.Id, DescricaoOrcamento = result.Descricao };                
                return View(result);
                //retornar depois para a lista de orçamentos
            }
        }
        else
        {
            //ViewBag.CategoriaId =
            //new SelectList(await _categoriaService.GetCategorias(), "CategoriaId", "Nome");
        }

        return View(itemOrcamento);
    }

    private string GetJwtTokenFromCookies()
    {
        string token = string.Empty;
        if (HttpContext.Request.Cookies.ContainsKey("X-Access-Token"))
            token = HttpContext.Request.Cookies["X-Access-Token"].ToString();
        return token;
    }



}
