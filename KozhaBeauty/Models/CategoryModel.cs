using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace KozhaBeauty.Models
{
    public class CategoryModel
    {
        public int Id { get; set; }


        [Required(ErrorMessage = "This field is required")]
        [RegularExpression(@".*\S+.*", ErrorMessage = "No white space allowed")]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "Text must be between 3 and 50 characters long")]
        public string Name { get; set; }
    }
}