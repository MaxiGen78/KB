using KozhaBeauty.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace KozhaBeauty.Controllers
{
    public class HomeController : Controller
    {
        public HomeController()
        {
            ViewBag.Construction = "Under Construction";
        }
        
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
    }
}