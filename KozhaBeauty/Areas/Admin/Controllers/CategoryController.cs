using KozhaBeauty.Areas.Admin.ViewModels;
using KozhaBeauty.DataAccess;
using KozhaBeauty.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace KozhaBeauty.Areas.Admin.Controllers
{
    public class CategoryController : Controller
    {
        Data data = new Data();

        // GET: Admin/Category
        public ActionResult Index()
        {
            var output = data.GetListOfCategories();
            CategoryViewModel categoryViewModel = new CategoryViewModel();
            categoryViewModel.Models = output;
            categoryViewModel.Model = new CategoryModel();
            return View(categoryViewModel);
        }

        // POST (CREATE): Admin/Category
        [HttpPost]
        public ActionResult Create(CategoryModel model)
        {
            try
            {
                data.AmendData("spAddCategory", model);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }


        // POST (EDIT): Admin/Category
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(CategoryModel model)
        {
            try
            {
                data.AmendData("spUpdateCategory", model);

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }


        // POST (DELETE): Admin/Category
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete([Bind(Include = "Id, Name")] CategoryModel model)
        {
            try
            {
                data.AmendData("spDeleteCategory", model);

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
