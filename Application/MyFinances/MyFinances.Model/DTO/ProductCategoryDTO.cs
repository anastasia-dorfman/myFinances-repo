namespace MyFinances.Model
{
    public class ProductCategoryDTO
    {
        public ProductCategory Category { get; set; }
        public List<ProductSubcategory> Subcategories { get; set; }
    }
}
