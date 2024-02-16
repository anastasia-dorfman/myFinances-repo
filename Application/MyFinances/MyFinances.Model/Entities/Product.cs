using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class Product : BaseEntity
    {
        [Display(Name = "Id")]
        public int ProductId { get; set; }

        [Required(ErrorMessage = "Name is required.")]
        [StringLength(30, ErrorMessage = "Name cannot exceed 30 characters in length.")]
        public string? Name { get; set; }

        [Display(Name = "Subcategory")]
        [Required(ErrorMessage = "Please choose a product subcategory.")]
        public int? ProductSubcategoryId { get; set; }

        public byte[]? RecordVersion { get; set; }
    }
}
