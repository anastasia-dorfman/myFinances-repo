
using System.ComponentModel.DataAnnotations;

namespace MyFinances.Model
{
    public class ReceiptProduct
    {
        private decimal price;
        private double quantity = 1; // Default value for Quantity is 1

        public string? Consumer { get; set; }
        public int ReceiptId { get; set; }
        public int ProductId { get; set; }

        [Range(0.01, double.MaxValue, ErrorMessage = "Quantity must be greater than or equal to 0.01")]
        public double Quantity
        {
            get { return quantity; }
            set
            {
                quantity = value;
                CalculateAmount();
            }
        }

        [Required(ErrorMessage = "Price is required")]
        public decimal Price
        {
            get { return price; }
            set
            {
                price = value;
                CalculateAmount();
            }
        }

        public decimal Amount { get; private set; }

        private void CalculateAmount()
        {
            Amount = Price * (decimal)Quantity;
        }
    }
}
