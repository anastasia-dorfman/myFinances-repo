using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFinances.Model
{
    public class ProductSubcategoryDTO
    {
        public int ProductSubcategoryId { get; set; }
        public string? Name { get; set; }
        public ProductCategory ProductCategory { get; set; }
    }
}
