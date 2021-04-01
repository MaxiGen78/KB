using KozhaBeauty.DataAccess;
using KozhaBeauty.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace KozhaBeauty.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        public ActionResult Index()
        {
            Data data = new Data();
            var output = data.GetListOfAllProducts();

            return View (output);

        }
    }
}
