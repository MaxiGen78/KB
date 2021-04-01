using KozhaBeauty.Areas.Admin.ViewModels;
using KozhaBeauty.DataAccess;
using KozhaBeauty.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace KozhaBeauty.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        Data data = new Data();

        // GET: Admin/Product
        public ActionResult Index()
        {
            Data data = new Data();
            var output = data.GetListOfAllProducts();

            return View(output);
        }


        // GET: Admin/Product/Create
        public ActionResult Create()
        {
            var output = data.GetListOfCategories();
            ProductViewModel productViewModel = new ProductViewModel();
            productViewModel.CategoryModels = output;
            return View(productViewModel);
        }

        // POST: Admin/Product/Create
        [HttpPost]
        public ActionResult Create(ProductViewModel model)
        {
            ProductTestModel p = new ProductTestModel();

            p.Name = model.ProductModel.Name;
            p.Price = model.ProductModel.Price;
            p.Slug = model.ProductModel.Slug;
            p.Quantity = model.ProductModel.Quantity;
            p.Description = model.ProductModel.Description;
            p.IsActive = model.ProductModel.IsActive;
            try
            {
                data.AmendData("spAddProduct", p);

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }



        // POST: Admin/Product/Upload
        [HttpPost]
        public void Upload()
        {
            for (int i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];
                var fileName = Path.GetFileName(file.FileName);
                var path = Path.Combine(Server.MapPath("~/Content/Product_Images/temp"), fileName);
                file.SaveAs(path);

                ProductImageModel image = new ProductImageModel();
                image.Name = fileName;
                data.AmendData("spAddImage", image);
            }
        }

    }
}
