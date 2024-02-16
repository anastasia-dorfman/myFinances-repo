using myFinances.Repository;
using MyFinances.Model;
using MyFinances.Types;
using System.ComponentModel.DataAnnotations;

namespace MyFinances.Service
{
    public class ProductService
    {
        #region Fields
        private readonly ProductRepo repo = new();
        #endregion

        #region Public Methods
        public List<ProductDTO> GetAllProducts()
        {
            return repo.RetrieveAll();
        }

        public Product GetProduct(int productId)
        {
            return repo.Retrieve(productId);
        }

        public ProductWithPrices GetProductsWithPrices(int productId)
        {
            return repo.RetrieveWithPrices(productId);
        }

        public Product Create(Product p)
        {
            if (ValidateProduct(p))
                return repo.Create(p);

            return p;
        }

        public Product Update(Product p)
        {
            if (ValidateProduct(p))
                return repo.Update(p);

            return p;
        }
        #endregion

        #region Private Methods
        private bool ValidateProduct(Product p)
        {
            List<ValidationResult> results = new();

            Validator.TryValidateObject(p, new ValidationContext(p), results, true);

            foreach (ValidationResult e in results)
            {
                p.AddError(new(e.ErrorMessage, ErrorType.Model));
            }

            // Business Rules
            //if (!IsChefTypeMatchRecipeType(r.ChefId, r.RecipeTypeId))
            //    r.AddError(new("Pastry chefs can only add desserts", ErrorType.Business));


            return p.Errors.Count == 0;
        }

        #endregion
    }
}
