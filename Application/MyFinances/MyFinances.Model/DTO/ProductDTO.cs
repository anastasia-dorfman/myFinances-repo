
using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class ProductDTO
    {
        public int ProductId { get; set; }
        public string Name { get; set; }

        [Display(Name = "Product Subcategory")]
        public string ProductSubcategoryName { get; set; }

        [Display(Name = "Product Category")]
        public string ProductCategoryName { get; set; }
    }
}
