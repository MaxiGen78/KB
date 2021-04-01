﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace KozhaBeauty.Models
{
    public class ProductModel
    {
        public int Id { get; set; }

        [Display(Name="Product Name", Description="This must be a unique name")]
        [Required(ErrorMessage = "This field is required")]
        [RegularExpression(@".*\S+.*", ErrorMessage = "No white space allowed")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Name must be between 3 and 100 characters long")]
        public string Name { get; set; }

        public int Quantity { get; set; }

        public decimal Price { get; set; }


        [Display(Name = "Product Description")]
        public string Description { get; set; }


        [Display(Name = "Product Slug")]
        [Required(ErrorMessage = "This field is required")]
        [RegularExpression(@".*\S+.*", ErrorMessage = "No white space allowed")]
        [StringLength(80, MinimumLength = 3, ErrorMessage = "The slug must be between 3 and 80 characters long")]
        public string Slug { get; set; }


        [Display(Name = "Category", Description = "Choose one or more from the drop-down list")]
        public List<string> ProductCategoryList { get; set; }
        public string ProductCategoryString { get; set; }


        
        public List<string> ImageList { get; set; }
        public string ImageString { get; set; }
        public string ImageLocation { get; set; }


        [Display(Name = "Is the Product Available?", Description = "Untick this if the Product should not be visible")]
        public bool IsActive { get; set; }
    }
}