using Microsoft.AspNetCore.Mvc;

namespace OrcamentoMVC.Front;

public class OrcamentoController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]
    public IActionResult CreateOrcamento(Orcamento orcamento)
    {
        var orcamentoVM = new OrcamentoItemViewModel(){OrcamentoId = orcamento.Id, DescricaoOrcamento = orcamento.Descricao};
        return RedirectToAction("ItemOrcamento", "Orcamento", orcamentoVM);
    }

    public IActionResult List()
    {
        return View("List");
    }
}
