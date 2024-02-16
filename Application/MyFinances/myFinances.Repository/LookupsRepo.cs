using DAL;
using MyFinances.Model;
using System.Data;

namespace myFinances.Repository
{
    public class LookupsRepo
    {
        private readonly DataAccess db = new();

        public List<ProductCategory> RetrieveProductCategories()
        {
            DataTable dt = db.Execute("spGetProductCategories");

            return dt.AsEnumerable().Select(row => new ProductCategory
            {
                ProductCategoryId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString()
            }).ToList();
        }

        public List<ProductSubcategory> RetrieveProductSubcategories()
        {
            DataTable dt = db.Execute("spGetProductSubcategories");

            return dt.AsEnumerable().Select(row => new ProductSubcategory
            {
                ProductSubcategoryId = Convert.ToInt32(row["Id"]),
                ProductCategoryId = Convert.ToInt32(row["ProductCategoryId"]),
                Name = row["Name"].ToString()
            }).ToList();
        }

        public IDictionary<int, int> RetrieveSubcategoryToCategoryMapping()
        {
            IDictionary<int, int> mapping = new Dictionary<int, int>();

            DataTable dt = db.Execute("spGetSubcategoryToCategoryMapping");

            foreach (DataRow row in dt.Rows)
            {
                int subcategoryId = Convert.ToInt32(row["SubcategoryId"]);
                int categoryId = Convert.ToInt32(row["CategoryId"]);

                mapping.Add(subcategoryId, categoryId);
            }

            return mapping;
        }

        public List<ProductSubcategory> RetrieveProductSubcategoriesByCategory(int categoryId)
        {
            DataTable dt = db.Execute(
                "spGetProductSubcategoriesByCategory",
                new() { new("@ProductCategoryId", SqlDbType.Int, categoryId) });

            return dt.AsEnumerable().Select(row => new ProductSubcategory
            {
                ProductSubcategoryId = Convert.ToInt32(row["Id"]),
                ProductCategoryId = categoryId,
                Name = row["Name"].ToString()
            }).ToList();
        }

        public int RetrieveCategoryIdBySubcategory(int subcategoryId)
        {
            return Convert.ToInt32(db.ExecuteScalar(
                "spGetProductCategoryIdBySubcategory",
                new() { new("@ProductSubcategoryId", SqlDbType.Int, subcategoryId) }));
        }

        public int RetrieveSubcategoryIdByProduct(int productId)
        {
            return Convert.ToInt32(db.ExecuteScalar("spGetSubcategoryIdByProduct", new() { new("@ProductId", SqlDbType.Int, productId) }));
        }

        public int RetrieveCategoryIdByProduct(int productId)
        {
            return Convert.ToInt32(db.ExecuteScalar("spGetCategoryIdByProduct", new() { new("@ProductId", SqlDbType.Int, productId) }));
        }

        public List<Product> RetrieveProductsBySubcategory(int subcategoryId)
        {
            DataTable dt = db.Execute("spGetProductsBySubcategory", new() { new("@ProductSubcategoryId", SqlDbType.Int, subcategoryId) });

            return dt.AsEnumerable().Select(row => new Product
            {
                ProductSubcategoryId = Convert.ToInt32(row["ProductSubcategoryId"]),
                ProductId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString()
            }).ToList();
        }

        public List<Product> RetrieveProductsByCategory(int categoryId)
        {
            DataTable dt = db.Execute("spGetProductsByCategory", new() { new("@ProductCategoryId", SqlDbType.Int, categoryId) });

            return dt.AsEnumerable().Select(row => new Product
            {
                ProductSubcategoryId = Convert.ToInt32(row["ProductCategoryId"]),
                ProductId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString()
            }).ToList();
        }

        public List<Product> RetrieveProducts()
        {
            DataTable dt = db.Execute("spGetAllProducts");

            return dt.AsEnumerable().Select(row => new Product
            {
                ProductId = Convert.ToInt32(row["ProductId"]),
                Name = row["Name"].ToString(),
                ProductSubcategoryId = Convert.ToInt32(row["ProductSubcategoryId"])
            }).ToList();
        }

        public List<String?> RetrieveConsumers()
        {
            DataTable dt = db.Execute("spGetConsumers");

            return dt.AsEnumerable().Select(row => row["Name"].ToString()).ToList();
        }

        public List<Account> RetrieveAccounts()
        {
            DataTable dt = db.Execute("spGetAccounts");

            return dt.AsEnumerable().Select(row => new Account
            {
                AccountId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString()
            }).ToList();
        }

        public IEnumerable<Retailer> RetrieveRetailers()
        {
            DataTable dt = db.Execute("spGetRetailers");

            return dt.AsEnumerable().Select(row => new Retailer
            {
                RetailerId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString()
            }).ToList();
        }
    }
}
