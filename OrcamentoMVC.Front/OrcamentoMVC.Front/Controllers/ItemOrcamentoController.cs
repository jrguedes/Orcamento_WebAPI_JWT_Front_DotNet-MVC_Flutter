using Microsoft.AspNetCore.Mvc;

namespace OrcamentoMVC.Front;
[Route("Orcamento/[controller]")]
public class ItemOrcamentoController : Controller
{
    public IActionResult Index(OrcamentoItemViewModel orcamentoItemVM)
    {
        var vm = orcamentoItemVM;             
        vm.OrcamentoId = 10;
        return View(vm);
    }

    

}
