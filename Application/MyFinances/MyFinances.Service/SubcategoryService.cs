using MyFinances.Model;
using myFinances.Repository;

namespace MyFinances.Service
{
    public class SubcategoryService
    {
        #region Fields
        private readonly SubcategoryRepo repo = new();
        #endregion

        #region Public Methods

        public List<ProductSubcategoryDTO> GetProductSubcategories()
        {
            return repo.RetrieveProductSubcategories();
        }

        public ProductSubcategory GetProductSubcategory(int id)
        {
            return repo.RetrieveSubcategory(id);
        }

        public ProductSubcategoryDTO GetProductSubcategoryDTO(int id)
        {
            return repo.RetrieveSubcategoryDTO(id);
        }

        public ProductSubcategory Create(ProductSubcategory ps)
        {
            return repo.Create(ps);
        }

        public bool Delete(int psId)
        {
            return repo.Delete(psId);
        }

        //public void Update(ProductSubcategory ps) { }
        #endregion
    }
}
