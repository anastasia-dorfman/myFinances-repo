using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using MyFinances.Model;
using MyFinances.Models;
using MyFinances.Service;
using System.Diagnostics;

namespace MyFinances.Controllers
{
    public class SubcategoryController : Controller
    {
        private readonly SubcategoryService service = new();
        private readonly LookupsService lookupsService = new();

        // GET: SubcategoryController
        public ActionResult Index()
        {
            return View(service.GetProductSubcategories());
        }

        // GET: SubcategoryController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: SubcategoryController/Create
        public ActionResult Create()
        {
            SubcategoryCreateEditVM vm = new()
            {
                ProductSubcategory = new ProductSubcategory(),
                ProductCategories = GetProductCategories()
            };

            return View(vm);
        }

        // POST: SubcategoryController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(SubcategoryCreateEditVM vm)
        {
            try
            {
                vm.ProductSubcategory = service.Create(vm.ProductSubcategory);

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                vm.ProductCategories = GetProductCategories();
                return View(vm);
            }
        }

        // GET: SubcategoryController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: SubcategoryController/Edit/5
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

        // GET: SubcategoryController/Delete/5
        public ActionResult Delete(int? id)
        {
            try
            {
                if (id == null)
                    return new BadRequestResult();

                ProductSubcategoryDTO s = service.GetProductSubcategoryDTO(id.Value);

                if (s == null)
                    return new NotFoundResult();

                return View(s);
            }
            catch (Exception ex)
            {
                return ShowError(ex);
            }
        }

        // POST: SubcategoryController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                service.Delete(id);
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
