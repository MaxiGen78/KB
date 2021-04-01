using KozhaBeauty.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace KozhaBeauty.Areas.Admin.ViewModels
{
    public class ProductViewModel
    {
        //public IEnumerable<ProductImageModel> ImageModels { get; set; }

        [Display(Name = "Image", Description = "Select an image")]
        public ProductImageModel ProductImage { get; set; }

        public IEnumerable<CategoryModel> CategoryModels { get; set; }
        public int SelectedCategoryId { get; set; }
        public ProductModel ProductModel { get; set; }
    }
}