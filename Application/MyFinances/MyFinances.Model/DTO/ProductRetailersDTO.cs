
using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class ProductRetailersDTO
    {
        public int ProductId { get; set; }
        public int RetailerId { get; set; }
        public string RetailerName { get; set; }
        public List<DateTime> ReceiptDate { get; set; }
        public List<Decimal> Price { get; set; }
    }
}
