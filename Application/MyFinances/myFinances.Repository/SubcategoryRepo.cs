using DAL;
using MyFinances.Model;
using MyFinances.Types;
using System.Data;

namespace myFinances.Repository
{
    public class SubcategoryRepo
    {
        private readonly DataAccess db = new();

        public List<ProductSubcategoryDTO> RetrieveProductSubcategories()
        {
            DataTable dt = db.Execute("spGetProductSubcategories");

            return dt.AsEnumerable().Select(row => new ProductSubcategoryDTO
            {
                ProductSubcategoryId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString(),
                ProductCategory = new()
                {
                    ProductCategoryId = Convert.ToInt32(row["ProductCategoryId"]),
                    Name = row["CategoryName"].ToString()
                }
            }).ToList();
        }

        public ProductSubcategory RetrieveSubcategory(int id)
        {
            DataTable dt = db.Execute("spGetProductSubcategory", new() { new("@Id", SqlDbType.Int, id) });

            return dt.Rows.Count > 0 ? PopulateSubcategory(dt.Rows[0]) : null;
        }

        public ProductSubcategoryDTO RetrieveSubcategoryDTO(int id)
        {
            DataTable dt = db.Execute("spGetProductSubcategory", new() { new("@Id", SqlDbType.Int, id) });

            return dt.Rows.Count > 0 ? PopulateSubcategoryDTO(dt.Rows[0]) : null;
        }

        public ProductSubcategory Create(ProductSubcategory ps)
        {
            List<ParmStruct> parms = new()
            {
                new("@Id", SqlDbType.Int, ps.ProductSubcategoryId, 0, ParameterDirection.Output),
                new("@Name", SqlDbType.NVarChar, ps.Name, 30),
                new("@CategoryId", SqlDbType.Int, ps.ProductCategoryId)
            };

            if (db.ExecuteNonQuery("spInsertSubcategory", parms) > 0)
            {
                ps.ProductSubcategoryId = (int?)parms.FirstOrDefault(p => p.Name == "@Id")!.Value ?? 0;
            }
            else
                throw new DataException("There was an issue adding the record to the database.");

            return ps;
        }

        public bool Delete(int psId)
        {
            return db.ExecuteNonQuery("spDeleteSubcategory", new() { new("@Id", SqlDbType.Int, psId) }) > 0;
        }

        #region Private Methods

        private ProductSubcategory PopulateSubcategory(DataRow row)
        {
            return new()
            {
                ProductSubcategoryId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString(),
                ProductCategoryId = Convert.ToInt32(row["ProductCategoryId"])
            };
        }

        private ProductSubcategoryDTO PopulateSubcategoryDTO(DataRow row)
        {
            return new()
            {
                ProductSubcategoryId = Convert.ToInt32(row["Id"]),
                Name = row["Name"].ToString(),
                ProductCategory = new()
                {
                    ProductCategoryId = Convert.ToInt32(row["ProductCategoryId"]),
                    Name = row["CategoryName"].ToString()
                }
            };
        }
        #endregion
    }
}
