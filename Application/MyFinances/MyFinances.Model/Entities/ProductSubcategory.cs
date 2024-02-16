using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class ProductSubcategory
    {
        [Display(Name = "Id")]
        public int ProductSubcategoryId { get; set; }

        [Required(ErrorMessage = "Name is required.")]
        [StringLength(40, ErrorMessage = "Name cannot exceed 40 characters in length.")]
        public string? Name { get; set; }

        [Display(Name = "Category")]
        [Required(ErrorMessage = "Please choose a product category.")]
        public int ProductCategoryId { get; set; }
    }
}
