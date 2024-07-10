using Microsoft.AspNetCore.Mvc;

namespace OrcamentoMVC.Front;

public class OrcamentoController : Controller
{
    public IActionResult Index()
    {        
        return View();
    }

    public IActionResult List()
    {        
        return View("List");
    }
}
