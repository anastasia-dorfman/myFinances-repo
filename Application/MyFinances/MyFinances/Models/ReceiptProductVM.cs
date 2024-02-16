using Microsoft.AspNetCore.Mvc.Rendering;
using MyFinances.Model;

namespace MyFinances.Models
{
    public class ReceiptProductVM
    {
        //public ReceiptProduct ReceiptProduct { get; set; }
        public IEnumerable<SelectListItem> ProductCategories { get; set; }
        public IEnumerable<SelectListItem> ProductSubcategories { get; set; }
        public IEnumerable<SelectListItem> Products { get; set; }
        public IEnumerable<SelectListItem> Consumers { get; set; }
        public ReceiptProduct ReceiptProduct { get; set; }
        //public double Quantity { get; set; }
        //public decimal Price { get; set; }
        //public decimal Amount { get; set; }
    }
}
