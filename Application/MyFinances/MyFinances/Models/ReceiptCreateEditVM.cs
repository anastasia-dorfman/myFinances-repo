using Microsoft.AspNetCore.Mvc.Rendering;
using MyFinances.Model;
using System.ComponentModel.DataAnnotations;

namespace MyFinances.Models
{
    public class ReceiptCreateEditVM
    {
        public Receipt Receipt { get; set; }

        public IEnumerable<SelectListItem> Accounts { get; set; }
        public IEnumerable<SelectListItem> Retailers { get; set; }

        [Display(Name = "Add Products")]
        [Required(ErrorMessage = "At least 1 product is required.")]
        public List<ReceiptProductVM> ReceiptProducts { get; set; }

    }
}
