using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFinances.Model
{
    public class ProductReceiptDTO
    {
        public int ProductId { get; set; }
        public int ReceiptId { get; set; }
        public string? Name { get; set; }
        public string? ProductSubcategory { get; set; }
        public string? ProductCategory { get; set; }
        public DateTime ReceiptDate { get; set; }
        public string? Consumer { get; set; }
        public decimal Price { get; set; }
        public double Quantity { get; set; }
        public double Amount { get; set; }
    }
}
