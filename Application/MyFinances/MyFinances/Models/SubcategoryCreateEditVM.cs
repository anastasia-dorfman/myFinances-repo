using Microsoft.AspNetCore.Mvc.Rendering;
using MyFinances.Model;

namespace MyFinances.Models
{
    public class SubcategoryCreateEditVM
    {
        public ProductSubcategory ProductSubcategory { get; set; }

        public IEnumerable<SelectListItem> ProductCategories { get; set; }
    }
}
