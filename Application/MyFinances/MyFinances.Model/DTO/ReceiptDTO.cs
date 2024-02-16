using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class ReceiptDTO
    {
        [Display(Name = "Id")]
        public int ReceiptId { get; set; }

        [Required(ErrorMessage = "Date is required.")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        //[Required(ErrorMessage = "Receipt date is required.")]
        public DateTime Date { get; set; }

        public string? Comment { get; set; }

        [Display(Name = "Recurring Receipt")]
        public bool IsRecurring { get; set; }

        [Display(Name = "Account")]
        [Required(ErrorMessage = "Please choose an account.")]
        public string AccountName { get; set; }

        [Display(Name = "Retailer")]
        [Required(ErrorMessage = "Please choose a retailer.")]
        public string RetailerName { get; set; }

        [Required(ErrorMessage = "At least 1 product is required.")]
        public List<ProductReceiptDTO> Products { get; set; }
    }
}
