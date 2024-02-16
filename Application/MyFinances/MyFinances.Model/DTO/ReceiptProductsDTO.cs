
namespace MyFinances.Model
{
    public class ReceiptProductsDTO
    {
        public ReceiptDTO Details { get; set; }
        public List<ProductReceiptDTO> Products { get; set; }
    }
}
