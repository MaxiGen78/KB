using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace KozhaBeauty.Models
{
    public class ProductImageModel
    {
        public int Id { get; set; }
        public int? ProductId { get; set; }

        [StringLength(200, ErrorMessage = "Name must be no longer than 200 characters")]
        public string Name { get; set; }

    }
}