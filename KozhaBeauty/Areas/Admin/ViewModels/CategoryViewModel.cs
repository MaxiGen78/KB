using KozhaBeauty.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KozhaBeauty.Areas.Admin.ViewModels
{
    public class CategoryViewModel
    {
        public IEnumerable<CategoryModel> Models { get; set; }
        public CategoryModel Model { get; set; }
    }
}