using myFinances.Repository;
using MyFinances.Model;

namespace MyFinances.Service
{
    public class LookupsService
    {
        #region Fields
        private readonly LookupsRepo repo = new();
        #endregion

        #region Public Methods
        public List<ProductCategory> GetProductCategories()
        {
            return repo.RetrieveProductCategories();
        }

        public List<ProductSubcategory> GetProductSubcategories()
        {
            return repo.RetrieveProductSubcategories();
        }

        public IDictionary<int, int> GetSubcategoryToCategoryMapping()
        {
            return repo.RetrieveSubcategoryToCategoryMapping();
        }

        public List<ProductSubcategory> GetProductSubcategoriesByCategory(int categoryId)
        {
            return repo.RetrieveProductSubcategoriesByCategory(categoryId);
        }

        public int GetCategoryIdBySubcategory(int subcategoryId)
        {
            return repo.RetrieveCategoryIdBySubcategory(subcategoryId);
        }

        public int GetSubcategoryIdByProduct(int productId)
        {
            return repo.RetrieveSubcategoryIdByProduct(productId);
        }

        public int GetCategoryIdByProduct(int productId)
        {
            return repo.RetrieveCategoryIdByProduct(productId);
        }

        public List<Product> GetProductsBySubcategory(int subcategoryId)
        {
            return repo.RetrieveProductsBySubcategory(subcategoryId);
        }

        public List<Product> GetProductsByCategory(int categoryId)
        {
            return repo.RetrieveProductsByCategory(categoryId);
        }

        public List<Product> GetProducts()
        {
            return repo.RetrieveProducts();
        }

        public List<String?> GetConsumers()
        {
            return repo.RetrieveConsumers();
        }

        public List<Account> GetAccounts()
        {
            return repo.RetrieveAccounts();
        }

        public IEnumerable<Retailer> GetRetailers()
        {
            return repo.RetrieveRetailers();
        }

        #endregion
    }
}
