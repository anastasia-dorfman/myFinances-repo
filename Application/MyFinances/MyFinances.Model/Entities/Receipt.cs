using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class Receipt : BaseEntity
    {
        [Display(Name = "Id")]
        public int ReceiptId { get; set; }

        [Display(Name = "Account")]
        [Required(ErrorMessage = "Account is required.")]
        public int AccountId { get; set; }

        [Required(ErrorMessage = "Date is required.")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime Date { get; set; }

        [Display(Name = "Retailer")]
        [Required(ErrorMessage = "Retailer is required.")]
        public int RetailerId { get; set; }

        [StringLength(255, ErrorMessage = "Comment cannot exceed 255 characters in length.")]
        public string? Comment { get; set; }

        public bool IsRecurring { get; set; }

        public List<ReceiptProduct> Products { get; set; } = new();

        public byte[]? RecordVersion { get; set; }
    }
}
