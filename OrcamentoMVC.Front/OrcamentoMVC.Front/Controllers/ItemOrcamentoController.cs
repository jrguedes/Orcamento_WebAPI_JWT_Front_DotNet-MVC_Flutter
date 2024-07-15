using Microsoft.AspNetCore.Mvc;

namespace OrcamentoMVC.Front;
[Route("Orcamento/[controller]")]
public class ItemOrcamentoController : Controller
{
    public IActionResult Index()
    {        
        return View();
    }
}
