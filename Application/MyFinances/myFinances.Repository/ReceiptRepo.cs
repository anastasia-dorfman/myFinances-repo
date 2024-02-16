using DAL;
using MyFinances.Model;
using MyFinances.Types;
using System.Data;

namespace myFinances.Repository
{
    public class ReceiptRepo
    {
        #region Fields

        private readonly DataAccess db = new();

        #endregion

        #region Public Methods
        /// <summary>
        /// Retrieves all receipts
        /// </summary>
        /// <returns></returns>
        public List<ReceiptDTO> RetrieveAllWithDetails()
        {
            DataTable dt = db.Execute("spGetAllReceiptsWithDetails");

            return dt.AsEnumerable().Select(row => new ReceiptDTO
            {
                ReceiptId = Convert.ToInt32(row["Id"]),
                Date = Convert.ToDateTime(row["Date"]),
                Comment = row["Comment"].ToString(),
                IsRecurring = Convert.ToBoolean(row["IsRecurring"]),
                AccountName = row["AccountName"].ToString(),
                RetailerName = row["RetailerName"].ToString()
            }).ToList();
        }

        public Receipt Retrieve(int id)
        {
            DataTable dt = db.Execute("spGetReceipt",
                new List<ParmStruct> { new ParmStruct("@ReceiptId", SqlDbType.Int, id) });

            return dt.Rows.Count > 0 ? PopulateReceipt(dt.Rows[0]) : null;
        }

        public ReceiptProductsDTO RetrieveWithProducts(int receiptId)
        {
            DataTable dt = db.Execute("spGetReceiptWithProducts",
                new List<ParmStruct> { new ParmStruct("@ReceiptId", SqlDbType.Int, receiptId) });

            if (dt.Rows.Count > 0)
            {
                ReceiptDTO details = PopulateReceiptDTO(dt.Rows[0]);
                List<ProductReceiptDTO> products;

                if (dt.Rows[0]["ProductId"] != DBNull.Value)
                {
                    products = dt.AsEnumerable().Select(row => new ProductReceiptDTO
                    {
                        ProductId = Convert.ToInt32(row["ProductId"]),
                        ReceiptId = Convert.ToInt32(row["ReceiptId"]),
                        Name = row["Name"].ToString(),
                        ProductCategory = row["ProductCategory"].ToString(),
                        ProductSubcategory = row["ProductSubcategory"].ToString(),
                        ReceiptDate = Convert.ToDateTime(row["ReceiptDate"]),
                        Price = Convert.ToDecimal(row["Price"]),
                        Quantity = Convert.ToDouble(row["Quantity"]),
                        Amount = Convert.ToDouble(row["Amount"])
                    }).ToList();
                }
                else
                {
                    products = null;
                }

                return new ReceiptProductsDTO { Details = details, Products = products };
            }
            return null;
        }

        public Receipt Create(Receipt r)
        {
            List<ParmStruct> parms = new()
            {
                new("@ReceiptId", SqlDbType.Int, r.ReceiptId, 0, ParameterDirection.Output),
                new("@AccountId", SqlDbType.Int, r.AccountId),
                new("@Date", SqlDbType.DateTime2, r.Date),
                new("@RetailerId", SqlDbType.Int, r.RetailerId),
                new("@Comment", SqlDbType.NText, r.Comment),
                new("@IsRecurring", SqlDbType.Bit, r.IsRecurring),
                new ("@ReceiptProducts", SqlDbType.Structured, CreateReceiptProductsDT(r.Products))
            };

            if (db.ExecuteNonQuery("spInsertReceipt", parms) > 0)
            {
                r.ReceiptId = (int?)parms.FirstOrDefault(parm => parm.Name == "@ReceiptId")!.Value ?? 0;
                r.RecordVersion = (byte[]?)parms.FirstOrDefault(parm => parm.Name == "@RecordVersion")!.Value;
            }
            else
                throw new DataException("There was an issue adding the record to the database.");

            return r;
        }
        //public Recipe Update(Recipe r)
        //{
        //    List<ParmStruct> parms = new()
        //    {
        //        new("@Id", SqlDbType.Int, r.Id),
        //        new("@Title", SqlDbType.NVarChar, r.Title, 100),
        //        new("@Yield", SqlDbType.Int, r.Yield),
        //        new("@DateAdded", SqlDbType.DateTime2, r.DateAdded),
        //        new("@Archived", SqlDbType.Bit, r.Archived),
        //        new("@ChefId", SqlDbType.Int, r.ChefId),
        //        new("@RecipeTypeId", SqlDbType.Int, r.RecipeTypeId)
        //    };

        //    db.ExecuteNonQuery("spUpdateRecipe", parms);
        //    return r;
        //}

        #endregion

        #region Private Methods

        private Receipt PopulateReceipt(DataRow row)
        {
            return new()
            {
                ReceiptId = Convert.ToInt32(row["Id"]),
                Date = Convert.ToDateTime(row["Date"]),
                Comment = row["Comment"].ToString(),
                IsRecurring = Convert.ToBoolean(row["IsRecurring"]),
                AccountId = Convert.ToInt32(row["AccountId"]),
                RetailerId = Convert.ToInt32(row["RecipeId"]),
            };
        }
        private ReceiptDTO PopulateReceiptDTO(DataRow row)
        {
            return new()
            {
                ReceiptId = Convert.ToInt32(row["Id"]),
                Date = Convert.ToDateTime(row["Date"]),
                Comment = row["Comment"].ToString(),
                IsRecurring = Convert.ToBoolean(row["IsRecurring"]),
                AccountName = row["AccountName"].ToString(),
                RetailerName = row["RetailerName"].ToString(),
            };
        }

        private DataTable CreateReceiptProductsDT(List<ReceiptProduct> receiptProducts)
        {
            DataTable dt = new();
            dt.Columns.Add("ReceiptId", typeof(int));
            dt.Columns.Add("ProductId", typeof(int));
            dt.Columns.Add("Consumer", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("Quantity", typeof(double));
            dt.Columns.Add("Amount", typeof(decimal));

            foreach (ReceiptProduct rp in receiptProducts)
            {
                dt.Rows.Add(rp.ReceiptId, rp.ProductId, rp.Price, rp.Quantity, rp.Amount);
            }

            return dt;
        }
        #endregion
    }
}
