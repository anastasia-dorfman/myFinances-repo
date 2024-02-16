using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using MyFinances.Model;
using MyFinances.Models;
using MyFinances.Service;
using System.Diagnostics;

namespace MyFinances.Controllers
{
    public class ReceiptController : Controller
    {
        private readonly ReceiptService service = new();
        private readonly LookupsService lookupsService = new();

        // GET: ReceiptController
        public ActionResult Index()
        {
            return View(service.GetAllReceipts());
        }

        // GET: ReceiptController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: ReceiptController/Create
        public ActionResult Create()
        {
            ReceiptCreateEditVM vm = new()
            {
                Receipt = new Receipt(),
                ReceiptProducts = new List<ReceiptProductVM>
                {
                    new ReceiptProductVM
                    {
                        ProductCategories = GetProductCategories(),
                        ProductSubcategories = GetProductSubcategories(),
                        Products = GetProducts(),
                        Consumers = GetConsumers(),
                        ReceiptProduct = new ReceiptProduct()
                    }
                }
            };

            vm.Accounts = GetAccounts();
            vm.Retailers = GetRetailers();

            return View(vm);
        }

        public IActionResult GetReceiptProductPartial()
        {
            ReceiptProductVM vm = new ReceiptProductVM
            {
                ProductCategories = GetProductCategories(),
                ProductSubcategories = GetProductSubcategories(),
                Products = GetProducts(),
                Consumers = GetConsumers(),
                ReceiptProduct = new ReceiptProduct()
            };

            return PartialView("_ReceiptProductPartial", vm);
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
        public IActionResult GetProductsBySubcategory(int subcategoryId)
        {
            var products = subcategoryId != 0
                ? GetProductsBySubcategoryId(subcategoryId)
                : GetProducts();
            return Json(products);
        }

        [HttpGet]
        public IActionResult GetProductsByCategory(int categoryId)
        {
            var products = categoryId != 0
                ? GetProductsByCategoryId(categoryId)
                : GetProducts();
            return Json(products);
        }

        [HttpGet]
        public IActionResult GetCategoryBySubcategory(int subcategoryId)
        {
            var categoryId = lookupsService.GetCategoryIdBySubcategory(subcategoryId);
            return Json(categoryId);
        }

        [HttpGet]
        public IActionResult GetSubcategoryByProduct(int productId)
        {
            var subcategoryId = lookupsService.GetSubcategoryIdByProduct(productId);
            return Json(subcategoryId);
        }

        [HttpGet]
        public IActionResult GetCategoryByProduct(int productId)
        {
            var categoryId = lookupsService.GetCategoryIdByProduct(productId);
            return Json(categoryId);
        }

        // POST: ReceiptController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(ReceiptCreateEditVM vm, int categoryId)
        {
            try
            {
                vm.Receipt = service.Create(vm.Receipt);

                if (vm.Receipt.Errors.Count == 0)
                    return RedirectToAction(nameof(Index));

                vm.Accounts = GetAccounts();
                vm.Retailers = GetRetailers();

                vm.ReceiptProducts = new List<ReceiptProductVM>
                {
                    new ReceiptProductVM
                    {
                        ProductCategories = GetProductCategories(),
                        ProductSubcategories = GetProductCategories(),
                        Products = GetProducts(),
                        Consumers = GetConsumers(),
                        ReceiptProduct = new ReceiptProduct()
                    }
                };

                return View(vm);
            }
            catch
            {
                return View();
            }
        }

        // GET: ReceiptController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: ReceiptController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
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

        // GET: ReceiptController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: ReceiptController/Delete/5
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
                    .Select(s => new SelectListItem
                    {
                        Value = s.ProductSubcategoryId.ToString(),
                        Text = s.Name
                    }).ToList();
        }

        private List<SelectListItem> GetProductSubategoriesByCategory(int categoryId)
        {
            return lookupsService.GetProductSubcategoriesByCategory(categoryId)
                    .Select(s => new SelectListItem
                    {
                        Value = s.ProductSubcategoryId.ToString(),
                        Text = s.Name
                    }).ToList();
        }

        private List<SelectListItem> GetProductsBySubcategoryId(int subcategoryId)
        {
            return lookupsService.GetProductsBySubcategory(subcategoryId)
                    .Select(p => new SelectListItem
                    {
                        Value = p.ProductId.ToString(),
                        Text = p.Name
                    }).ToList();
        }

        private List<SelectListItem> GetProductsByCategoryId(int categoryId)
        {
            return lookupsService.GetProductsByCategory(categoryId)
                    .Select(p => new SelectListItem
                    {
                        Value = p.ProductId.ToString(),
                        Text = p.Name
                    }).ToList();
        }

        private IEnumerable<SelectListItem> GetConsumers()
        {
            return lookupsService.GetConsumers()
                    .Select(c => new SelectListItem
                    {
                        Value = c,
                        Text = c
                    }).ToList();
        }

        private IEnumerable<SelectListItem> GetProducts()
        {
            return lookupsService.GetProducts()
                     .Select(p => new SelectListItem
                     {
                         Value = p.ProductId.ToString(),
                         Text = p.Name
                     }).ToList();
        }

        private IEnumerable<SelectListItem> GetAccounts()
        {
            return lookupsService.GetAccounts()
                     .Select(a => new SelectListItem
                     {
                         Value = a.AccountId.ToString(),
                         Text = a.Name
                     }).ToList();
        }

        private IEnumerable<SelectListItem> GetRetailers()
        {
            return lookupsService.GetRetailers()
                     .Select(r => new SelectListItem
                     {
                         Value = r.RetailerId.ToString(),
                         Text = r.Name
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
