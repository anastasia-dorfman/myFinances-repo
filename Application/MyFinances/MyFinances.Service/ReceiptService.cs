using MyFinances.Model;
using myFinances.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFinances.Service
{
    public class ReceiptService
    {
        #region Fields
        private readonly ReceiptRepo repo = new();
        #endregion

        #region Private Methods
        public List<ReceiptDTO> GetAllReceipts()
        {
            return repo.RetrieveAllWithDetails();
        }

        public Receipt GetReceipt(int receiptId)
        {
            return repo.Retrieve(receiptId);
        }

        public ReceiptProductsDTO GetReceiptWithProducts(int receiptId)
        {
            return repo.RetrieveWithProducts(receiptId);
        }

        public Receipt Create(Receipt r)
        {
            return repo.Create(r);
        }
        #endregion
    }
}
