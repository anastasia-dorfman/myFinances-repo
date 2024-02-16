using DAL;
using MyFinances.Model;
using MyFinances.Types;
using System.Data;

namespace myFinances.Repository
{
    public class ProductRepo
    {
        #region Fields

        private readonly DataAccess db = new();

        #endregion

        #region Public Methods
        /// <summary>
        /// Retrieves all receipts
        /// </summary>
        /// <returns></returns>
        public List<ProductDTO> RetrieveAll()
        {
            DataTable dt = db.Execute("spGetAllProducts");

            return dt.AsEnumerable().Select(row => new ProductDTO
            {
                ProductId = Convert.ToInt32(row["ProductId"]),
                Name = row["Name"].ToString(),
                ProductCategoryName = (row["ProductCategoryName"]).ToString(),
                ProductSubcategoryName = (row["ProductSubcategoryName"]).ToString()
            }).ToList();
        }

        public Product? Retrieve(int id)
        {
            DataTable dt = db.Execute("spGetProduct",
                new List<ParmStruct> { new ParmStruct("@ProductId", SqlDbType.Int, id) });

            return dt.Rows.Count > 0 ? PopulateProduct(dt.Rows[0]) : null;
        }

        public ProductWithPrices RetrieveWithPrices(int productId)
        {
            DataTable dt = db.Execute("spGetProductsWithPrices",
                new List<ParmStruct> { new ParmStruct("@ProductId", SqlDbType.Int, productId) });

            if (dt.Rows.Count > 0)
            {
                var row = dt.Rows[0];

                List<ProductPrice> prices = new List<ProductPrice>();

                if (row["Price"] != DBNull.Value)
                {
                    prices = dt.AsEnumerable().Select(row => new ProductPrice
                    {
                        Date = Convert.ToDateTime(row["Date"]),
                        RetailerId = Convert.ToInt32(row["RetailerId"]),
                        RetailerName = (row["RetailerName"]).ToString(),
                        Price = Convert.ToDecimal(row["RetailerId"])
                    }).ToList();
                }

                return PopulateProductDTO(row, prices);
            }
            return null;
        }

        public Product Create(Product p)
        {
            List<ParmStruct> parms = new()
            {
                new("@Id", SqlDbType.Int, p.ProductId, 0, ParameterDirection.Output),
                new("@RecordVersion", SqlDbType.Timestamp, p.RecordVersion, 0, ParameterDirection.Output),
                new("@Name", SqlDbType.NVarChar, p.Name, 30),
                new("@SubcategoryId", SqlDbType.Int, p.ProductSubcategoryId)
            };

            if (db.ExecuteNonQuery("spInsertProduct", parms) > 0)
            {
                p.ProductId = (int?)parms.FirstOrDefault(p => p.Name == "@Id")!.Value ?? 0;
                p.RecordVersion = (byte[]?)parms.FirstOrDefault(p => p.Name == "@RecordVersion")!.Value;
            }
            else
                throw new DataException("There was an issue adding the record to the database.");

            return p;
        }


        public Product Update(Product p)
        {
            List<ParmStruct> parms = new()
            {
                new("@Id", SqlDbType.Int, p.ProductId),
                new("@RecordVersion", SqlDbType.Timestamp, p.RecordVersion, 0, ParameterDirection.Output),
                new("@Name", SqlDbType.NVarChar, p.Name, 30),
                new("@SubcategoryId", SqlDbType.Int, p.ProductSubcategoryId)
            };

            if (db.ExecuteNonQuery("spUpdateProduct", parms) > 0)
            {
                p.RecordVersion = (byte[]?)parms.FirstOrDefault(p => p.Name == "@RecordVersion")!.Value;
            }
            else
                throw new DataException("There was an issue updating the record to the database.");

            return p;
        }

        public bool Delete(Product p)
        {
            List<ParmStruct> parms = new()
            {
                new("@Id", SqlDbType.Int, p.ProductId),
                new("@RecordVersion", SqlDbType.Timestamp, p.RecordVersion),
            };

            return db.ExecuteNonQuery("spDeleteProduct", parms) > 0;
        }
        #endregion

        #region Private Methods

        private Product PopulateProduct(DataRow row)
        {
            return new()
            {
                ProductId = Convert.ToInt32(row["ProductId"]),
                Name = row["Name"].ToString(),
                ProductSubcategoryId = Convert.ToInt32(row["ProductSubcategoryId"])
            };
        }
        private ProductWithPrices PopulateProductDTO(DataRow row, List<ProductPrice> prices)
        {
            return new()
            {
                ProductId = Convert.ToInt32(row["ProductId"]),
                Name = row["ProductName"].ToString(),
                ProductSubcategoryName = row["ProductSubcategoryName"].ToString(),
                ProductCategoryName = row["ProductCategoryName"].ToString(),
                Prices = prices
            };
        }

        #endregion
    }
}
