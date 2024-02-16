using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using MyFinances.Model;
using MyFinances.Models;
using MyFinances.Service;
using System.Diagnostics;

namespace MyFinances.Controllers
{
    public class ProductController : Controller
    {
        private readonly ProductService service = new();
        private readonly LookupsService lookupsService = new();

        // GET: ProductController
        public ActionResult Index()
        {
            return View(service.GetAllProducts());
        }

        // GET: ProductController/Details/5
        public ActionResult Details(int? id)
        {
            try
            {
                if (id == null)
                    return new BadRequestResult();

                ProductWithPrices p = service.GetProductsWithPrices(id.Value);

                if (p == null)
                    return new NotFoundResult();

                ProductWithPrices pwp = new()
                {
                    ProductId = p.ProductId,
                    Name = p.Name,
                    ProductSubcategoryName = p.ProductSubcategoryName,
                    ProductCategoryName = p.ProductCategoryName,
                    Prices = p.Prices
                };

                return View(pwp);
            }
            catch (Exception ex)
            {
                return ShowError(ex);
            }
        }

        // GET: ProductController/Create
        public ActionResult Create()
        {
            ProductCreateEditVM vm = new()
            {
                Product = new Product(),
                ProductCategories = GetProductCategories(),
                ProductSubcategories = GetProductSubcategories(),
                SelectedCategoryId = 0
            };

            return View(vm);
        }

        [HttpGet]
        public IActionResult GetSubcategoriesByCategory(int categoryId)
        {
            var subcategories = categoryId != 0
                ? GetProductSubategoriesByCategory(categoryId)
                : GetProductSubcategories();
            return Json(subcategories);
        }

        [HttpGet]
        public IActionResult GetCategoryBySubcategory(int subcategoryId)
        {
            var categoryId = lookupsService.GetCategoryIdBySubcategory(subcategoryId);
            return Json(categoryId);
        }

        // POST: ProductController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        //public ActionResult Create(IFormCollection collection)
        public ActionResult Create(ProductCreateEditVM vm, int categoryId)
        {
            try
            {
                vm.Product = service.Create(vm.Product);

                if (vm.Product.Errors.Count == 0)
                    return RedirectToAction(nameof(Index));

                vm.ProductCategories = GetProductCategories();
                vm.ProductSubcategories = GetProductSubcategories();
                vm.SelectedCategoryId = categoryId;

                return View(vm);
            }
            catch
            {
                return View();
            }
        }

        // GET: ProductController/Edit/5
        public ActionResult Edit(int? id)
        {
            try
            {
                if (id == null)
                    return new BadRequestResult();

                Product p = service.GetProduct(id.Value);

                if (id == null)
                    return new NotFoundResult();

                ProductCreateEditVM vm = new()
                {
                    Product = p,
                    ProductCategories = GetProductCategories(),
                    ProductSubcategories = GetProductSubcategories(),
                    SelectedCategoryId = lookupsService.GetCategoryIdBySubcategory((int)p.ProductSubcategoryId)
                };

                return View(vm);
            }
            catch (Exception ex)
            {
                return ShowError(ex);
            }
        }

        // POST: ProductController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(ProductCreateEditVM vm, int categoryId)
        {
            try
            {
                vm.Product = service.Update(vm.Product);

                if (vm.Product.Errors.Count == 0)
                    return RedirectToAction(nameof(Index));

                vm.ProductCategories = GetProductCategories();
                vm.ProductSubcategories = GetProductSubcategories();
                vm.SelectedCategoryId = categoryId;

                return View(vm);
            }
            catch (Exception ex)
            {
                return ShowError(ex);
            }
        }

        // GET: ProductController/Delete/5
        public ActionResult Delete(int? id)
        {
            try
            {
                if (id == null)
                    return new BadRequestResult();

                ProductWithPrices p = service.GetProductsWithPrices(id.Value);

                if (p == null)
                    return new NotFoundResult();

                ProductWithPrices pwp = new()
                {
                    ProductId = p.ProductId,
                    Name = p.Name,
                    ProductSubcategoryName = p.ProductSubcategoryName,
                    ProductCategoryName = p.ProductCategoryName,
                    Prices = p.Prices
                };

                return View(pwp);
            }
            catch (Exception ex)
            {
                return ShowError(ex);
            }
        }

        // POST: ProductController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        #region Private Methods

        private List<SelectListItem> GetProductCategories()
        {
            return lookupsService.GetProductCategories()
                    .Select(c => new SelectListItem
                    {
                        Value = c.ProductCategoryId.ToString(),
                        Text = c.Name
                    }).ToList();
        }

        private List<SelectListItem> GetProductSubcategories()
        {
            return lookupsService.GetProductSubcategories()
                    .Select(c => new SelectListItem
                    {
                        Value = c.ProductSubcategoryId.ToString(),
                        Text = c.Name
                    }).ToList();
        }

        private List<SelectListItem> GetProductSubategoriesByCategory(int categoryId)
        {
            return lookupsService.GetProductSubcategoriesByCategory(categoryId)
                    .Select(c => new SelectListItem
                    {
                        Value = c.ProductSubcategoryId.ToString(),
                        Text = c.Name
                    }).ToList();
        }

        private ActionResult ShowError(Exception ex)
        {
            return View("Error", new ErrorViewModel
            {
                RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier,
                Exception = ex
            });
        }

        #endregion
    }
}
