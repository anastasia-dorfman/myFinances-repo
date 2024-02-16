using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class ProductCategory
    {
        [Display(Name = "Id")]
        public int ProductCategoryId { get; set; }

        [Required(ErrorMessage = "Name is required.")]
        [StringLength(40, ErrorMessage = "Name cannot exceed 40 characters in length.")]
        public string? Name { get; set; }
    }
}
