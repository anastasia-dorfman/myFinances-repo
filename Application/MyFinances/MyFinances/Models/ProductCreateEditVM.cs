using Microsoft.AspNetCore.Mvc.Rendering;
using MyFinances.Model;
using System.ComponentModel.DataAnnotations;

namespace MyFinances.Models
{
    public class ProductCreateEditVM
    {
        public Product Product { get; set; }

        [Display(Name = "Product Category")]
        public IEnumerable<SelectListItem> ProductCategories { get; set; }
        public IEnumerable<SelectListItem> ProductSubcategories { get; set; }
        public int SelectedCategoryId { get; set; }
    }
}
